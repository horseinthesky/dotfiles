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
if [[ ! -d $HOME/.fnm ]]; then
  curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
  echo -e "${GREEN}Done${NORMAL}"
else
  echo -e "${YELLOW}Already installed${NORMAL}"
fi

echo -e "\n${LIGHTMAGENTA}Installing node...${NORMAL}"
PATH=$PATH:$HOME/.fnm

if [[ ! -z $(which fnm) ]]; then
  eval "$(fnm env)"

  if [[ ! -z $(which node) ]]; then
    CURRENT_VERSION=$(node -v | cut -c2-)

    if [[ $CURRENT_VERSION < $NODE_VERSION ]]; then
      fnm uninstall $CURRENT_VERSION

      fnm install $NODE_VERSION
      npm install --global npm
      npm install --global yarn
      echo -e "${GREEN}Done${NORMAL}"
    else
      echo -e "${YELLOW}Latest ($NODE_VERSION) version is already installed${NORMAL}"
    fi
  else
    fnm install $NODE_VERSION
    npm install --global npm
    npm install --global yarn
    echo -e "${GREEN}Done${NORMAL}"
  fi
else
  echo -e "${LIGHTRED}fnm is not found. Can't procced.${NORMAL}"
fi
