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

  local package_name=${name}_${latest_version}_linux_${arch}.zip

  if [[ -z $(command -v "$name") ]]; then
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

  if [[ -n $(command -v kubectl) ]]; then
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

install_k9s () {
  header "Installing k9s..."

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
    curl -s https://api.github.com/repos/derailed/k9s/releases/latest \ |
      grep tag_name | grep -Po "v\d+\.\d+\.\d+"
  )
  local package=k9s_Linux_"$arch".tar.gz

  # Fresh install
  if [[ -z $(command -v k9s) ]]; then
    download https://github.com/derailed/k9s/releases/download/"$latest_version"/"$package" /tmp
    [[ $? -ne  0 ]] && return

    mkdir -p /tmp/k9s
    tar -xzf /tmp/"$package" --directory=/tmp/k9s
    mv /tmp/k9s/k9s "$HOME"/.local/bin/k9s
    rm /tmp/"$package" && rm -rf /tmp/k9s

    success "k9s installed"
    return
  fi

  # Update
  local current_version=$(k9s version | grep -Po "v\d+\.\d+\.\d+")
  if [[ "$current_version" == "$latest_version" ]]; then
    success "Latest ($latest_version) version is already installed"
    return
  fi

  info "Newer version found. Updating $current_version -> $latest_version..."

  download https://github.com/derailed/k9s/releases/download/"$latest_version"/"$package" /tmp
  [[ $? -ne  0 ]] && return

  mkdir -p /tmp/k9s
  tar -xzf /tmp/"$package" --directory=/tmp/k9s
  mv /tmp/k9s/k9s "$HOME"/.local/bin/k9s
  rm /tmp/"$package" && rm -rf /tmp/k9s

  warning "k9s updated to the latest ($latest_version) version\n"
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
    curl -s https://api.github.com/repos/int128/kubelogin/releases/latest \ |
      grep tag_name | grep -Po "v\d+\.\d+\.\d+"
  )
  local package=kubelogin_linux_"$arch".zip

  # Fresh install
  if [[ -z $(command -v kubectl-oidc_login) ]]; then
    download https://github.com/int128/kubelogin/releases/download/"$latest_version"/"$package" /tmp
    [[ $? -ne  0 ]] && return

    unzip -o /tmp/"$package" -d /tmp/kubelogin
    mv /tmp/kubelogin/kubelogin "$HOME"/.local/bin/kubectl-oidc_login
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

  download https://github.com/int128/kubelogin/releases/download/"$latest_version"/"$package" /tmp
  [[ $? -ne  0 ]] && return

  unzip -o /tmp/"$package" -d /tmp/kubelogin
  mv /tmp/kubelogin/kubelogin "$HOME"/.local/bin/kubectl-oidc_login
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

  local tools=(
    kubectx
    kubens
  )

  for tool in "${tools[@]}"; do
    header "Installing $tool..."

    local package="$tool"_v"$latest_version"_linux_"$arch".tar.gz

    # Fresh install
    if [[ -z $(command -v "$tool") ]]; then
      download https://github.com/ahmetb/kubectx/releases/download/v"$latest_version"/"$package" /tmp
      [[ $? -ne  0 ]] && continue

      mkdir -p /tmp/kube
      tar -xzf /tmp/"$package" --directory=/tmp/kube
      mv /tmp/kube/"$tool" "$HOME"/.local/bin
      rm /tmp/"$package" && rm -rf /tmp/kube

      success "$tool installed"
      continue
    fi

    # Update
    local current_version=$("$tool" --version)
    if [[ "$current_version" == "$latest_version" ]]; then
      success "Latest ($latest_version) version is already installed"
      continue
    fi

    info "Newer version found. Updating $current_version -> $latest_version..."

    download https://github.com/ahmetb/kubectx/releases/download/v"$latest_version"/"$package" /tmp
    [[ $? -ne  0 ]] && continue

    mkdir -p /tmp/kube
    tar -xzf /tmp/"$package" --directory=/tmp/kube
    mv /tmp/kube/"$tool" "$HOME"/.local/bin
    rm /tmp/"$package" && rm -rf /tmp/kube

    warning "$tool updated to the latest ($latest_version) version\n"
  done
}

install_helm () {
  header "Installing helm..."

  if [[ -n $(command -v helm) ]]; then
    success "helm is already installed."
    return
  fi

  curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | USE_SUDO=false HELM_INSTALL_DIR=~/.local/bin bash
  helm plugin install https://github.com/databus23/helm-diff

  success
}

install_helmfile () {
  header "Installing helmfile..."

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
    curl -s https://api.github.com/repos/helmfile/helmfile/releases/latest \ |
      grep tag_name | grep -Po "\d+\.\d+\.\d+"
  )

  local package=helmfile_"$latest_version"_linux_"$arch".tar.gz

  # Fresh install
  if [[ -z $(command -v helmfile) ]]; then
    download https://github.com/helmfile/helmfile/releases/download/v"$latest_version"/"$package" /tmp
    [[ $? -ne  0 ]] && return

    mkdir -p /tmp/helmfile
    tar -xzf /tmp/"$package" --directory=/tmp/helmfile
    mv /tmp/helmfile/helmfile "$HOME"/.local/bin
    rm /tmp/"$package" && rm -rf /tmp/helmfile

    success "helmfile installed"
    return
  fi

  # Update
  local current_version=$(helmfile --version | grep -Po "\d+\.\d+\.\d+")
  if [[ "$current_version" == "$latest_version" ]]; then
    success "Latest ($latest_version) version is already installed"
    return
  fi

  info "Newer version found. Updating $current_version -> $latest_version..."

  download https://github.com/helmfile/helmfile/releases/download/v"$latest_version"/"$package" /tmp
  [[ $? -ne  0 ]] && return

  mkdir -p /tmp/helmfile
  tar -xzf /tmp/"$package" --directory=/tmp/helmfile
  mv /tmp/helmfile/helmfile "$HOME"/.local/bin
  rm /tmp/"$package" && rm -rf /tmp/helmfile

  warning "helmfile updated to the latest ($latest_version) version\n"
}

main () {
  install_terraform_packages
  install_kubectl
  install_k9s
  install_kubelogin
  install_kubectx
  install_helm
  install_helmfile
}

main
