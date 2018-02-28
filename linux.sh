#!/bin/bash
printf "${CYAN}Add apt repos and update...${NORMAL}\n"
sudo apt-add-repository ppa:ansible/ansible
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get -qq update
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Install apps from apt-get and pip...${NORMAL}\n"
apt=(
  tmux
  cmake
  ctags
  libyaml-perl
  silversearcher-ag
  software-properties-common
  python3-software-properties
  ansible
  neovim
  python3-dev
  python3-pip
  curl
  zsh
)

pip=(
  pip
  ansible
  neovim
  ipython
  paramiko
  netmiko
  pyyaml
  flake8
  pep8
  pylint
  pycodestyle
  pyyaml
  paramiko
  netmiko
  netdev
  asyncio
  jinja2
  scp
)

for program in ${apt[@]}; do
  sudo apt-get -qqy install $program
done

for program in ${pip[@]}; do
  sudo pip3 install --upgrade $program
done

printf "${GREEN}DONE!${NORMAL}\n"
