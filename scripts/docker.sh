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
      )
      install ${packages[@]}

      info "Adding docker gpg key..."
      DOCKER_GPG=/usr/share/keyrings/docker.gpg

      if [[ ! -f $DOCKER_GPG ]]; then
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
          sudo gpg --dearmor -o $DOCKER_GPG
      fi

      info  "Adding docker repo..."
      if [[ ! -f /etc/apt/sources.list.d/docker.list ]]; then
        echo \
          "deb [arch="$(dpkg --print-architecture)" signed-by=$DOCKER_GPG] \
            https://download.docker.com/linux/ubuntu \
          "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
          sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
      fi

      info "Installing docker..."
      install \
        docker-ce \
        docker-ce-cli \
        containerd.io
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
  header "Installing docker compose..."

  local version=v2.23.0
  local plugin_dir=$HOME/.docker/cli-plugins

  if [[ -f $plugin_dir/docker-compose ]]; then
    success "Already installed"
    exit
  fi

  download https://github.com/docker/compose/releases/download/${version}/docker-compose-$(uname -s)-$(uname -m)
  [[ $? -ne 0 ]] && exit

  [[ ! -d $plugin_dir ]] && mkdir -p $plugin_dir
  mv $HOME/docker-compose-$(uname -s)-$(uname -m) $plugin_dir/docker-compose
  chmod +x $plugin_dir/docker-compose

  success
}

main () {
  install_docker
  setup_docker_group
  install_docker_compose
}

main
