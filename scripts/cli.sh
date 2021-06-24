#!/usr/bin/env bash

source scripts/helper.sh

tools=(
  rg
  fd-find
  lsd
  bat
  procs
  du-dust
  bottom
  tealdeer
  zoxide
  git-delta
)

for tool in ${tools[@]}; do
  cargo_install $tool
done
