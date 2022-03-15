#!/usr/bin/env bash

source scripts/helper.sh

packages=(
  curl
  unzip
  htop
  tree
  jq
  bc
  mtr
)

header "Installing packages..."
install ${packages[@]}
