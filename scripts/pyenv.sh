#!/usr/bin/env bash

source scripts/helper.sh

install_deps () {
  header "Installing pyenv deps..."

  case $ID in
    debian|ubuntu)
      packages=(
        make
        build-essential
        libssl-dev
        zlib1g-dev
        libbz2-dev
        libreadline-dev
        libsqlite3-dev
        wget
        curl
        llvm
        libncurses5-dev
        xz-utils
        tk-dev
        libxml2-dev
        libxmlsec1-dev
        libffi-dev
        liblzma-dev
      )
      ;;
    arch|manjaro)
      packages=(
        base-devel
        openssl
        zlib
        xz
      )
      ;;
    *)
      error "Abort. Distro is not supported"
      exit
      ;;
  esac

  install "${packages[@]}"

  success
}

install_pyenv () {
  header "Installing pyenv..."

  clone pyenv/pyenv "$HOME" .
  [[ $? -ne 0 ]] && exit

  clone pyenv/pyenv-update "$HOME"/.pyenv/plugins
  [[ $? -ne 0 ]] && exit
}

install_versions () {
  header "Installing pyenv versions..."

  pyenv_versions=(
    3.12.9
    3.13.2
  )

  PATH=$PATH:$HOME/.pyenv/bin

  for version in "${pyenv_versions[@]}"; do
    pyenv install "$version" --skip-existing

    symlink "$HOME/.pyenv/versions/$version"/bin/python \
      "$HOME/.local/bin/python$(echo "$version" | awk -F- '{print $1}' | awk -F. '{print $1"."$2}')"
  done
}

main () {
  install_deps
  install_pyenv
  install_versions
}

main
