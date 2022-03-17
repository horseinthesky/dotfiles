#!/usr/bin/env bash

source scripts/helper.sh

install_neovim () {
  header "Installing neovim..."

  if [[ -n $(which nvim) ]]; then
    success "Already installed"
    return
  fi

  install neovim
}

setup_neovim_env () {
  header "Setting up neovim..."

  [[ ! -d $HOME/.config/nvim ]] && mkdir -p $HOME/.config/nvim
  symlink $DOTFILES_HOME/init.vim $XDG_CONFIG_HOME/nvim/init.vim
  symlink $DOTFILES_HOME/coc-settings.json $XDG_CONFIG_HOME/nvim/coc-settings.json
  symlink $DOTFILES_HOME/lua $XDG_CONFIG_HOME/nvim/lua
  symlink $DOTFILES_HOME/UltiSnips $XDG_CONFIG_HOME/nvim/UltiSnips
}

install_vimplug () {
  header "Installing vimplug..."

  VIM_PLUG_PATH=$HOME/.local/share/nvim/site/autoload/plug.vim

  if [[ -f $VIM_PLUG_PATH ]]; then
    success "Already installed"
    return
  fi

  download https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim $VIM_PLUG_PATH
  [[ $? -ne 0 ]] && exit

  success
}

install_neovim_plugins () {
  header "Setup neovim plugins..."

  if [[ $(nvim --version | head -n 1 | cut -c7-11) < 0.5.0 ]]; then
    nvim +':silent PlugInstall' +qa
  fi

  success
}

main () {
  install_neovim
  setup_neovim_env
  install_vimplug
  install_neovim_plugins
}

main
