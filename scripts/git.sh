#!/usr/bin/env bash

source scripts/helper.sh

GIT_FULLNAME="Kirill 'horseinthesky' Pletnev"
GIT_EMAIL=pwnedbyspawn@gmail.com

echo -e "\n${LIGHTMAGENTA}Installing git...${NORMAL}"
install git

echo -e "\n${LIGHTMAGENTA}Deploying git config${NORMAL}"
if [[ -f $HOME/.gitconfig ]]; then
  cp $HOME/.gitconfig $HOME/gitconfig.bak
  echo -e "${YELLOW}Backed up .gitconfig${NORMAL}"
fi

cp files/gitconfig.template $HOME/.gitconfig
sed -i \
  -e "s/FULL_NAME/$GIT_FULLNAME/g" \
  -e "s/GIT_EMAIL/$GIT_EMAIL/g" \
  $HOME/.gitconfig

echo -e "${GREEN}Done${NORMAL}"
