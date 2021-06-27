#!/usr/bin/env bash

source scripts/helper.sh

tools=(
  ripgrep
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

echo -e "\n${LIGHTMAGENTA}Installing cli tools deps...${NORMAL}"
case $ID in
  debian|ubuntu)
    deps=(
      libssl-dev
      pkg-config
    )

    install ${deps[@]}
    ;;
  arch|manjaro)
    deps=(
      openssl
    )

    install ${deps[@]}
    ;;
esac

for tool in ${tools[@]}; do
  cargo_install $tool
done
