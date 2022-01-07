#!/usr/bin/env bash

source scripts/helper.sh

clone junegunn/fzf $HOME .

echo -e "\n${LIGHTMAGENTA}Building a fzf binary...${NORMAL}"
cd $HOME/.fzf && ./install --all --no-update-rc 1> /dev/null
echo -e "${GREEN}Done${NORMAL}"
