#!/usr/bin/env bash

source scripts/helper.sh

echo -e "\n${LIGHTMAGENTA}Installing tmux...${NORMAL}"
install tmux

echo -e "\n${LIGHTMAGENTA}Symlink .tmux.conf${NORMAL}"
symlink $DOTFILES_HOME/tmux.conf $HOME/.tmux.conf
echo -e "${GREEN}Done${NORMAL}"

clone tmux-plugins/tpm $HOME/.tmux/plugins
