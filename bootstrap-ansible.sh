#!/bin/bash
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NORMAL='\033[0m'

printf "${CYAN}Install base packages...${NORMAL}\n"
source /etc/os-release
case $ID_LIKE in
  debian)
    sudo apt update -y
    sudo apt install python3-pip -y
    ;;
  "rhel fedora")
    sudo yum update -y
    sudo yum install python3-pip -y
    ;;
  arch)
    sudo pacman -Sy --noconfirm
    sudo pacman -S python-pip --noconfirm
    ;;
  *)
    case $ID in
      debian)
        sudo apt update -y
        sudo apt install python3-pip -y
        ;;
      arch)
        sudo pacman -Sy --noconfirm
        sudo pacman -S python-pip --noconfirm
        ;;
    esac
esac
sudo pip3 install -U pip
sudo pip3 install --ignore-installed pyyaml
sudo pip3 install ansible
printf "${GREEN}DONE!${NORMAL}\n"
