#!/usr/bin/env bash

source scripts/helper.sh

tools=(
  mattn/efm-langserver
  muesli/duf
)

for tool in ${tools[@]}; do
  go_get $tool
done
