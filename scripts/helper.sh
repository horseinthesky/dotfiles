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

download (){
  FILE_NAME=$(echo $1 | cut -d "/" -f 2)
  if [[ ! -f ${2}/$FILE_NAME ]]; then
    curl $FILE_NAME -o ${2}/$FILE_NAME
    echo $FILE_NAME downloaded
  else
    echo -e "${YELLOW}$FILE_NAME already exists${NORMAL}"
  fi
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
    echo -e "${GREEN}Done${NORMAL}"
  else
    CURRENT_VERSION=$($binary --version 2> /dev/null | grep -P -o "\d+\.\d+\.\d+")
    LATEST_VERSION=$(cargo search $tool | head -n 1 | awk '{print $3}' | tr -d '"')

    if [[ $CURRENT_VERSION < $LATEST_VERSION ]]; then
      cargo install $tool --force
      echo -e "${YELLOW}Updated to latest ($LATEST_VERSION) version.${NORMAL}"
    else
      echo -e "${YELLOW}Latest ($LATEST_VERSION) version is already installed${NORMAL}"
    fi
  fi
}

go_get () {
  echo -e "\n${LIGHTMAGENTA}Installing ${1}...${NORMAL}"

  PATH=$HOME/.local/bin:$PATH

  if [[ -z $(which go) ]]; then
    echo -e "${LIGHTRED}Go is not found. Can't procced.${NORMAL}"
    return 0
  fi

  go get github.com/${1}

  echo -e "${GREEN}Done${NORMAL}"
}
