#!/usr/bin/env bash

source scripts/helper.sh

install_deps () {
  header "Installing asn deps..."

  packages=(
    whois
    ipcalc
    mtr
  )

  install ${packages[@]}
}

install_asn () {
  header "Downloading asn..."

  [[ ! -d $HOME/.local/bin ]] && mkdir -p $HOME/.local/bin

  ASN_PATH=$HOME/.local/bin/asn

  if [[ -f $ASN_PATH ]]; then
    success "Already installed"
    exit
  fi

  curl -s https://raw.githubusercontent.com/nitefood/asn/master/asn > \
    $ASN_PATH && \
    chmod +x $ASN_PATH

  success
}

main () {
  install_deps
  install_asn
}

main
