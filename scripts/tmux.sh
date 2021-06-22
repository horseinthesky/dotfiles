#!/usr/bin/env bash

source scripts/helper.sh

echo -e "\n${LIGHTMAGENTA}Installing tmux...${NORMAL}"
install tmux | grep -P "\d\K upgraded"

echo -e "\n${LIGHTMAGENTA}Symlink .tmux.conf${NORMAL}"
symlink $DOTFILES_HOME/tmux.conf $HOME/.tmux.conf

echo -e "\n${LIGHTMAGENTA}Cloning tmp...${NORMAL}"
clone tmux-plugins/tpm $HOME/.tmux/plugins
