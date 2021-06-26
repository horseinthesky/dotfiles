#!/usr/bin/env bash

source scripts/helper.sh

pyenv_versions=(
  3.9.5
)

source /etc/os-release

echo -e "\n${LIGHTMAGENTA}Installing pyenv deps...${NORMAL}"
case $ID_LIKE in
  debian)
    packages=(
      make
      build-essential
      libssl-dev
      zlib1g-dev
      libbz2-dev
      libreadline-dev
      libsqlite3-dev
      wget
      curl
      llvm
      libncurses5-dev
      xz-utils
      tk-dev
      libxml2-dev
      libxmlsec1-dev
      libffi-dev
      liblzma-dev
    )
    install ${packages[@]} | grep -E "upgraded"
    ;;
  arch)
    packages=(
      base-devel
      openssl
      zlib
      xz
    )
    install ${packages[@]} | grep -E "upgraded"
    ;;
esac
echo -e "${GREEN}Done${NORMAL}"

clone pyenv/pyenv $HOME .

clone pyenv/pyenv-update $HOME/.pyenv/plugins

echo -e "\n${LIGHTMAGENTA}Installing pyenv versions...${NORMAL}"
[[ ! -d $HOME/.local/bin ]] && mkdir -p $HOME/.local/bin

PATH=$PATH:$HOME/.pyenv
for version in ${pyenv_versions[@]}; do
  pyenv install $version --skip-existing
  symlink $HOME/.pyenv/versions/$version/bin/python \
    $HOME/.local/bin/python$(echo 3.9.5 | awk -F- '{print $1}' | awk -F. '{print $1"."$2}')
done
