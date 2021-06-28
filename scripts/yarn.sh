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

echo -e "\n${LIGHTMAGENTA}Installing yarn packages...${NORMAL}"
if [[ ! -d $HOME/.fnm ]]; then
  echo -e "${LIGHTRED}yarn is not found. Can't procced.${NORMAL}"
else
  PATH=$PATH:$HOME/.fnm && eval "$(fnm env)"

  yarn global add ${packages[@]} | grep -E "Installed"
fi
