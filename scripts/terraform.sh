#!/usr/bin/env bash

source scripts/helper.sh

setup_env () {
  [[ ! -d $HOME/.local/bin ]] && mkdir -p $HOME/.local/bin
  [[ ! $PATH == *$HOME/.local/bin* ]] && export PATH=$HOME/.local/bin:$PATH
}

download_package () {
  local url=$1
  local path=$2
  local package=$(echo $1 | awk -F/ '{print $NF}')

  download $url $HOME
  [[ $? -ne  0 ]] && return 1

  info "Extracting archive..."
  unzip -o $HOME/$package -d $path
  rm $HOME/$package

  success
}

terraform_install () {
  local name=$1

  header "Installing $name..."

  local latest_version=$(
    curl -s https://api.github.com/repos/hashicorp/$name/releases/latest | \
    grep tag_name | grep -Po "\d+\.\d+\.\d+"
  )
  local package_name=${name}_${latest_version}_linux_amd64.zip

  if [[ -z $(which $name) ]]; then
    download_package https://releases.hashicorp.com/$name/${latest_version}/$package_name $HOME/.local/bin
    return
  fi

  local current_version=$($name -v | head -n 1 | grep -Po "\d+\.\d+\.\d+")

  if [[ $current_version == $latest_version ]]; then
    success "Latest ($latest_version) version is already installed"
    return
  fi

  info "Newer version found. Updating $current_version -> $latest_version..."
  download_package https://releases.hashicorp.com/$name/${latest_version}/$package_name $HOME/.local/bin
  [[ $? -ne  0 ]] && return

  success "Updated to the latest ($latest_version) version"
}

install_terraform_packages () {
  packages=(
    terraform
    terraform-ls
  )

  for tool in ${packages[@]}; do
    terraform_install $tool
  done
}

main () {
  setup_env
  install_terraform_packages
}

main
