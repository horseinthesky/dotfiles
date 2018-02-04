#!/bin/bash
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NORMAL='\033[0m'
YELLOW='\033[0;33m'
FILESPATH=`pwd -P`/files
BACKUPPATH="${HOME}/backup"

printf "${GREEN}"
echo "______      _    __ _ _           "
echo "|  _  \    | |  / _(_) |          "
echo "| | | |___ | |_| |_ _| | ___  ___ "
echo "| | | / _ \| __|  _| | |/ _ \/ __|"
echo "| |/ / (_) | |_| | | | |  __/\__ \\"
echo "|___/ \___/ \__|_| |_|_|\___||___/"
printf "${NORMAl}\n\n"

printf "${CYAN}Installing packages...\n${NORMAL}"
if [ "$(uname)" = 'Linux' ]; then
  source linux.sh
fi
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Install oh-my-zsh and plugins...${NORMAL}\n"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone git://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/bhilburn/powerlevel9k.git $HOME/.oh-my-zsh/custom/themes/powerlevel9k
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Making backup folder...\n${NORMAL}"
if [ ! -d $BACKUPPATH ]; then
  mkdir ${BACKUPPATH}
fi
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Backing things up...\n${NORMAL}"
if [ -d "${HOME}/.config/nvim" ]; then
  mv --backup=numbered ~/.config/nvim ${BACKUPPATH}/nvim.backup
fi
mkdir -p ~/.config/nvim

if [ -f "${HOME}/.bashrc" ]; then
  mv --backup=numbered ~/.bashrc ${BACKUPPATH}/.bashrc.backup
fi

if [ -f "${HOME}/.tmux.conf" ]; then
  mv --backup=numbered ~/.tmux.conf ${BACKUPPATH}/.tmux.conf.backup
fi

if [ -f "${HOME}/.config/nvim/init.vim" ]; then
  mv --backup=numbered ~/.config/nvim/init.vim ${BACKUPPATH}/init.vim.backup
fi

if [ -f "${HOME}/.vimrc" ]; then
  mv --backup=numbered ~/.vimrc ${BACKUPPATH}/.vimrc.backup
fi

if [ -f "${HOME}/.zshrc" ]; then
  mv --backup=numbered ~/.zshrc ${BACKUPPATH}/.zshrc.backup
fi
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Creating symlinks...${NORMAL}\n"
ln -s ${FILESPATH}/.tmux.conf ~/.tmux.conf
ln -s ${FILESPATH}/init.vim ~/.config/nvim/init.vim
ln -s ${FILESPATH}/.zshrc ~/.zshrc
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Install Powerline and font...${NORMAL}\n"
sudo pip3 install git+git://github.com/Lokaltog/powerline

if [ ! -d "~/.local/share/fonts/" ]; then
  mkdir -p ~/.local/share/fonts/
fi

curl -fLo "DejaVu Sans Mono Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf
mv DejaVu\ Sans\ Mono\ Nerd\ Font\ Complete.ttf $HOME/.local/share/fonts/

printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Install vim plug...${NORMAL}\n"
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Changing user shell...${NORMAL}\n"
chsh -s $(which zsh)
printf "${GREEN}DONE!${NORMAL}\n"

printf "${GREEN}COMPLETE!${NORMAL}\n"
