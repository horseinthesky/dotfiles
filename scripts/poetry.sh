#!/usr/bin/env bash

source scripts/helper.sh

setup_env () {
  [[ ! -d $HOME/.local/bin ]] && mkdir -p $HOME/.local/bin
  [[ ! $PATH == *$HOME/.local/bin* ]] && export PATH=$HOME/.local/bin:$PATH
}

install_poetry () {
  header "Installing poetry..."

  if [[ -n $(which poetry) ]]; then
    warning "Already installed. Updating..."
    poetry self update
    return
  fi

  [[ ! $PATH == *$HOME/.python/bin* ]] && export PATH=$HOME/.python/bin:$PATH
  curl -sSL https://install.python-poetry.org | python - 1> /dev/null
  success
}

symlink_poetry_config () {
  header "Symlink poetry config.toml"
  [[ ! -d $XDG_CONFIG_HOME/pypoetry ]] && mkdir -p $XDG_CONFIG_HOME/pypoetry
  symlink $DOTFILES_HOME/poetry.toml $XDG_CONFIG_HOME/pypoetry/config.toml
}

main () {
  setup_env
  install_poetry
  symlink_poetry_config
}

main
