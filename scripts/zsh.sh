#!/usr/bin/env bash

source scripts/helper.sh

install_zsh () {
  header "Installing zsh..."
  install zsh
}

install_plugins () {
  header "Installing zsh plugins..."

  PLUGINS_DIR=$XDG_DATA_HOME/zsh/plugins
  THEMES_DIR=$XDG_DATA_HOME/zsh/themes

  plugins=(
    zsh-users/zsh-completions
    zsh-users/zsh-autosuggestions
    djui/alias-tips
  )

  themes=(
    romkatv/powerlevel10k
  )

  [[ ! -d $PLUGINS_DIR ]] && mkdir -p $PLUGINS_DIR
  for plugin in ${plugins[@]}; do
    clone $plugin $PLUGINS_DIR
  done

  [[ ! -d $THEMES_DIR ]] && mkdir -p $THEMES_DIR
  for theme in ${themes[@]}; do
    clone $theme $THEMES_DIR
  done
}

install_symlinks () {
  header "Symlink .zshenv and ZDOTDIR"

  [[ ! -d $HOME/.config ]] && mkdir $HOME/.config
  symlink $DOTFILES_HOME/zsh/.zshenv $HOME/.zshenv
  symlink $DOTFILES_HOME/zsh $HOME/.config/zsh
}

setup_user_shell () {
  header "Setting shell"
  sudo chsh -s $(which zsh) $(whoami)
  success
}

main () {
  install_zsh
  install_plugins
  install_symlinks
  setup_user_shell
}

main
