#!/bin/env bash
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

install_bootstrap_packages () {
  source /etc/os-release
  case $ID_LIKE in
    debian)
      sudo apt-get update -y
      sudo apt-get install curl cmake -y
      ;;
    "rhel fedora")
      sudo yum update -y
      sudo yum install curl cmake -y
      ;;
    arch)
      sudo pacman -Sy --noconfirm
      sudo pacman -S curl cmake --noconfirm
      ;;
    *)
      case $ID in
        debian)
          sudo apt-get update -y
          sudo apt-get install curl cmake -y
          ;;
        arch)
          sudo pacman -Sy --noconfirm
          sudo pacman -S curl cmake --noconfirm
          ;;
      esac
  esac
}

setup_env () {
  curl --silent --output ~/virtualenv.pyz https://bootstrap.pypa.io/virtualenv.pyz
  python ~/virtualenv.pyz ~/opt/venv --quiet
  rm ~/virtualenv.pyz

  [[ ! $PATH == *$HOME/opt/venv/bin* ]] && export PATH=$HOME/opt/venv/bin:$PATH

  pip install ansible
}

echo -e "${LIGHTMAGENTA}Installing base packages...${NORMAL}"
install_bootstrap_packages | grep -P "\d\K upgraded"

echo -e "${LIGHTMAGENTA}Creating python symlink...${NORMAL}"
if [[ ! -f $(which python) ]] || [[ $(python -V) == *"2."* ]]; then
  sudo ln -s python3 /usr/bin/python
  echo done
else
  echo -e "${YELLOW}Already exists${NORMAL}"
fi

echo -e "${LIGHTMAGENTA}Setting up dev environment...${NORMAL}"
if [[ ! -d $HOME/opt/venv ]]; then
  setup_env | grep -P "\d\K installed"
else
  echo -e "${YELLOW}Already exists${NORMAL}"
fi
