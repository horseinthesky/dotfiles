#!/usr/bin/env bash

source scripts/helper.sh

GO_VERSION=1.16.5

echo -e "\n${LIGHTMAGENTA}Installing go...${NORMAL}"
[[ ! -d $HOME/.local/bin ]] && mkdir -p $HOME/.local/bin
[[ ! -d $HOME/.local/lib ]] && mkdir -p $HOME/.local/lib
PATH=$PATH:$HOME/.local/bin

if [[ -z $(which go) ]] || [[ $(go version | awk '{print $3}' | cut -c3-) < $GO_VERSION ]]; then
  # Remove old ersion
  [[ -d $HOME/.local/lib/go ]] && rm -rf $HOME/.local/lib/go

  echo -e "${GREY}Downloading go tarball...${NORMAL}"
  curl -s https://dl.google.com/go/go$GO_VERSION.linux-amd64.tar.gz -o $HOME/go$GO_VERSION.linux-amd64.tar.gz

  echo -e "${GREY}Extracting archive...${NORMAL}"
  tar -C $HOME/.local/lib -xzf $HOME/go$GO_VERSION.linux-amd64.tar.gz

  # Remove tarball
  rm $HOME/go$GO_VERSION.linux-amd64.tar.gz

  # Create or update a symlink to binary
  ln -snf $HOME/.local/lib/go/bin/go $HOME/.local/bin/go

  echo -e "${GREEN}Done${NORMAL}"
else
  echo -e "${YELLOW}Latest version ($GO_VERSION) is already installed.${NORMAL}"
fi
