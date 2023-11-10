#!/usr/bin/env bash

source scripts/helper.sh

install_packages () {
  header "Installing packages..."

  packages=(
    gnome-tweaks
    dconf-editor
  )

  install ${packages[@]}
}

install_flameshot () {
  header "Installing flameshot..."
  FLAMESHOT=flameshot-11.0.0-1.ubuntu-20.04.amd64.deb
  download https://github.com/flameshot-org/flameshot/releases/download/v11.0.0/$FLAMESHOT
  sudo dpkg -i $HOME/$FLAMESHOT 1> /dev/null
  rm $HOME/$FLAMESHOT
  success
}

install_kitty () {
  header "Installing kitty..."

  curl -sL https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
  symlink $HOME/.local/kitty.app/bin/kitty $HOME/.local/bin/kitty
  symlink $DOTFILES_HOME/kitty $HOME/.config


  info "Configuring kitty desktop..."
  cp $DOTFILES_HOME/kitty/kitty.desktop $HOME/.local/share/applications/
  sed -i 's|PLACEHOLDER|'"$HOME"'|' $HOME/.local/share/applications/kitty.desktop
  sed -i 's|TryExec=kitty|'"TryExec=$HOME/.local/bin/kitty"'|' $HOME/.local/share/applications/kitty.desktop
  sed -i 's|^Exec=kitty|'"Exec=$HOME/.local/bin/kitty"'|' $HOME/.local/share/applications/kitty.desktop

  success
}

install_font () {
  header "Downloading nerd font..."

  FONT_FAMILY=DejaVuSansMono
  FONT_TYPE=Regular
  FONT=DejaVuSansMNerdFont-Regular.ttf

  FONT_DIR=$HOME/.local/share/fonts
  [[ ! -d $FONT_DIR ]] && mkdir -p $FONT_DIR

  download https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/$FONT_FAMILY/$FONT_TYPE/$FONT $FONT_DIR
}

main () {
  header "Setting up desktop"
  if [[ -z $(echo $XDG_CURRENT_DESKTOP) ]]; then
    warning "No GUI found. Abort"
    exit
  fi

  install_packages
  install_flameshot
  install_kitty
  install_font
}

main
