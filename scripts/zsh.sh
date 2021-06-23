#!/usr/bin/env bash

source scripts/helper.sh

OHMYZSH_CUSTOM_PLUGINS=$HOME/.ohmyzsh/custom/plugins
OHMYZSH_CUSTOM_THEMES=$HOME/.ohmyzsh/custom/themes
FONT=DejaVu\ Sans\ Mono\ Nerd\ Font\ Complete.ttf

plugins=(
  zsh-users/zsh-autosuggestions
  wfxr/forgit
  djui/alias-tips
)

themes=(
  romkatv/powerlevel10k
)

echo -e "\n${LIGHTMAGENTA}Downloading font...${NORMAL}"
if [[ ! -d $HOME/.local/share/fonts ]]; then
  mkdir -p $HOME/.local/share/fonts
fi

if [[ ! -f $HOME/.local/share/fonts/"$FONT" ]]; then
  curl https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf -o $HOME/.local/share/fonts/"$FONT"
  echo -e "${GREEN}Done${NORMAL}"
else
  echo -e "${YELLOW}Already exits${NORMAL}"
fi

echo -e "\n${LIGHTMAGENTA}Installing zsh...${NORMAL}"
install zsh | grep -P "\d\K upgraded"

clone ohmyzsh/ohmyzsh $HOME .

for plugin in ${plugins[@]}; do
  clone $plugin $OHMYZSH_CUSTOM_PLUGINS
done

for theme in ${themes[@]}; do
  clone $theme $OHMYZSH_CUSTOM_THEMES
done

echo -e "\n${LIGHTMAGENTA}Symlink .zshrc${NORMAL}"
symlink $DOTFILES_HOME/.zshrc $HOME/.zshrc

echo -e "\n${LIGHTMAGENTA}Setting shell${NORMAL}"
sudo chsh -s $(which zsh) $(whoami)
echo -e "${GREEN}Done${NORMAL}"
