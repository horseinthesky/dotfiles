#!/usr/bin/env bash

source scripts/helper.sh

packages=(
  whois
  ipcalc
  mtr
)

echo -e "\n${LIGHTMAGENTA}Installing packages...${NORMAL}"
install ${packages[@]} | grep -P "\d\K upgraded"


echo -e "\n${LIGHTMAGENTA}Downloading asn...${NORMAL}"
curl -s https://raw.githubusercontent.com/nitefood/asn/master/asn > $HOME/asn && \
  chmod +x $HOME/asn &&
  sudo mv $HOME/asn /usr/local/bin/asn
echo -e "${GREEN}Done${NORMAL}"
