#!/usr/bin/env bash

source scripts/helper.sh

packages=(
  curl
  unzip
  htop
  tree
  jq
  bc
  shellcheck
)

header "Installing packages..."
install ${packages[@]}
