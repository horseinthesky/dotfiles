#!/bin/bash
printf "${CYAN}Add apt repos and update...${NORMAL}\n"
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get -qq update
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Install apps from apt...${NORMAL}\n"
apt=(
  tmux
  cmake
  ctags
  libyaml-perl
  silversearcher-ag
  software-properties-common
  python3-software-properties
  neovim
  python3-dev
  python3-pip
  curl
  zsh
)

for program in ${apt[@]}; do
  sudo apt-get -qqy install $program
done
