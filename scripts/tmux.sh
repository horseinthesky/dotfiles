#!/usr/bin/env bash

source scripts/helper.sh

install_tmux () {
  header "Installing tmux..."
  install tmux
}

symlink_tmux_conf () {
  header "Symlink .tmux.conf"
  symlink $DOTFILES_HOME/tmux.conf $HOME/.tmux.conf
}

install_tpm () {
  clone tmux-plugins/tpm $HOME/.tmux/plugins
}

main () {
  install_tmux
  symlink_tmux_conf
  install_tpm
}

main
