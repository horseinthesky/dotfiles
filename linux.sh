#!/bin/bash
printf "${CYAN}Add apt repos and update...${NORMAL}\n"
sudo apt-add-repository ppa:ansible/ansible
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get -qq update
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Setting up git...${NORMAL}\n"
git config --global user.name "horseinthesky"
git config --global user.email pwnedbyspawn@gmail.com
git config --global core.editor nvim
git config --global merge.tool vimdiff
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Install apps from apt-get...${NORMAL}\n"
sudo apt-get -qqy install python
sudo apt-get -qqy install vim
sudo apt-get -qqy install software-properties-common
sudo apt-get -qqy install python-software-properties
sudo apt-get -qqy install ansible
sudo apt-get -qqy install neovim
sudo apt-get -qqy install python-dev
sudo apt-get -qqy install python-pip
sudo apt-get -qqy install python3-dev
sudo apt-get -qqy install python3-pip
sudo apt-get -qqy install silversearcher-ag
sudo apt-get -qqy install curl
sudo apt-get -qqy install zsh
sudo apt-get -qqy install git-extras
pip3 install --upgrade neovim
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Install Powerline...${NORMAL}\n"
su -c 'pip install git+git://github.com/Lokaltog/powerline'
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete%20Mono.otf
sudo mv Droid%20Sans%20Mono%20Nerd%20Font%20Complete%20Mono.otf /usr/share/fonts/
sudo fc-cache -vf
sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/
printf "${GREEN}DONE!${NORMAL}\n"
printf "${GREEN}COMPLETE!${NORMAL}\n"
