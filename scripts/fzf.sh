#!/usr/bin/env bash

source scripts/helper.sh

header "Installing fzf..."
clone junegunn/fzf $HOME .

header "Building a fzf binary..."
if [[ -d $HOME/.fzf ]]; then
  cd $HOME/.fzf && ./install --all --no-update-rc 1> /dev/null

  success
  exit
fi

error "$HOME/.fzf does not exit"
