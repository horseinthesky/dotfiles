#!/usr/bin/env bash

source scripts/helper.sh

devenv=$HOME/.python

setup_env () {
  header "Setting up dev environment..."

  local devver=3.11

  if [[ -d $devenv ]]; then
    success "Already exists"
    return
  fi

  if [[ ! -L $HOME/.local/bin/python${devver} ]]; then
    error "Developer environment Python version is not installed"
    exit
  fi

  download https://bootstrap.pypa.io/virtualenv.pyz $HOME
  [[ $? -ne 0 ]] && exit

  info "Installing venv..."
  $HOME/.local/bin/python${devver} $HOME/virtualenv.pyz $devenv --quiet
  rm $HOME/virtualenv.pyz

  success
}

install_python_tools () {
  header "Installing python packages..."

  packages=(
    virtualenv
    ptpython
    ruff
    isort
    mypy
    flake8
    black
    python-lsp-server
  )

  if [[ ! -d $devenv ]]; then
    error "Developer environment is not installed"
    exit
  fi

  [[ ! $PATH == *$devenv/bin* ]] && export PATH=$devenv/bin:$PATH
  pip install -U ${packages[@]} | grep -E "installed"
  success
}

symlink_configs () {
  header "Setting up python tools configs..."

  symlink $DOTFILES_HOME/ptpython.py $XDG_CONFIG_HOME/ptpython/config.py
}

install_poetry () {
  header "Installing poetry..."

  if [[ -n $(which poetry) ]]; then
    warning "Already installed. Updating..."
    poetry self update

    success
    return
  fi

  curl -sSL https://install.python-poetry.org | python - 1> /dev/null

  if [[ $? -ne 0 ]]; then
    error "Failed to install poetry"
    return
  fi

  success
}

symlink_poetry () {
  header "Symlink poetry config.toml"
  symlink $DOTFILES_HOME/poetry.toml $XDG_CONFIG_HOME/pypoetry/config.toml
}

main () {
  setup_env
  install_python_tools
  symlink_configs
  install_poetry
  symlink_poetry
}

main
