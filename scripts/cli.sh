#!/usr/bin/env bash

source scripts/helper.sh

tools=(
  ripgrep,rg
  fd-find,fd
  gping
  lsd
  exa
  bat
  xh
  procs
  du-dust,dust
  bandwhich
  bottom,btm
  tealdeer,tldr
  zoxide
  git-delta,delta
)

echo -e "\n${LIGHTMAGENTA}Installing cli tools deps...${NORMAL}"
case $ID in
  debian|ubuntu)
    deps=(
      libssl-dev
      pkg-config
    )
    ;;
  arch|manjaro)
    deps=(
      openssl
    )
    ;;
  *)
    echo -e "${LIGHTRED}Abort. Distro is not supported"
    exit 0
    ;;
esac
install ${deps[@]}

for tool in ${tools[@]}; do
  cargo_install $tool
done
