#!/usr/bin/env bash

source scripts/helper.sh

echo -e "\n${LIGHTMAGENTA}Installing ranger...${NORMAL}"
[[ ! $PATH == *$HOME/.python/bin* ]] && export PATH=$HOME/.python/bin:$PATH
pip install ranger-fm | grep -E "installed|satisfied"

echo -e "\n${LIGHTMAGENTA}Symlink ranger dir${NORMAL}"
[[ ! -d $HOME/.config ]] && mkdir $HOME/.config
symlink $DOTFILES_HOME/ranger/ $HOME/.config/ranger
echo -e "${GREEN}Done${NORMAL}"
