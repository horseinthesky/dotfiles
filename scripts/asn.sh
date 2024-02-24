#!/usr/bin/env bash

source scripts/helper.sh

install_deps () {
  header "Installing asn deps..."

  packages=(
    whois
    mtr-tiny
    ipcalc
    grepcidr
    nmap
    ncat
    aha
  )

  install "${packages[@]}"
}

install_asn () {
  header "Downloading asn..."

  ASN=$HOME/.local/bin/asn

  if [[ -f $ASN ]]; then
    success "Already installed"
    exit
  fi

  curl -s https://raw.githubusercontent.com/nitefood/asn/master/asn > \
    "$ASN" && \
    chmod +x "$ASN"

  success
}

main () {
  install_deps
  install_asn
}

main
