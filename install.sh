#!/bin/bash
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NORMAL='\033[0m'
YELLOW='\033[0;33m'
FILESPATH=`pwd -P`/files
BACKUPPATH="$HOME/backup"

printf "${GREEN}"
echo "______      _    __ _ _           "
echo "|  _  \    | |  / _(_) |          "
echo "| | | |___ | |_| |_ _| | ___  ___ "
echo "| | | / _ \| __|  _| | |/ _ \/ __|"
echo "| |/ / (_) | |_| | | | |  __/\__ \\"
echo "|___/ \___/ \__|_| |_|_|\___||___/"
printf "${NORMAl}\n\n"

printf "${CYAN}Making backup folder...\n${NORMAL}"
if [ ! -d "$BACKUPPATH" ]; then
  mkdir ${BACKUPPATH}
fi
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Backing things up...\n${NORMAL}"
if [ ! -L "$HOME/.tmux.conf" ] && [ -f "$HOME/.tmux.conf" ]; then
  mv --backup=numbered ~/.tmux.conf ${BACKUPPATH}/.tmux.conf.backup
fi

if [ ! -L "$HOME/.config/nvim/init.vim" ] && [ -f "$HOME/.config/nvim/init.vim" ]; then
  mv --backup=numbered ~/.config/nvim/init.vim ${BACKUPPATH}/init.vim.backup
fi

if [ ! -L "$HOME/.zshrc" ] && [ -f "$HOME/.zshrc" ]; then
  mv --backup=numbered ~/.zshrc ${BACKUPPATH}/.zshrc.backup
fi
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Installing packages...\n${NORMAL}"
if [ "$(uname)" = 'Linux' ]; then
  source linux.sh
fi
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Installing python3 modules...\n${NORMAL}"
sudo pip3 install -U pip
sudo pip install --ignore-installed -U pyyaml
sudo pip install -U -r requirements.txt
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Installing pyenv...\n${NORMAL}"
if [ ! -d "$HOME/.pyenv/" ]; then
  curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
fi
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Installing poetry...\n${NORMAL}"
if [ ! -d "$HOME/.poetry/" ]; then
  curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python
  sed -i 's/virtualenvs]/virtualenvs]\nin-project = true/' ~/.config/pypoetry/config.toml
fi
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Install oh-my-zsh and plugins...${NORMAL}\n"
if [ ! -f "$HOME/.oh-my-zsh/tools/install.sh" ]; then
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
  git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel9k/" ]; then
  git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
fi
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Install vim plug...${NORMAL}\n"
if [ ! -f "$HOME/.config/nvim/autoload/plug.vim" ]; then
  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Install fonts...${NORMAL}\n"
if [ ! -d "$HOME/.local/share/fonts/" ]; then
  mkdir -p ~/.local/share/fonts/
fi

if [ ! -f "$HOME/.local/share/fonts/DejaVu Sans Mono Nerd Font Complete.ttf" ]; then
  curl -fLo ~/.local/share/fonts/"DejaVu Sans Mono Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf
fi
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Changing user shell...${NORMAL}\n"
if [ "$(getent passwd $USER | cut -d: -f7)" != "$(which zsh)" ]; then
  chsh -s $(which zsh)
fi
printf "${GREEN}DONE!${NORMAL}\n"

printf "${CYAN}Creating symlinks...${NORMAL}\n"
ln -fs ${FILESPATH}/.tmux.conf ~/.tmux.conf
ln -fs ${FILESPATH}/init.vim ~/.config/nvim/init.vim
ln -fs ${FILESPATH}/.zshrc ~/.zshrc
printf "${GREEN}DONE!${NORMAL}\n"

printf "${GREEN}COMPLETE!${NORMAL}\n"
