#!/usr/bin/env bash

source scripts/helper.sh

packages=(
 prettier
 neovim
 vscode-json-languageserver
 yaml-language-server
 vim-language-server
 lua-fmt
)

echo -e "\n${LIGHTMAGENTA}Installing npm packages...${NORMAL}"
if [[ ! -d $HOME/.fnm ]]; then
  echo -e "${LIGHTRED}npm is not found. Can't procced.${NORMAL}"
  exit 1
fi

PATH=$PATH:$HOME/.fnm && eval "$(fnm env)"
cd $HOME/opt

for package in ${packages[@]}; do
  npm install $package 2> /dev/null | grep -E "\+"
done
echo -e "${GREEN}Done${NORMAL}"
