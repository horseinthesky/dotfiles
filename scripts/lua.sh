#!/usr/bin/env bash

source scripts/helper.sh

LUA_VERSION=5.4.3

echo -e "\n${LIGHTMAGENTA}Installing lua...${NORMAL}"
if [[ -z $(which lua) ]] || [[ $(lua -v | awk '{print $2}') < $LUA_VERSION ]]; then
  # Remove old ersion
  [[ -d /usr/local/lib/lua ]] && sudo rm -rf /usr/local/lib/lua

  echo -e "${GREY}Downloading new version tarball...${NORMAL}"
  curl -s http://www.lua.org/ftp/lua-$LUA_VERSION.tar.gz -o $HOME/lua-$LUA_VERSION.tar.gz

  echo -e "${GREY}Extracting archive...${NORMAL}"
  # Extract archive
  sudo tar -C /usr/local/lib -xzf $HOME/lua-$LUA_VERSION.tar.gz
  sudo mv /usr/local/lib/lua-$LUA_VERSION /usr/local/lib/lua

  echo -e "${GREY}Compiling...${NORMAL}"
  cd /usr/local/lib/lua/src && sudo make all &> /dev/null

  # Remove tarball
  rm $HOME/lua-$LUA_VERSION.tar.gz

  # Create or update a symlink to binary
  sudo ln -sf /usr/local/lib/lua/src/lua /usr/local/bin/lua

  echo -e "${GREEN}Done${NORMAL}"
else
  echo -e "${YELLOW}Latest version ($LUA_VERSION) is already installed.${NORMAL}"
fi
