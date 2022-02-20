#!/usr/bin/env bash

source scripts/helper.sh

echo -e "\n${LIGHTMAGENTA}Installing cargo/rust...${NORMAL}"
if [[ -d $HOME/.cargo ]]; then
  echo -e "${YELLOW}Already exists${NORMAL}"
else
  curl https://sh.rustup.rs -sSf | sh -s -- -q -y --no-modify-path | grep -E "installed"
fi

echo -e "\n${LIGHTMAGENTA}Installing cli tools deps...${NORMAL}"
tools=(
  ripgrep,rg
  fd-find,fd
  zoxide
  lsd
  exa
  git-delta,delta
  stylua
  gping
  bat
  xh
  procs
  du-dust,dust
  bandwhich
  bottom,btm
  tealdeer,tldr
)

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

update_rust

for tool in ${tools[@]}; do
  cargo_install $tool
done

echo -e "\n${LIGHTMAGENTA}Symlinking stylua config...${NORMAL}"
[[ ! -d $HOME/.config/stylua ]] && mkdir -p $HOME/.config/stylua
symlink $DOTFILES_HOME/stylua.toml $HOME/.config/stylua/stylua.toml
echo -e "${GREEN}Done${NORMAL}"
