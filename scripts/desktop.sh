#!/usr/bin/env bash

source scripts/helper.sh

echo -e "\n${LIGHTMAGENTA}Setting up desktop${NORMAL}"
if [[ -z $(echo $XDG_CURRENT_DESKTOP) ]]; then
  echo -e "${YELLOW}Abort. No GUI found${NORMAL}"
  exit
fi

echo -e "\n${LIGHTMAGENTA}Installing packages...${NORMAL}"
packages=(
  gnome-tweaks
  dconf-editor
)
install ${packages[@]}

echo -e "\n${LIGHTMAGENTA}Installing flameshot...${NORMAL}"
FLAMESHOT=flameshot-11.0.0-1.ubuntu-20.04.amd64.deb
curl -sL https://github.com/flameshot-org/flameshot/releases/download/v11.0.0/$FLAMESHOT -o $HOME/$FLAMESHOT
sudo dpkg -i $FLAMESHOT 1> /dev/null
rm $HOME/$FLAMESHOT
echo -e "${GREEN}Done${NORMAL}"

echo -e "\n${LIGHTMAGENTA}Installing kitty...${NORMAL}"
curl -sL https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
ln -s $HOME/.local/kitty.app/bin/kitty $HOME/.local/bin/kitty
symlink $DOTFILES_HOME/kitty $HOME/.config
cp $DOTFILES_HOME/kitty/kitty.desktop $HOME/.local/share/applications/
sed -i 's|PLACEHOLDER|'"$HOME"'|' .local/share/applications/kitty.desktop
echo -e "${GREEN}Done${NORMAL}"

echo -e "\n${LIGHTMAGENTA}Downloading nerd font...${NORMAL}"
FONT=DejaVu\ Sans\ Mono\ Nerd\ Font\ Complete.ttf
FONT_DIR=$HOME/.fonts

if [[ ! -d $FONT_DIR ]]; then
  mkdir -p $FONT_DIR
fi

if [[ -f $FONT_DIR/"$FONT" ]]; then
  echo -e "${YELLOW}Already exists${NORMAL}"
fi
curl https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf -o $FONT_DIR/$FONT
echo -e "${GREEN}Done${NORMAL}"
