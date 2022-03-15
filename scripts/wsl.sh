#!/usr/bin/env bash

source scripts/helper.sh

install_autohotkey () {
  header "Install autohotkey script"
  WINDOWS_STARTUP_DIR=/mnt/c/Users/$USER/AppData/Roaming/Microsoft/Windows/Start\ Menu/Programs/Startup

  if [[ -f $WINDOWS_STARTUP_DIR/autohotkey.ahk ]]; then
    warning "Already exists. Updating"
  fi

  cp $DOTFILES_HOME/autohotkey.ahk "$WINDOWS_STARTUP_DIR"
  success
}

main () {
  header "Setting up WSL..."
  if [[ -z $WSLENV ]]; then
    warning "Not a WSL environment. Abort"
    exit
  fi

  install_autohotkey
}

main
