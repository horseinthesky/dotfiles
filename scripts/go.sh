#!/usr/bin/env bash

source scripts/helper.sh

go_install () {
  local tool=$(echo ${1} | awk -F/ '{print $NF}')

  info "Installing $tool..."

  PATH=$HOME/.local/bin:$PATH

  if [[ -z $(which go) ]]; then
    error "Go is not found. Can't procced"
    return 1
  fi

  if [[ -n $(which $tool) ]]; then
    success "$tool already exists"
    return
  fi

  go install github.com/${1}@latest
  success "$tool installed"
}

install_go () {
  header "Installing go..."

  local version=1.20.3
  local tarball=go${version}.linux-amd64.tar.gz

  [[ ! -d $HOME/.local/bin ]] && mkdir -p $HOME/.local/bin
  [[ ! -d $HOME/.local/lib ]] && mkdir -p $HOME/.local/lib
  [[ ! $PATH == *$HOME/.local/bin* ]] && export PATH=$HOME/.local/bin:$PATH

  if [[ -n $(which go) ]] && [[ $(go version | awk '{print $3}' | cut -c3-) == $version ]]; then
    success "Latest version ($version) is already installed."
    return
  fi

  # Remove old ersion
  [[ -d $HOME/.local/lib/go ]] && rm -rf $HOME/.local/lib/go

  # Install a new one
  download https://dl.google.com/go/$tarball
  [[ $? -ne 0 ]] && exit

  info "Extracting archive..."
  tar -C $HOME/.local/lib -xzf $HOME/$tarball

  # Remove tarball
  rm $HOME/$tarball

  success
}

symlink_go () {
  header "Symlink go"
  symlink $HOME/.local/lib/go/bin/go $HOME/.local/bin/go
  symlink $HOME/.local/lib/go/bin/gofmt $HOME/.local/bin/gofmt
}

install_go_tools () {
  header "Installing go tools..."

  tools=(
    muesli/duf
    charmbracelet/glow
    fatih/gomodifytags
    cweill/gotests/...
    natesales/q
  )

  for tool in ${tools[@]}; do
    go_install $tool
  done

  info "Installing gopls..."
  GO111MODULE=on go install golang.org/x/tools/gopls@latest
  success
}

main () {
  install_go
  symlink_go
  install_go_tools
}

main
