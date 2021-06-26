#!/usr/bin/env bash

source scripts/helper.sh

NODE_VERSION=14.17.1

echo -e "\n${LIGHTMAGENTA}Installing fnm...${NORMAL}"
if [[ ! -d $HOME/.fnm ]]; then
  curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
  echo -e "${GREEN}Done${NORMAL}"
else
  echo -e "${YELLOW}Already installed${NORMAL}"
fi

echo -e "\n${LIGHTMAGENTA}Installing node...${NORMAL}"
PATH=$PATH:$HOME/.fnm && eval "$(fnm env)"

if [[ ! -z $(which node) ]]; then
  CURRENT_VERSION=$(node -v | cut -c2-)

  if [[ $CURRENT_VERSION < $NODE_VERSION ]]; then
    fnm uninstall $CURRENT_VERSION
    fnm install $NODE_VERSION
    echo -e "${GREEN}Done${NORMAL}"
  else
    echo -e "${YELLOW}Latest ($NODE_VERSION) version is already installed${NORMAL}"
  fi
else
  fnm install $NODE_VERSION
  echo -e "${GREEN}Done${NORMAL}"
fi
