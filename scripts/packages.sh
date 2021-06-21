#!/usr/bin/env bash

source scripts/helper.sh

packages=(
  htop
  tree
  jq
  mtr
)

echo -e "\n${LIGHTMAGENTA}Installing packages...${NORMAL}"
install ${packages[@]} | grep -P "\d\K upgraded"
