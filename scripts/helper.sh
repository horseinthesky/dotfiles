RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
GREY="\e[90m"
LIGHTRED="\e[91m"
LIGHTGREEN="\e[92m"
LIGHTYELLOW="\e[93m"
LIGHTBLUE="\e[94m"
LIGHTMAGENTA="\e[95m"
LIGHTCYAN="\e[96m"
LIGHTGREY="\e[37m"
WHITE="\e[97m"
NORMAL="\e[0m"

XDG_CONFIG_HOME=$HOME/.config
XDG_DATA_HOME=$HOME/.local/share
XDG_CACHE_HOME=$HOME/.cache

DOTFILES_HOME=$HOME/dotfiles/files

source /etc/os-release

install () {
  case $ID in
    debian|ubuntu)
      sudo apt-get update -y 1> /dev/null
      sudo apt-get install ${@} -y | grep -E "upgraded"
      ;;
    arch|manjaro)
      sudo pacman -Sy --noconfirm 1> /dev/null
      sudo pacman -S ${@} --noconfirm --needed
      ;;
  esac
}

download () {
  FILE_NAME=$(echo $1 | cut -d "/" -f 2)
  if [[ -f ${2}/$FILE_NAME ]]; then
    echo -e "${YELLOW}$FILE_NAME already exists${NORMAL}"
    return 0
  fi

  curl $FILE_NAME -o ${2}/$FILE_NAME
  echo $FILE_NAME downloaded
}

symlink () {
  if [[ -f ${2} ]] && [[ ! -L ${2} ]]; then
    cp ${2} ${2}.bak
    echo -e "${YELLOW}${2} backed up${NORMAL}"
  elif [[ -d ${2} ]] && [[ ! -L ${2} ]]; then
    cp -R ${2} ${2}.bak
    echo -e "${YELLOW}${2} backed up${NORMAL}"
  fi

  ln -snf ${1} ${2}
}

clone () {
  local path_prefix=${3:-}
  TOOL_NAME=$(echo ${1} | cut -d "/" -f 2)

  echo -e "\n${LIGHTMAGENTA}Installing $TOOL_NAME...${NORMAL}"

  if [[ ! -d ${2}/$path_prefix$TOOL_NAME ]]; then
    git clone -q https://github.com/${1}.git ${2}/$path_prefix$TOOL_NAME
    echo -e "${GREEN}$TOOL_NAME installed${NORMAL}"
  else
    echo -e "${YELLOW}$TOOL_NAME already exists. Updating...${NORMAL}"
    cd ${2}/$path_prefix$TOOL_NAME && git pull 1> /dev/null
    echo -e "${GREEN}Done${NORMAL}"
  fi
}

update_rust () {
  if [[ ! -d $HOME/.cargo ]]; then
    echo -e "${LIGHTRED}Cargo is not found. Can't procced.${NORMAL}"
    return 0
  fi

  PATH=$HOME/.cargo/bin:$PATH

  echo -e "\n${LIGHTMAGENTA}Checking for Rust updates...${NORMAL}"

  local current_toolchain_version=$(
    rustup show | \
    grep -P -o "rustc \d+\.\d+\.\d+" | \
    awk '{print $NF}'
  )
  local latest_toolchain_version=$(
    rustup check | \
    grep -P -o "Update available : \d+\.\d+\.\d+" | \
    awk '{print $NF}'
  )

  if [[ -z $latest_toolchain_version ]]; then
    echo -e "${GREEN}Latest ($current_toolchain_version) version is already installed${NORMAL}"
    return 0
  fi

  echo -e "${GREY}Newer version ($latest_toolchain_version) found. Updating...${NORMAL}"
  rustup update stable &> /dev/null

  if [[ $? -ne 0 ]]; then
    echo -e "${LIGHTRED}Failed to update Rust to the latest ($latest_toolchain_version) version${NORMAL}"
    return 0
  fi

  echo -e "${YELLOW}Rust updated to the latest ($latest_toolchain_version) version${NORMAL}"
}

cargo_install () {
  if [[ ! -d $HOME/.cargo ]]; then
    echo -e "${LIGHTRED}Cargo is not found. Can't procced.${NORMAL}"
    return 0
  fi

  PATH=$HOME/.cargo/bin:$PATH

  local tool binary
  IFS=, read -r tool binary <<< ${1}

  if [[ -z $binary ]]; then
    binary=$tool
  fi

  echo -e "\n${LIGHTMAGENTA}Installing $tool...${NORMAL}"

  if [[ -z $(which $binary) ]]; then
    cargo install $tool

    if [[ $? -ne 0 ]]; then
      echo -e "${LIGHTRED}Failed to install $tool.${NORMAL}"
      return 0
    fi

    echo -e "${GREEN}Done${NORMAL}"
    return 0
  fi

  CURRENT_VERSION=$($binary --version 2> /dev/null | grep -P -o "\d+\.\d+\.\d+" | head -n 1)
  LATEST_VERSION=$(cargo search $tool | head -n 1 | awk '{print $3}' | tr -d '"')

  if [[ $CURRENT_VERSION == $LATEST_VERSION ]]; then
    echo -e "${GREEN}Latest ($LATEST_VERSION) version is already installed${NORMAL}"
    return 0
  fi

  echo -e "${GREY}Newer version ($LATEST_VERSION) found. Updating...${NORMAL}"
  cargo install $tool --force

  if [[ $? -ne 0 ]]; then
    echo -e "${LIGHTRED}Failed to update $tool to the latest ($LATEST_VERSION) version${NORMAL}"
    return 0
  fi

  echo -e "${YELLOW}$tool updated to the latest ($LATEST_VERSION) version${NORMAL}"
}

go_get () {
  PATH=$HOME/.local/bin:$PATH

  if [[ -z $(which go) ]]; then
    echo -e "${LIGHTRED}Go is not found. Can't procced.${NORMAL}"
    return 0
  fi

  local TOOL_NAME=$(echo ${1} | awk -F/ '{print $NF}')
  echo -e "\n${LIGHTMAGENTA}Installing $TOOL_NAME...${NORMAL}"

  if [[ -n $(which $TOOL_NAME) ]]; then
    echo -e "${YELLOW}$TOOL_NAME already exists.${NORMAL}"
    return 0
  fi

  go get github.com/${1}
  echo -e "${GREEN}Done${NORMAL}"
}
