#!/usr/bin/env bash

source scripts/helper.sh

go_install () {
  local path=$1
  local tool=$(echo "$path" | awk -F/ '{print $(NF-1)"/"$NF}')

  if [[ -z $(which go) ]]; then
    error "Go is not found. Can't procced"
    return 1
  fi

  info "Installing $tool..."
  go install "$path"@latest
  success "$tool installed"
}

install_go () {
  header "Installing go..."

  local version=1.21.11
  local tarball=go${version}.linux-$ARCH.tar.gz

  if [[ -n $(which go) ]] && [[ $(go version | awk '{print $3}' | cut -c3-) == $version ]]; then
    success "Latest version ($version) is already installed."
    return
  fi

  # Remove old version
  [[ -d $HOME/.local/lib/go ]] && rm -rf "$HOME"/.local/lib/go

  # Install a new one
  download https://dl.google.com/go/"$tarball"
  [[ $? -ne 0 ]] && exit

  info "Extracting archive..."
  tar -C "$HOME"/.local/lib -xzf "$HOME/$tarball"

  # Remove tarball
  rm "$HOME/$tarball"

  success
}

symlink_go () {
  header "Symlink go"
  symlink "$HOME"/.local/lib/go/bin/go "$HOME"/.local/bin/go
  symlink "$HOME"/.local/lib/go/bin/gofmt "$HOME"/.local/bin/gofmt
}

install_go_tools () {
  header "Installing go tools..."

  tools=(
    golang.org/x/tools/gopls
    golang.org/x/tools/cmd/deadcode
    github.com/muesli/duf
    github.com/charmbracelet/glow
    github.com/fatih/gomodifytags
    github.com/cweill/gotests/...
    github.com/natesales/q
  )

  for tool in "${tools[@]}"; do
    go_install "$tool"
  done
}

main () {
  install_go
  symlink_go
  install_go_tools
}

main
