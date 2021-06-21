#!/bin/env bash

source scripts/helper.sh

packages=(
  curl
  cmake
)

setup_env () {
  curl --silent --output ~/virtualenv.pyz https://bootstrap.pypa.io/virtualenv.pyz
  python ~/virtualenv.pyz ~/opt/venv --quiet
  rm ~/virtualenv.pyz

  [[ ! $PATH == *$HOME/opt/venv/bin* ]] && export PATH=$HOME/opt/venv/bin:$PATH

  pip install ansible
}

echo -e "${LIGHTMAGENTA}Installing base packages...${NORMAL}"
install ${packages[@]} | grep -P "\d\K upgraded"

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
