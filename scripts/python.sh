#!/usr/bin/env bash

source scripts/helper.sh

devenv=$HOME/.python

setup_env () {
  header "Setting up dev environment..."

  local devver=3.14

  if [[ -d $devenv ]]; then
    success "Already exists"
    return
  fi

  if [[ ! -L $HOME/.local/bin/python${devver} ]]; then
    error "Developer environment Python version is not installed"
    exit
  fi

  download https://bootstrap.pypa.io/virtualenv.pyz
  [[ $? -ne 0 ]] && exit

  info "Installing venv..."
  "$HOME/.local/bin/python$devver" "$HOME"/virtualenv.pyz "$devenv" --quiet
  rm "$HOME"/virtualenv.pyz

  success
}

install_python_tools () {
  header "Installing python packages..."

  packages=(
    ptpython
    virtualenv
    uv
    mypy
    ruff
  )

  if [[ ! -d $devenv ]]; then
    error "Developer environment is not installed"
    exit
  fi

  [[ ! $PATH == *$devenv/bin* ]] && export PATH=$devenv/bin:$PATH
  pip install -U "${packages[@]}" | grep -E "installed"

  success
}

symlink_configs () {
  header "Setting up python tools configs..."

  symlink "$DOTFILES_HOME"/ptpython.py "$XDG_CONFIG_HOME"/ptpython/config.py
}

main () {
  setup_env
  install_python_tools
  symlink_configs
}

main
