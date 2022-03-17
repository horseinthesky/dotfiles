#!/bin/env bash

source scripts/helper.sh

install_deps () {
  header "Installing bootstrap dependencies..."

  case $ID in
    debian|ubuntu)
      packages=(
        build-essential
      )
      ;;
    arch|manjaro)
      packages=(
        base-devel
      )
      ;;
    *)
      error "Distro $ID is not supported"
      return 1
      ;;
  esac

  install ${packages[@]}
}

main () {
  install_deps
}

main
