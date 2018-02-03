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
  git-extras
)

pip=(
  pip
  ansible
  neovim
  ipython
  flake8
  pep8
  pylint
  pycodestyle
)

for program in ${apt[@]}; do
  sudo apt-get -qqy install $program
done

for program in ${pip[@]}; do
  sudo pip install --upgrade $program
done

printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Install Powerline...${NORMAL}\n"
sudo pip3 install git+git://github.com/Lokaltog/powerline

if [ ! -d "~/.local/share/fonts/" ]; then
  mkdir -p ~/.local/share/fonts/
fi

curl -fLo "DejaVu Sans Mono Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf
mv DejaVu\ Sans\ Mono\ Nerd\ Font\ Complete.ttf $HOME/.local/share/fonts/

printf "${GREEN}DONE!${NORMAL}\n"
