#!/usr/bin/env bash

source scripts/helper.sh

export PATH=$PATH:$HOME/.cargo/bin

build () {
  if [[ ! -d $HOME/.cargo ]]; then
    echo -e "${LIGHTRED}Cargo is not found. Please install cargo to build.${NORMAL}"
    return 1
  fi

  cd $HOME/ripgrep && \
    cargo build --release && \
    sudo mv ./target/release/rg /usr/local/bin/

  echo -e "${GREEN}Done${NORMAL}"
}

clone BurntSushi/ripgrep $HOME

echo -e "\n${LIGHTMAGENTA}Building ripgrep from source...${NORMAL}"
if [[ $(which rg) == "rg not found" ]]; then
  build
  [[ $? != 1 ]] && echo -e "${GREEN}Done${NORMAL}"
else
  CURRENT_VERSION=$(rg --version 2> /dev/null | head -n 1 | awk '{print $2}')
  LATEST_VERSION=$(sed '3!d' $HOME/ripgrep/Cargo.toml | awk '{print $3}' | tr -d '"')

  if [[ $CURRENT_VERSION < $LATEST_VERSION ]]; then
    build
    [[ $? == 1 ]] && echo -e "${YELLOW}rg $CURRENT_VERSION is already installed${NORMAL}"
  else
    echo -e "${YELLOW}Latest ($LATEST_VERSION) version is already installed${NORMAL}"
  fi
fi
