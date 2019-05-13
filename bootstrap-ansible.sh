#!/bin/bash
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NORMAL='\033[0m'

printf "${CYAN}Install base packages...${NORMAL}\n"
sudo apt update -y
sudo apt install python3-pip -y
sudo pip3 install -U pip
sudo pip install --ignore-installed pyyaml
sudo pip install ansible
printf "${GREEN}DONE!${NORMAL}\n"
