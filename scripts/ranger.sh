#!/usr/bin/env bash

source scripts/helper.sh

install_ranger () {
  header "Installing ranger..."

  [[ ! $PATH == *$HOME/.python/bin* ]] && export PATH=$HOME/.python/bin:$PATH
  pip install ranger-fm | grep -E "installed|satisfied"
}

symlink_ranger_config () {
  header "Symlink ranger dir"

  [[ ! -d $HOME/.config ]] && mkdir $HOME/.config
  symlink $DOTFILES_HOME/ranger/ $HOME/.config/ranger
}

main () {
  install_ranger
  symlink_ranger_config
}

main
