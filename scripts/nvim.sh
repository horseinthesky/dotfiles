#!/usr/bin/env bash

source scripts/helper.sh

echo -e "\n${LIGHTMAGENTA}Installing neovim...${NORMAL}"
if [[ -z $(which nvim) ]]; then
  install neovim
else
  echo -e "${YELLOW}Already installed${NORMAL}"
fi

echo -e "\n${LIGHTMAGENTA}Installing vimplug...${NORMAL}"
VIM_PLUG_PATH=$HOME/.local/share/nvim/site/autoload
if [[ ! -d $VIM_PLUG_PATH ]]; then
  mkdir -p $VIM_PLUG_PATH
  curl -fsLo $VIM_PLUG_PATH/plug.vim \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  echo -e "${GREEN}Done${NORMAL}"
else
  echo -e "${YELLOW}Already installed${NORMAL}"
fi

echo -e "\n${LIGHTMAGENTA}Setup NVIM...${NORMAL}"
[[ ! -d $HOME/.config/nvim ]] && mkdir -p $HOME/.config/nvim
symlink $DOTFILES_HOME/init.vim $HOME/.config/nvim/init.vim
symlink $DOTFILES_HOME/coc-settings.json $HOME/.config/nvim/coc-settings.json
symlink $DOTFILES_HOME/lua $HOME/.config/nvim/lua
symlink $DOTFILES_HOME/UltiSnips $HOME/.config/nvim/UltiSnips
echo -e "${GREEN}Done${NORMAL}"

echo -e "\n${LIGHTMAGENTA}Setup Neovim plugins...${NORMAL}"
if [[ $(nvim --version | head -n 1 | cut -c7-11) < 0.5.0 ]]; then
  nvim +':silent PlugInstall' +qa
fi
echo -e "${GREEN}Done${NORMAL}"
