#!/bin/bash
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NORMAL='\033[0m'
YELLOW='\033[0;33m'
SCRIPTPATH=`pwd -P`
BACKUPPATH='~/backup/'

printf "${GREEN}"
echo "______      _    __ _ _           "
echo "|  _  \    | |  / _(_) |          "
echo "| | | |___ | |_| |_ _| | ___  ___ "
echo "| | | / _ \| __|  _| | |/ _ \/ __|"
echo "| |/ / (_) | |_| | | | |  __/\__ \\"
echo "|___/ \___/ \__|_| |_|_|\___||___/"
printf "${NORMAl}\n\n"

mkdir ${BACKUPPATH}

printf "${CYAN}Installation started...\n${NORMAL}"
if [ "$(uname)" = 'Linux' ]; then
  source linux.sh

if [ ! -d "~/.config" ]; then
  mkdir ~/.config
  mkdir ~/.config/nvim
fi

printf "${CYAN}Install vim plug...${NORMAL}\n"
mv --backup=numbered ~/.config/nvim ${BACKUPPATH}/nvim.back
if [ "$1" = '--classic-vim' ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Create symlinks to .tmux.conf and init.vim...${NORMAL}\n"
mv ~/.tmux.conf ${BACKUPPATH}.tmux.conf.back

if [ "$(uname)" = 'Linux' ]; then
  ln -s ${SCRIPTPATH}/.tmux.conf ~/.tmux.conf
fi

mv ~/.config/nvim/init.vim ${BACKUPPATH}init.vim.back
mv ~/.vimrc ${BACKUPPATH}.vimrc.back

ln -s ${SCRIPTPATH}/init.vim ~/.config/nvim/init.vim
if [ "$1" = '--classic-vim' ]; then
  ln -s ${SCRIPTPATH}/init.vim ~/.vimrc
fi
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Install oh-my-zsh and plugins...${NORMAL}\n"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
mv ~/.zshrc ${BACKUPPATH}zshrc.back
ln -s ${SCRIPTPATH}/.zshrc ~/.zshrc

if [ ! "$1" = '--classic-vim' ]; then
  echo "alias vim='nvim'" >> ~/.zshrc
fi

chsh -s $(which zsh)
printf "${GREEN}DONE!${NORMAL}\n"
printf "${GREEN}COMPLETE!${NORMAL}\n"
