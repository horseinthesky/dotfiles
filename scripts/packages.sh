#!/usr/bin/env bash

source scripts/helper.sh

packages=(
  htop
  tree
  jq
  bc
  mtr
)

echo -e "\n${LIGHTMAGENTA}Installing packages...${NORMAL}"
install ${packages[@]}
