#!/usr/bin/env bash

source scripts/helper.sh

install_cargo () {
  header "Installing cargo/rust..."

  if [[ ! -d $HOME/.cargo ]]; then
    curl https://sh.rustup.rs -sSf | sh -s -- -q -y --no-modify-path | grep -E "installed"

    if [[ $? -ne 0 ]]; then
      error "Failed to install cargo/rust"
      exit
    fi

    success
    return
  fi

  PATH=$HOME/.cargo/bin:$PATH

  local current_toolchain_version=$(
    rustup show | \
      grep -P -o "rustc \d+\.\d+\.\d+" | \
      awk '{print $NF}'
  )
  local latest_toolchain_version=$(
    rustup check | \
      grep -P -o "Update available : \d+\.\d+\.\d+" | \
      awk '{print $NF}'
  )

  if [[ -z $latest_toolchain_version ]]; then
    success "Latest ($current_toolchain_version) version is already installed"
    return
  fi

  info "Newer version found. Updating $current_toolchain_version -> $latest_toolchain_version..."
  rustup update stable &> /dev/null

  if [[ $? -ne 0 ]]; then
    error "Failed to update Rust to the latest ($latest_toolchain_version) version"
    return
  fi

  success "Rust updated to the latest ($latest_toolchain_version) version"
}

install_deps () {
  header "Installing cli tools deps..."

  case $ID in
    debian|ubuntu)
      deps=(
        libssl-dev
        pkg-config
      )
      ;;
    arch|manjaro)
      deps=(
        openssl
      )
      ;;
    *)
      error "Distro is not supported. Abort"
      exit
      ;;
  esac

  install ${deps[@]}
}

install_tools () {
  header "Installing cli tools..."

  tools=(
    ripgrep,rg
    fd-find,fd
    zoxide
    lsd
    exa
    git-delta,delta
    stylua
    gping
    bat
    xh
    procs
    du-dust,dust
    bandwhich
    bottom,btm
    tealdeer,tldr
  )

  for tool in ${tools[@]}; do
    cargo_install $tool
  done
}

symlink_stylua_config () {
  header "Symlinking stylua config..."

  [[ ! -d $HOME/.config/stylua ]] && mkdir -p $HOME/.config/stylua
  symlink $DOTFILES_HOME/stylua.toml $HOME/.config/stylua/stylua.toml
}

main () {
  install_cargo
  install_deps
  install_tools
  symlink_stylua_config
}

main
