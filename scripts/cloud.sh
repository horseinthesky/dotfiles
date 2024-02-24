#!/usr/bin/env bash

source scripts/helper.sh

download_package () {
  local url=$1
  local path=$2
  local package=$(echo "$1" | awk -F/ '{print $NF}')

  download "$url"
  [[ $? -ne  0 ]] && return 1

  info "Extracting archive..."
  unzip -o "$HOME/$package" -d "$path"
  rm "$HOME/$package"

  success
}

terraform_install () {
  local name=$1

  header "Installing $name..."

  local latest_version=$(
    curl -s https://api.github.com/repos/hashicorp/"$name"/releases/latest | \
    grep tag_name | grep -Po "\d+\.\d+\.\d+"
  )
  local package_name=${name}_${latest_version}_linux_amd64.zip

  if [[ -z $(which "$name") ]]; then
    download_package https://releases.hashicorp.com/"$name/$latest_version/$package_name" "$HOME"/.local/bin
    return
  fi

  local current_version=$("$name" -v | head -n 1 | grep -Po "\d+\.\d+\.\d+")

  if [[ $current_version == $latest_version ]]; then
    success "Latest ($latest_version) version is already installed"
    return
  fi

  info "Newer version found. Updating $current_version -> $latest_version..."
  download_package https://releases.hashicorp.com/"$name/$latest_version/$package_name" "$HOME"/.local/bin
  [[ $? -ne  0 ]] && return

  success "Updated to the latest ($latest_version) version"
}

install_terraform_packages () {
  packages=(
    terraform
    terraform-ls
  )

  for tool in "${packages[@]}"; do
    terraform_install "$tool"
  done
}

install_kubelet () {
  header "Installing kubectl..."

  if [[ -n $(which kubectl) ]]; then
    success "kubectl is already installed."
    return
  fi

  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  chmod +x "$HOME"/kubectl
  mv "$HOME"/kubectl "$HOME"/.local/bin/kubectl

  success
}

install_helm () {
  header "Installing helm..."

  if [[ -n $(which helm) ]]; then
    success "helm is already installed."
    return
  fi

  curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | USE_SUDO=false HELM_INSTALL_DIR=~/.local/bin bash

  success
}

main () {
  install_terraform_packages
  install_kubelet
  install_helm
}

main
