#!/usr/bin/env bash

source scripts/helper.sh

cargo_install () {
  local tool binary
  IFS=, read -r tool binary <<< ${1}

  info "Installing $tool..."

  if [[ ! -d $HOME/.cargo ]]; then
    error "Cargo is not found. Can't procced"
    return 1
  fi

  PATH=$HOME/.cargo/bin:$PATH

  if [[ -z $binary ]]; then
    binary=$tool
  fi

  # Fresh install
  if [[ -z $(which $binary) ]]; then
    cargo install $tool

    if [[ $? -ne 0 ]]; then
      error "Failed to install $tool"
      return 1
    fi

    success "$tool installed"
    return
  fi

  # Update
  local current_version=$($binary --version 2> /dev/null | grep -P -o "\d+\.\d+\.\d+" | head -n 1)
  local latest_version=$(cargo search $tool | head -n 1 | awk '{print $3}' | tr -d '"')

  if [[ $current_version == $latest_version ]]; then
    success "Latest ($latest_version) version is already installed"
    return
  fi

  info "Newer version found. Updating $current_version -> $latest_version..."
  cargo install $tool --force

  if [[ $? -ne 0 ]]; then
    error "Failed to update $tool to the latest ($latest_version) version"
    return 1
  fi

  warning "$tool updated to the latest ($latest_version) version\n"
}

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
      grep -P -o "Update available.*\d+\.\d+\.\d+" | \
      head -n 1 | \
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

install_cli_tools_deps () {
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
    shellharden
    stylua
    gping
    xh
    so
    hyperfine
    procs
    du-dust,dust
    bandwhich
    bottom,btm
    tealdeer,tldr
    speedtest-rs
  )

  for tool in ${tools[@]}; do
    cargo_install $tool
  done

  header "Installing rust-analyzer..."
  rustup component add rust-analyzer
  success
}

symlink_stylua_config () {
  header "Symlinking stylua config..."

  symlink $DOTFILES_HOME/stylua.toml $HOME/.config/stylua/stylua.toml
}

main () {
  install_cargo
  install_cli_tools_deps
  install_tools
  symlink_stylua_config
}

main
