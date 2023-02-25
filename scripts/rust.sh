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
}

symlink_stylua_config () {
  header "Symlinking stylua config..."

  symlink $DOTFILES_HOME/stylua.toml $HOME/.config/stylua/stylua.toml
}

install_rust_analyzer () {
  header "Rust analyzer..."

  local tarball=rust-analyzer-x86_64-unknown-linux-gnu.gz

  download https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/$tarball $HOME
  [[ $? -ne 0 ]] && exit

  info "Extracting archive..."
  local out=$HOME/.local/bin/rust-analyzer
  gunzip --stdout $HOME/$tarball > $out
  chmod +x $out

  rm $HOME/$tarball

  success
}

main () {
  install_cargo
  install_deps
  install_tools
  symlink_stylua_config
  install_rust_analyzer
}

main
