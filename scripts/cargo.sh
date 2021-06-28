#!/usr/bin/env bash

source scripts/helper.sh

echo -e "\n${LIGHTMAGENTA}Installing cargo/rust...${NORMAL}"
if [[ ! -d $HOME/.cargo ]]; then
  curl https://sh.rustup.rs -sSf | sh -s -- -q -y --no-modify-path | grep -E "installed"
else
  echo -e "${YELLOW}Already exists${NORMAL}"
fi
