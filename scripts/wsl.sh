#!/usr/bin/env bash

source scripts/helper.sh

WINDOWS_USER_DIR=/mnt/c/Users/$USER

install_autohotkey () {
  header "Install autohotkey script"

  WINDOWS_STARTUP_DIR=/mnt/c/Users/$USER/AppData/Roaming/Microsoft/Windows/Start\ Menu/Programs/Startup

  if [[ -f $WINDOWS_STARTUP_DIR/autohotkey.ahk ]]; then
    warning "Already exists. Updating"
  fi

  cp "$DOTFILES_HOME"/windows/autohotkey.ahk "$WINDOWS_STARTUP_DIR"
  success
}

install_wsl_conf () {
  header "Install wsl.conf"

  if [[ -f /etc/wsl.conf ]]; then
    warning "Already exists. Updating"
  fi

  sudo cp "$DOTFILES_HOME"/windows/wsl.conf /etc/wsl.conf
  success
}

install_wslconfig () {
  header "Install .wslconfig"

  if [[ -f $WINDOWS_USER_DIR/.wslconfig ]]; then
    warning "Already exists. Updating"
  fi

  sudo cp "$DOTFILES_HOME"/windows/.wslconfig "$WINDOWS_USER_DIR"/.wslconfig
  success
}

copy_ipv6_enabler () {
  header "Copy ipv6 enable script"

  if [[ -f $WINDOWS_USER_DIR/enable_ipv6.ps1 ]]; then
    warning "Already exists. Updating"
  fi

  sudo cp "$DOTFILES_HOME"/windows/enable_ipv6.ps1 "$WINDOWS_USER_DIR"
  success
}

main () {
  header "Setting up WSL..."
  if [[ -z $WSLENV ]]; then
    warning "Not a WSL environment. Abort"
    exit
  fi

  install_autohotkey
  install_wsl_conf
  install_wslconfig
  copy_ipv6_enabler
}

main
