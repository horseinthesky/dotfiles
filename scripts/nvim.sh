#!/usr/bin/env bash

source scripts/helper.sh

install_deps () {
  header "Installing neovim build deps..."

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
      )
      ;;
    arch|manjaro)
      deps=(
        base-devel
        cmake
        unzip
        ninja
        tree-sitter
      )
      ;;
    *)
      error "Distro is not supported. Abort"
      exit
      ;;
  esac

  install ${deps[@]}
}

install_neovim () {
  header "Installing Neovim nightly..."

  clone neovim/neovim $HOME
  [[ $? -ne 0 ]] && exit

  info "Building neovim from source..."

  cd $HOME/neovim

  make \
    CMAKE_BUILD_TYPE=Release \
    CMAKE_INSTALL_PREFIX=$HOME/.local install 1> /dev/null

  success
}

setup_neovim_env () {
  header "Setting up neovim..."

  [[ ! -d $HOME/.config/nvim ]] && mkdir -p $HOME/.config/nvim
  symlink $DOTFILES_HOME/init.lua $XDG_CONFIG_HOME/nvim/init.lua
  symlink $DOTFILES_HOME/lua $XDG_CONFIG_HOME/nvim/lua
}

main () {
  install_deps
  install_neovim
  setup_neovim_env
}

main
