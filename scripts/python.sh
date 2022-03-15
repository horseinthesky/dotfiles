#!/usr/bin/env bash

source scripts/helper.sh

install_python_tools () {
  header "Installing python packages..."

  packages=(
    virtualenv
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

  [[ ! $PATH == *$HOME/.python/bin* ]] && export PATH=$HOME/.python/bin:$PATH
  pip install -U ${packages[@]} | grep -E "installed"
  success
}

symlink_configs () {
  header "Setting up ptpython..."
  [[ ! -d $HOME/.config/ptpython ]] && mkdir -p $HOME/.config/ptpython
  symlink $DOTFILES_HOME/ptpython.py $HOME/.config/ptpython/config.py

  header "Setting up yapf..."
  [[ ! -d $HOME/.config/yapf ]] && mkdir -p $HOME/.config/yapf
  symlink $DOTFILES_HOME/style.yapf $HOME/.config/yapf/style
}

main () {
  install_python_tools
  symlink_configs
}

main
