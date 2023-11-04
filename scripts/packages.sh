#!/usr/bin/env bash

source scripts/helper.sh

packages=(
  curl
  unzip
  htop
  tree
  jq
  bc
)

header "Installing packages..."
install ${packages[@]}
