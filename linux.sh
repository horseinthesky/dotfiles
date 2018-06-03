#!/bin/bash
printf "${CYAN}Add apt repos and update...${NORMAL}\n"
ppas=(
  neovim-ppa/stable
)
for ppa in ${ppas[@]}; do
  if [ ! -f /etc/apt/sources.list.d/* ] || ! grep -q "deb .*$ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    sudo add-apt-repository ppa:$ppa
  fi
done
sudo apt-get -qq update
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Install apps from apt...${NORMAL}\n"
apt=(
  tmux
  cmake
  ctags
  libyaml-perl
  ack
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
