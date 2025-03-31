#!/usr/bin/env bash

source scripts/helper.sh

install_deps () {
  header "Installing neovim build deps..."

  if [[ -d $HOME/neovim ]]; then
    success "Neovim is already installed. No need to update deps."
    return
  fi

  case $ID in
    debian|ubuntu)
      deps=(
        ninja-build
        gettext
        libtool
        libtool-bin
        autoconf
        automake
        cmake
        g++
        pkg-config
        unzip
        curl
        doxygen
      )
      ;;
    arch|manjaro)
      deps=(
        base-devel
        cmake
        unzip
        ninja
        tree-sitter
        curl
      )
      ;;
    *)
      error "Distro is not supported. Abort"
      exit
      ;;
  esac

  install "${deps[@]}"
}

install_neovim () {
  header "Installing Neovim ..."

  if [[ -d $HOME/neovim ]]; then
    warning "neovim already exists. Updating..."
    cd "$HOME"/neovim && git pull 1> /dev/null
    success

    exit
  fi

  local branch=release-0.11

  git clone --depth 1 --branch "$branch" https://github.com/neovim/neovim.git "$HOME"/neovim
  if [[ $? -ne 0 ]]; then
    error "Failed to clone neovim"
    exit
  fi

  info "\nBuilding neovim from source..."

  cd "$HOME"/neovim \
    && rm -rf "$HOME"/.local/share/nvim/runtime \
    && make distclean \
    && make \
      CMAKE_BUILD_TYPE=Release \
      CMAKE_INSTALL_PREFIX="$HOME"/.local install 1> /dev/null

  if [[ $? -ne 0 ]]; then
    error "Failed to build neovim"
    exit
  fi

  success
}

setup_neovim_env () {
  header "Setting up neovim..."

  [[ ! -d $HOME/.config/nvim ]] && mkdir -p "$HOME"/.config/nvim
  symlink "$DOTFILES_HOME"/nvim/init.lua "$XDG_CONFIG_HOME"/nvim/init.lua
  symlink "$DOTFILES_HOME"/nvim/lua "$XDG_CONFIG_HOME"/nvim/lua
}

main () {
  install_deps
  install_neovim
  setup_neovim_env
}

main
