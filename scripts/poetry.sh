#!/usr/bin/env bash

source scripts/helper.sh

echo -e "\n${LIGHTMAGENTA}Installing poetry...${NORMAL}"
if [[ -n $(which poetry) ]]; then
  echo -e "${YELLOW}Already installed${NORMAL}"
  exit
fi

[[ ! $PATH == *$HOME/.python/bin* ]] && export PATH=$HOME/.python/bin:$PATH
curl -sSL https://install.python-poetry.org | python - 1> /dev/null
echo -e "${GREEN}Done${NORMAL}"

echo -e "\n${LIGHTMAGENTA}Symlink poetry config.toml${NORMAL}"
symlink $DOTFILES_HOME/poetry.toml $XDG_CONFIG_HOME/pypoetry/config.toml
