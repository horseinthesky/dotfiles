#!/usr/bin/env bash

source scripts/helper.sh

packages=(
  whois
  ipcalc
  mtr
)

echo -e "\n${LIGHTMAGENTA}Installing asn deps...${NORMAL}"
install ${packages[@]}

echo -e "\n${LIGHTMAGENTA}Downloading asn...${NORMAL}"
[[ ! -d $HOME/.local/bin ]] && mkdir -p $HOME/.local/bin

if [[ -f $HOME/.local/bin/asn ]]; then
  echo -e "${YELLOW}Already installed${NORMAL}"
  exit
fi

curl -s https://raw.githubusercontent.com/nitefood/asn/master/asn > \
  $HOME/.local/bin/asn && \
  chmod +x $HOME/.local/bin/asn &&
echo -e "${GREEN}Done${NORMAL}"
