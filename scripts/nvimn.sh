#!/usr/bin/env bash

source scripts/helper.sh

echo -e "\n${LIGHTMAGENTA}Installing neovim build deps...${NORMAL}"
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
    echo -e "${LIGHTRED}Abort. Distro is not supported"
    exit 0
    ;;
esac
install ${deps[@]}

clone neovim/neovim $HOME

echo -e "\n${LIGHTMAGENTA}Building neovim from source...${NORMAL}"
cd $HOME/neovim
make \
  CMAKE_BUILD_TYPE=Release \
  CMAKE_INSTALL_PREFIX=$HOME/.local install 1> /dev/null
echo -e "${GREEN}Done${NORMAL}"

echo -e "\n${LIGHTMAGENTA}Setting up neovim...${NORMAL}"
[[ ! -d $HOME/.config/nvim ]] && mkdir -p $HOME/.config/nvim
symlink $DOTFILES_HOME/init.vim $HOME/.config/nvim/init.vim
symlink $DOTFILES_HOME/lua $HOME/.config/nvim/lua
symlink $DOTFILES_HOME/UltiSnips $HOME/.config/nvim/UltiSnips
echo -e "${GREEN}Done${NORMAL}"
