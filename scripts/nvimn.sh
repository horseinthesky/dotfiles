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

echo -e "\n${LIGHTMAGENTA}Installing packer...${NORMAL}"
PACKER_PATH=$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
if [[ ! -d $PACKER_PATH ]]; then
  git clone https://github.com/wbthomason/packer.nvim \
    $PACKER_PATH
else
  echo -e "${YELLOW}Already exists${NORMAL}"
fi

echo -e "\n${LIGHTMAGENTA}Setting up neovim...${NORMAL}"
[[ ! -d $HOME/.config/nvim ]] && mkdir -p $HOME/.config/nvim
symlink $DOTFILES_HOME/init.vim $HOME/.config/nvim/init.vim
symlink $DOTFILES_HOME/coc-settings.json $HOME/.config/nvim/coc-settings.json
symlink $DOTFILES_HOME/lua $HOME/.config/nvim/lua
symlink $DOTFILES_HOME/UltiSnips $HOME/.config/nvim/UltiSnips
echo -e "${GREEN}Done${NORMAL}"

# echo -e "\n${LIGHTMAGENTA}Setup Neovim plugins...${NORMAL}"
# if [[ $(echo $($HOME/.local/bin/nvim --version | head -n 1 | cut -c7-11) 0.5.0 | awk '{if ($1 >= $2) print "1"; else print ""}') ]]; then
#   $HOME/.local/bin/nvim -u NORC +"lua require 'plugins'" +PackerInstall +qa
# fi
# echo -e "${GREEN}Done${NORMAL}"
