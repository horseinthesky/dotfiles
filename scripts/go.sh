#!/usr/bin/env bash

source scripts/helper.sh

go_install () {
  local path=$1
  local tool=$(echo "$path" | awk -F/ '{print $(NF-1)"/"$NF}')

  if [[ -z $(command -v go) ]]; then
    error "Go is not found. Can't procced"
    return 1
  fi

  info "Installing $tool..."
  go install "$path"@latest
  success "$tool installed"
}

install_go () {
  header "Installing go..."

  local architecture=$(uname -m)

  case "$architecture" in
    x86_64)
      arch=amd64
      ;;
    aarch64)
      arch=arm64
      ;;
    *)
      error "Unsupported architecture. Can't proceed"
      exit
      ;;
  esac

  local version=1.24.2
  local tarball=go${version}.linux-$arch.tar.gz

  if [[ -n $(command -v go) ]] && [[ $(go version | awk '{print $3}' | cut -c3-) == $version ]]; then
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

  local tools=(
    golang.org/x/tools/gopls
    google.golang.org/protobuf/cmd/protoc-gen-go
    google.golang.org/grpc/cmd/protoc-gen-go-grpc
    golang.org/x/tools/cmd/deadcode
    github.com/mfridman/tparse
    github.com/bufbuild/buf/cmd/buf
    github.com/fatih/gomodifytags
    github.com/natesales/q
    github.com/muesli/duf
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
