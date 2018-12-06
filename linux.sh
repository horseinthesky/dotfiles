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
  exuberant-ctags
  libyaml-perl
  ack
  software-properties-common
  python3-software-properties
  python3-dev
  python3-pip
  python3-venv
  neovim
  sqlite3
  zsh
  htop
  tree
  speedtest-cli
  golang
  golang-go.tools
  build-essential
  libssl-dev
  zlib1g-dev
  libbz2-dev
  libreadline-dev
  libsqlite3-dev
  wget
  curl
  llvm
  libncurses5-dev
  xz-utils tk-dev
  libxml2-dev
  libxmlsec1-dev
  libffi-dev
)

for program in ${apt[@]}; do
  sudo apt-get -qqy install $program
done

wget https://github.com/sharkdp/fd/releases/download/v7.2.0/fd_7.2.0_amd64.deb -P ~/
sudo dpkg -i ~/fd_7.2.0_amd64.deb
rm ~/fd_7.2.0_amd64.deb
