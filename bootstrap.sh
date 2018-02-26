#!/bin/bash
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NORMAL='\033[0m'

printf "${CYAN}Install base packages...${NORMAL}\n"
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update -y
sudo apt-get install python3-pip python3-dev ansible git -y
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Setting up git...${NORMAL}\n"
git config --global user.name "horseinthesky"
git config --global user.email pwnedbyspawn@gmail.com
git config --global core.editor nvim
git config --global merge.tool vimdiff
git config --global credential.helper store
git config --global push.default simple
printf "${GREEN}DONE!${NORMAL}\n"
