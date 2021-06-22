#!/usr/bin/env bash

source scripts/helper.sh

echo -e "\n${LIGHTMAGENTA}Installing fzf...${NORMAL}"
if [[ ! -d $HOME/.fzf ]]; then
  git clone -q git@github.com:junegunn/fzf.git $HOME/.fzf
else
  echo -e "${YELLOW}Already exits. Updating...${NORMAL}"
  cd $HOME/.fzf && \
    git pull 1> /dev/null && \
    ./install --all 1> /dev/null
fi

echo -e "${GREEN}Done${NORMAL}"
