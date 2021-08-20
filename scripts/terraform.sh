#!/usr/bin/env bash

source scripts/helper.sh

echo -e "\n${LIGHTMAGENTA}Installing terraform...${NORMAL}"
case $ID in
  debian|ubuntu)
    packages=(
      gnupg
      curl
      software-properties-common
    )
    install ${packages[@]}

    echo -e "${GREY}Adding hashicorp gpg key...${NORMAL}"
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

    echo -e "${GREY}Adding hashicorp repo...${NORMAL}"
    sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

    echo -e "${GREY}Installing terraform and terraform-ls...${NORMAL}"
    install terraform terraform-ls
    ;;
  arch|manjaro)
    install terraform terraform-ls
    ;;
  *)
    echo -e "${LIGHTRED}Abort. Distro is not supported"
    exit 0
    ;;
esac
echo -e "${GREEN}Done${NORMAL}"
