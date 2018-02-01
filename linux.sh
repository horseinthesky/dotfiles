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
git config --global credential.helper store
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Install apps from apt-get and pip...${NORMAL}\n"
sudo apt-get -qqy install tmux
sudo apt-get -qqy install cmake
sudo apt-get -qqy install ctags
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

sudo pip3 install --upgrade pip
sudo pip3 install --upgrade neovim
sudo pip3 install --upgrade ipython
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Install Powerline...${NORMAL}\n"
sudo pip3 install git+git://github.com/Lokaltog/powerline

if [ ! -d "~/.local/share/fonts/" ]; then
  mkdir -p ~/.local/share/fonts/
fi
curl -fLo https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf
mv DejaVu\ Sans\ Mono\ Nerd\ Font\ Complete.ttf $HOME/.local/share/fonts/

printf "${GREEN}DONE!${NORMAL}\n"
printf "${GREEN}COMPLETE!${NORMAL}\n"
