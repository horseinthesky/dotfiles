#!/usr/bin/env bash

source scripts/helper.sh

LUA_VERSION=5.4.3

echo -e "\n${LIGHTMAGENTA}Installing lua...${NORMAL}"
[[ ! -d $HOME/.local/bin ]] && mkdir -p $HOME/.local/bin
[[ ! -d $HOME/.local/lib ]] && mkdir -p $HOME/.local/lib
PATH=$PATH:$HOME/.local/bin

if [[ -n $(which lua) ]] && [[ $(lua -v | awk '{print $2}') == $LUA_VERSION ]]; then
  echo -e "${YELLOW}Latest version ($LUA_VERSION) is already installed.${NORMAL}"
  exit 0
fi

# Remove old ersion
[[ -d $HOME/.local/lib/lua ]] && rm -rf $HOME/.local/lib/lua

echo -e "${GREY}Downloading new version tarball...${NORMAL}"
curl -s http://www.lua.org/ftp/lua-$LUA_VERSION.tar.gz -o $HOME/lua-$LUA_VERSION.tar.gz

echo -e "${GREY}Extracting archive...${NORMAL}"

# Extract archive
tar -C $HOME/.local/lib -xzf $HOME/lua-$LUA_VERSION.tar.gz
mv $HOME/.local/lib/lua-$LUA_VERSION $HOME/.local/lib/lua

echo -e "${GREY}Compiling...${NORMAL}"
cd $HOME/.local/lib/lua/src && make all &> /dev/null

# Remove tarball
rm $HOME/lua-$LUA_VERSION.tar.gz

# Create or update a symlink to binary
ln -snf $HOME/.local/lib/lua/src/lua $HOME/.local/bin/lua

echo -e "${GREEN}Done${NORMAL}"
