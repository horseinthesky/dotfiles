#!/usr/bin/env bash

source scripts/helper.sh

install_lua () {
  header "Installing lua..."

  local version=5.4.3
  local tarball=lua-${version}.tar.gz

  if [[ -n $(command -v lua) ]] && [[ $(lua -v | awk '{print $2}') == "$version" ]]; then
    success "Latest version ($version) is already installed."
    return
  fi

  # Remove old ersion
  [[ -d $HOME/.local/lib/lua ]] && rm -rf "$HOME"/.local/lib/lua

  download http://www.lua.org/ftp/"$tarball"
  [[ $? -ne 0 ]] && exit

  info "Extracting archive..."
  tar -xzf "$HOME/$tarball" --directory "$HOME"/.local/lib
  rm "$HOME/$tarball"

  info "Compiling..."
  mv "$HOME/.local/lib/lua-$version" "$HOME"/.local/lib/lua
  cd "$HOME"/.local/lib/lua/src && make all &> /dev/null

  symlink "$HOME"/.local/lib/lua/src/lua "$HOME"/.local/bin/lua
}

install_lua_ls () {
  header "Installing lua-ls..."

  local architecture=$(uname -m)

  case "$architecture" in
    x86_64)
      arch=x64
      ;;
    aarch64)
      arch=arm64
      ;;
    *)
      error "Unsupported architecture. Can't proceed"
      exit
      ;;
  esac

  local version=3.9.3
  local tarball=lua-language-server-$version-linux-$arch.tar.gz

  download https://github.com/LuaLS/lua-language-server/releases/download/"$version/$tarball"
  [[ $? -ne 0 ]] && exit

  info "Extracting archive..."
  local server_dir=$HOME/.cache/lua-language-server
  [[ ! -d $server_dir ]] && mkdir -p "$server_dir"

  tar -zxf "$HOME/$tarball" --directory "$server_dir"
  rm "$HOME/$tarball"

  local out=$HOME/.local/bin/lua-language-server
  symlink "$server_dir"/bin/lua-language-server "$out"
}

main () {
  install_lua
  install_lua_ls
}

main
