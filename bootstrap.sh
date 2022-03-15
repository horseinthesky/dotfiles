#!/bin/env bash

source scripts/helper.sh

install_deps () {
  header "Installing base packages..."

  packages=(
    curl
    cmake
  )

  case $ID in
    arch|manjaro)
      packages+=(
        base-devel
        python
      )
      ;;
  esac

  install ${packages[@]}
}

symlink_python () {
  header "Creating python symlink..."

  if [[ -n $(which python) ]] && [[ $(python -V) == *"2."* ]]; then
    success "python3 is already in use"
    return
  fi

  sudo ln -snf python3 /usr/bin/python
  success
}

setup_env () {
  header "Setting up dev environment..."

  if [[ -d $HOME/.python ]]; then
    success "Already exists"
    return
  fi

  download https://bootstrap.pypa.io/virtualenv.pyz $HOME
  [[ $? -ne 0 ]] && exit

  info "Installing venv..."
  python $HOME/virtualenv.pyz $HOME/.python --quiet
  rm $HOME/virtualenv.pyz

  success
}

main () {
  install_deps
  symlink_python
  setup_env
}

main
