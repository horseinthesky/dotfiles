RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
LIGHTGREY="\e[37m"
GREY="\e[90m"
LIGHTRED="\e[91m"
LIGHTGREEN="\e[92m"
LIGHTYELLOW="\e[93m"
LIGHTBLUE="\e[94m"
LIGHTMAGENTA="\e[95m"
LIGHTCYAN="\e[96m"
WHITE="\e[97m"
NORMAL="\e[0m"

DOTFILES_HOME=$HOME/dotfiles/files

install () {
  source /etc/os-release

  case $ID_LIKE in
    debian)
      local package_manager=apt-get
      local update=update
      local noask=-y
      local install_command=install
      ;;
    "rhel fedora")
      local package_manager=yum
      local update=update
      local noask=-y
      local install_command=install
      ;;
    arch)
      local package_manager=pacman
      local update=-Sy
      local noask=--noconfirm
      local install_command=-S
      ;;
    *)
      case $ID in
        debian)
          local package_manager=apt-get
          local update=update
          local noask=-y
          local install_command=install
          ;;
        arch)
          local package_manager=pacman
          local update=-Sy
          local noask=--noconfirm
          local install_command=-S
          ;;
      esac
  esac

  sudo ${package_manager} ${update} ${noask}
  sudo ${package_manager} ${install_command} ${@} ${noask}
}

download (){
  FILE_NAME=$(echo $1 | cut -d "/" -f 2)
  if [[ ! -f ${2}/$FILE_NAME ]]; then
    curl $FILE_NAME -o ${2}/$FILE_NAME
    echo $FILE_NAME downloaded
  else
    echo -e "${YELLOW}$FILE_NAME already exits${NORMAL}"
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

  if [[ -L ${2} ]]; then
    echo -e "${YELLOW}${2} is already a symlink${NORMAL}"
    return 0
  fi

  ln -sf ${1} ${2}
  echo -e "${GREEN}Done${NORMAL}"
}

clone () {
  local path_prefix=${3:-}
  TOOL_NAME=$(echo $1 | cut -d "/" -f 2)

  echo -e "\n${LIGHTMAGENTA}Installing $TOOL_NAME...${NORMAL}"

  if [[ ! -d ${2}/$path_prefix$TOOL_NAME ]]; then
    git clone -q git@github.com:${1}.git ${2}/$path_prefix$TOOL_NAME
    echo -e "${GREEN}$TOOL_NAME installed${NORMAL}"
  else
    echo -e "${YELLOW}$TOOL_NAME already exits. Updating...${NORMAL}"
    cd ${2}/$path_prefix$TOOL_NAME && git pull
  fi
}
