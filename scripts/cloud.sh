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
  header "Installing $name..."

  local name=$1
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

  if [[ $current_version == "$latest_version" ]]; then
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

install_kubectl () {
  header "Installing kubectl..."

  if [[ -n $(which kubectl) ]]; then
    success "kubectl is already installed."
    return
  fi

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

  curl -L "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/$arch/kubectl" -o "$HOME"/.local/bin/kubectl
  chmod +x "$HOME"/.local/bin/kubectl

  success
}

install_kubelogin () {
  header "Installing kubelogin..."

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

  local latest_version=$(
    curl -s https://api.github.com/repos/Azure/kubelogin/releases/latest \ |
      grep tag_name | grep -Po "v\d+\.\d+\.\d+"
  )
  local package=kubelogin-linux-"$arch".zip

  # Fresh install
  if [[ -z $(which kubectl-oidc_login) ]]; then
    download https://github.com/Azure/kubelogin/releases/download/"$latest_version"/"$package" /tmp
    [[ $? -ne  0 ]] && return

    unzip -o /tmp/"$package" -d /tmp/kubelogin
    mv /tmp/kubelogin/bin/linux_"$arch"/kubelogin "$HOME"/.local/bin/kubectl-oidc_login
    rm /tmp/"$package" && rm -rf /tmp/kubelogin
    success "kubelogin installed"
    return
  fi

  # Update
  local current_version=$(kubectl-oidc_login --version | grep -Po "v\d+\.\d+\.\d+")
  if [[ "$current_version" == "$latest_version" ]]; then
    success "Latest ($latest_version) version is already installed"
    return
  fi

  info "Newer version found. Updating $current_version -> $latest_version..."

  download https://github.com/Azure/kubelogin/releases/download/"$latest_version"/"$package" /tmp
  [[ $? -ne  0 ]] && return

  unzip -o /tmp/"$package" -d /tmp/kubelogin
  mv /tmp/kubelogin/bin/linux_"$arch"/kubelogin "$HOME"/.local/bin/kubectl-oidc_login
  rm /tmp/"$package" && rm -rf /tmp/kubelogin

  warning "kubelogin updated to the latest ($latest_version) version\n"
}

install_kubectx () {
  header "Installing kubectx..."

  local architecture=$(uname -m)

  case "$architecture" in
    x86_64)
      arch=x86_64
      ;;
    aarch64)
      arch=arm64
      ;;
    *)
      error "Unsupported architecture. Can't proceed"
      exit
      ;;
  esac

  local latest_version=$(
    curl -s https://api.github.com/repos/ahmetb/kubectx/releases/latest \ |
      grep tag_name | grep -Po "\d+\.\d+\.\d+"
  )
  local package=kubectx_v"$latest_version"_linux_"$arch".tar.gz

  # Fresh install
  if [[ -z $(which kubectx) ]]; then
    download https://github.com/ahmetb/kubectx/releases/download/v"$latest_version"/"$package" /tmp
    [[ $? -ne  0 ]] && return

    mkdir -p /tmp/kubectx
    tar -xzf /tmp/"$package" --directory=/tmp/kubectx
    mv /tmp/kubectx/kubectx "$HOME"/.local/bin
    rm /tmp/"$package" && rm -rf /tmp/kubelogin

    success "kubectx installed"
    return
  fi

  # Update
  local current_version=$(kubectx --version)
  if [[ "$current_version" == "$latest_version" ]]; then
    success "Latest ($latest_version) version is already installed"
    return
  fi

  info "Newer version found. Updating $current_version -> $latest_version..."

  download https://github.com/ahmetb/kubectx/releases/download/v"$latest_version"/"$package" /tmp
  [[ $? -ne  0 ]] && return

  mkdir -p /tmp/kubectx
  tar -xzf /tmp/"$package" --directory=/tmp/kubectx
  mv /tmp/kubectx/kubectx "$HOME"/.local/bin
  rm /tmp/"$package" && rm -rf /tmp/kubelogin

  warning "kubectx updated to the latest ($latest_version) version\n"
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
  install_kubectl
  install_kubelogin
  install_kubectx
  install_helm
}

main
