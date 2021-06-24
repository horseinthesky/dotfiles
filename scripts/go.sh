#!/usr/bin/env bash

source scripts/helper.sh

GO_VERSION=1.16.5

echo -e "\n${LIGHTMAGENTA}Installing go...${NORMAL}"
if [[ -z $(which go) ]] || [[ $(go version | awk '{print $3}' | cut -c3-) < $GO_VERSION ]]; then
  # Remove old ersion
  [[ -d /usr/local/lib/go ]] && sudo rm -rf /usr/local/bin/go

  # Download new version tarball
  curl -s https://dl.google.com/go/go$GO_VERSION.linux-amd64.tar.gz -o $HOME/go$GO_VERSION.linux-amd64.tar.gz

  # Extract archive
  sudo tar -C /usr/local/lib -xzf $HOME/go$GO_VERSION.linux-amd64.tar.gz

  # Remove tarball
  rm $HOME/go$GO_VERSION.linux-amd64.tar.gz

  # Create or update a symlink to binary
  sudo ln -sf /usr/local/bin/go /usr/local/lib/go/bin/go

  echo -e "${GREEN}Done${NORMAL}"
else
  echo -e "${YELLOW}Latest version ($GO_VERSION) is already installed.${NORMAL}"
fi

