
#!/usr/bin/env bash

source scripts/helper.sh

export PATH=$PATH:$HOME/.cargo/bin

build () {
  if [[ ! -d $HOME/.cargo ]]; then
    echo -e "${LIGHTRED}Cargo is not found. Please install cargo to build.${NORMAL}"
    return 1
  fi

  cd $HOME/fd && \
    cargo install fd-find --force

  echo -e "${GREEN}Done${NORMAL}"
}

clone sharkdp/fd $HOME

echo -e "\n${LIGHTMAGENTA}Installing fd...${NORMAL}"
if [[ $(which fd) == "fg not found" ]]; then
  build
  [[ $? != 1 ]] && echo -e "${GREEN}Done${NORMAL}"
else
  CURRENT_VERSION=$(fd --version 2> /dev/null | awk '{print $2}')
  LATEST_VERSION=$(sed '19!d' $HOME/fd/Cargo.toml | awk '{print $3}' | tr -d '"')

  if [[ $CURRENT_VERSION < $LATEST_VERSION ]]; then
    build
    [[ $? == 1 ]] && echo -e "${YELLOW}fd $CURRENT_VERSION is already installed${NORMAL}"
  else
    echo -e "${YELLOW}Latest ($LATEST_VERSION) version is already installed${NORMAL}"
  fi
fi
