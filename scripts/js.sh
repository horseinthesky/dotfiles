#!/usr/bin/env bash

source scripts/helper.sh

install_deps () {
  header "Installing fnm deps..."

  packages=(
    curl
    unzip
  )

  install ${packages[@]}
}

install_fnm () {
  header "Installing fnm..."

  if [[ -d $HOME/.fnm ]]; then
    success "Already installed"
    return
  fi

  curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir $HOME/.fnm --skip-shell

  success
}

install_yarn () {
  [[ -f $HOME/.yarnrc ]] && rm $HOME/.yarnrc
  fnm install $1
  npm install --global npm
  npm install --global yarn
  success
}

install_node () {
  header "Installing node..."

  PATH=$PATH:$HOME/.fnm && eval "$(fnm env)"

  if [[ -z $(which fnm) ]]; then
    error "fnm is not found. Can't procced."
    exit
  fi

  local version=20.9.0

  # Install node if missing
  if [[ -z $(which node) ]]; then
    install_yarn $version
    return
  fi

  # Update node if old
  local current_version=$(node -v | cut -c2-)

  if [[ $current_version == $version ]]; then
    success "Latest ($version) version is already installed"
    return
  fi

  fnm uninstall $current_version
  install_yarn $version
}

install_js_packages () {
  header "Installing yarn packages..."

  packages=(
    pyright
    vscode-langservers-extracted
    yaml-language-server
    dockerfile-language-server-nodejs
    @fsouza/prettierd
    bash-language-server
  )

  XDG_DATA_HOME=$XDG_DATA_HOME yarn global add ${packages[@]} | grep -E "Installed"
}

main () {
  install_deps
  install_fnm
  install_node
  install_js_packages
}

main
