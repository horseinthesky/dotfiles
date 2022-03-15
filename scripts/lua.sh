#!/usr/bin/env bash

source scripts/helper.sh

install_lua () {
  header "Installing lua..."

  local version=5.4.3
  local tarball=lua-${version}.tar.gz

  [[ ! -d $HOME/.local/bin ]] && mkdir -p $HOME/.local/bin
  [[ ! -d $HOME/.local/lib ]] && mkdir -p $HOME/.local/lib

  PATH=$PATH:$HOME/.local/bin

  if [[ -n $(which lua) ]] && [[ $(lua -v | awk '{print $2}') == $version ]]; then
    success "Latest version ($version) is already installed."
    return
  fi

  # Remove old ersion
  [[ -d $HOME/.local/lib/lua ]] && rm -rf $HOME/.local/lib/lua

  download http://www.lua.org/ftp/$tarball $HOME
  [[ $? -ne 0 ]] && exit

  info "Extracting archive..."
  tar -C $HOME/.local/lib -xzf $HOME/$tarball
  mv $HOME/.local/lib/lua-$version $HOME/.local/lib/lua

  info "Compiling..."
  cd $HOME/.local/lib/lua/src && make all &> /dev/null

  rm $HOME/$tarball

  success
}

symlink_lua () {
  header "Symlink Lua"
  symlink $HOME/.local/lib/lua/src/lua $HOME/.local/bin/lua
}

main () {
  install_lua
  symlink_lua
}

main
