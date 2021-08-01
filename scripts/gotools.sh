#!/usr/bin/env bash

source scripts/helper.sh

tools=(
  mattn/efm-langserver
  muesli/duf
  charmbracelet/glow
)

for tool in ${tools[@]}; do
  go_get $tool
done

echo -e "\n${LIGHTMAGENTA}Installing gopls...${NORMAL}"
GO111MODULE=on go get golang.org/x/tools/gopls@latest
echo -e "${GREEN}Done${NORMAL}"
