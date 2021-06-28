#!/bin/env bash

source scripts/helper.sh

packages=(
  curl
  cmake
)

setup_env () {
  curl --silent --output ~/virtualenv.pyz https://bootstrap.pypa.io/virtualenv.pyz
  python ~/virtualenv.pyz ~/.python --quiet
  rm ~/virtualenv.pyz

  [[ ! $PATH == *$HOME/.python/bin* ]] && export PATH=$HOME/.python/bin:$PATH

  pip install ansible
}

echo -e "\n${LIGHTMAGENTA}Installing base packages...${NORMAL}"
case $ID in
  arch|manjaro)
    packages+=(
      base-devel
      python
    )
    ;;
esac
install ${packages[@]}

echo -e "\n${LIGHTMAGENTA}Creating python symlink...${NORMAL}"
if [[ ! -f $(which python) ]] || [[ $(python -V) == *"2."* ]]; then
  sudo ln -s python3 /usr/bin/python
  echo -e "${GREEN}Done${NORMAL}"
else
  echo -e "${YELLOW}Already exists${NORMAL}"
fi

echo -e "\n${LIGHTMAGENTA}Setting up dev environment...${NORMAL}"
if [[ ! -d $HOME/.python ]]; then
  setup_env | grep -E "installed"
else
  echo -e "${YELLOW}Already exists${NORMAL}"
fi
