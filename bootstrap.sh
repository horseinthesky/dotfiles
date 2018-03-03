#!/bin/bash
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NORMAL='\033[0m'

printf "${CYAN}Install base packages...${NORMAL}\n"
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update -y
sudo apt-get install ansible -y
printf "${GREEN}DONE!${NORMAL}\n"
