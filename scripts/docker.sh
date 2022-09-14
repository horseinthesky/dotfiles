#!/usr/bin/env bash

source scripts/helper.sh

install_docker () {
  header "Installing docker..."

  case $ID in
    debian|ubuntu)
      packages=(
        ca-certificates
        curl
        gnupg
        lsb-release
      )
      install ${packages[@]}

      info "Adding docker gpg key..."
      if [[ ! -f /usr/share/keyrings/docker-archive-keyring.gpg ]]; then
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg |\
          sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
      fi

      info  "Adding docker repo..."
      if [[ ! -f /etc/apt/sources.list.d/docker.list ]]; then
        echo \
          "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
          $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
      fi

      info "Installing docker packages..."
      install \
        docker-ce \
        docker-ce-cli \
        containerd.io \
        docker-compose-plugin
      ;;
    arch|manjaro)
      install docker
      ;;
    *)
      error "Distro is not supported. Abort"
      exit
      ;;
  esac

  success
}

setup_docker_group () {
  header "Adding $USER to docker group..."
  sudo usermod -aG docker $(whoami)
  success
}

install_docker_compose () {
  header "Install docker-compose..."

  if [[ -f $HOME/.local/bin/docker-compose ]]; then
    success "Already installed"
    exit
  fi

  local version=1.29.2

  [[ ! -d $HOME/.local/bin ]] && mkdir -p $HOME/.local/bin
  curl -sL "https://github.com/docker/compose/releases/download/${version}/docker-compose-$(uname -s)-$(uname -m)" \
    -o $HOME/.local/bin/docker-compose
  chmod +x $HOME/.local/bin/docker-compose

  success
}

main () {
  install_docker
  setup_docker_group
  # install_docker_compose
}

main
