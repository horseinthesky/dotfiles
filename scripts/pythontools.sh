#!/usr/bin/env bash

source scripts/helper.sh

packages=(
  httpie
  ptpython
  jedi
  isort
  mypy
  flake8
  autopep8
  yapf
  black
  pynvim
  jedi-language-server
)

echo -e "\n${LIGHTMAGENTA}Installing python packages...${NORMAL}"
pip install -U ${packages[@]} | grep -E "installed"
echo -e "${GREEN}Done${NORMAL}"

echo -e "\n${LIGHTMAGENTA}Setting up ptpython...${NORMAL}"
[[ ! -d $HOME/.config/ptpython ]] && mkdir -p $HOME/.config/ptpython
symlink $DOTFILES_HOME/ptpython.py $HOME/.config/ptpython/config.py

echo -e "\n${LIGHTMAGENTA}Setting up yapf...${NORMAL}"
[[ ! -d $HOME/.config/yapf ]] && mkdir -p $HOME/.config/yapf
symlink $DOTFILES_HOME/style.yapf $HOME/.config/yapf/style
