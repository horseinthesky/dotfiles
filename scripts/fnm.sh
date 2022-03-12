#!/usr/bin/env bash

source scripts/helper.sh

NODE_VERSION=14.17.1

packages=(
  curl
  unzip
)

echo -e "\n${LIGHTMAGENTA}Installing fnm deps...${NORMAL}"
install ${packages[@]}

echo -e "\n${LIGHTMAGENTA}Installing fnm...${NORMAL}"
if [[ -d $HOME/.fnm ]]; then
  echo -e "${YELLOW}Already installed${NORMAL}"
else
  curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
  echo -e "${GREEN}Done${NORMAL}"
fi

echo -e "\n${LIGHTMAGENTA}Installing node...${NORMAL}"
PATH=$PATH:$HOME/.fnm

if [[ -z $(which fnm) ]]; then
  echo -e "${LIGHTRED}fnm is not found. Can't procced.${NORMAL}"
  exit
fi

eval "$(fnm env)"

install_node () {
  fnm install $NODE_VERSION
  npm install --global npm
  npm install --global yarn
  echo -e "${GREEN}Done${NORMAL}"
}

# Install node if missing
if [[ -z $(which node) ]]; then
  install_node
  exit
fi

# Update node if old
CURRENT_VERSION=$(node -v | cut -c2-)

if [[ $CURRENT_VERSION == $NODE_VERSION ]]; then
  echo -e "${YELLOW}Latest ($NODE_VERSION) version is already installed${NORMAL}"
  exit
fi

fnm uninstall $CURRENT_VERSION
install_node
