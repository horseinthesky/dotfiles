#!/bin/bash
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NORMAL='\033[0m'
YELLOW='\033[0;33m'
SCRIPTPATH=`pwd -P`
BACKUPPATH="${HOME}/backup"

printf "${GREEN}"
echo "______      _    __ _ _           "
echo "|  _  \    | |  / _(_) |          "
echo "| | | |___ | |_| |_ _| | ___  ___ "
echo "| | | / _ \| __|  _| | |/ _ \/ __|"
echo "| |/ / (_) | |_| | | | |  __/\__ \\"
echo "|___/ \___/ \__|_| |_|_|\___||___/"
printf "${NORMAl}\n\n"

if [ ! -d $BACKUPPATH ]; then
  mkdir ${BACKUPPATH}
fi

printf "${CYAN}Installation started...\n${NORMAL}"
if [ "$(uname)" = 'Linux' ]; then
  source linux.sh
fi

if [ -d "${HOME}/.config" ]; then
  mv --backup=numbered ~/.config/nvim ${BACKUPPATH}/nvim.back
fi
mkdir -p ~/.config/nvim

printf "${CYAN}Install vim plug...${NORMAL}\n"
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Backup cfgs and create symlinks to .tmux.conf and init.vim...${NORMAL}\n"

if [ -f "${HOME}/.bashrc" ]; then
  mv ~/.bashrc ${BACKUPPATH}/.bashrc.back
fi

if [ -f "${HOME}/.tmux.conf" ]; then
  mv ~/.tmux.conf ${BACKUPPATH}/.tmux.conf.back
fi

if [ -f "${HOME}/.config/nvim/init.vim" ]; then
  mv ~/.config/nvim/init.vim ${BACKUPPATH}/init.vim.back
fi

if [ -f "${HOME}/.vimrc" ]; then
  mv ~/.vimrc ${BACKUPPATH}/.vimrc.back
fi

ln -s ${SCRIPTPATH}/.tmux.conf ~/.tmux.conf
ln -s ${SCRIPTPATH}/init.vim ~/.config/nvim/init.vim
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Install oh-my-zsh and plugins...${NORMAL}\n"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone git://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/bhilburn/powerlevel9k.git $HOME/.oh-my-zsh/custom/themes/powerlevel9k

if [ -f "${HOME}/.zshrc" ]; then
  mv ~/.zshrc ${BACKUPPATH}/.zshrc.back
fi
ln -s ${SCRIPTPATH}/.zshrc ~/.zshrc

chsh -s $(which zsh)
env zsh

printf "${GREEN}DONE!${NORMAL}\n"
printf "${GREEN}COMPLETE!${NORMAL}\n"
