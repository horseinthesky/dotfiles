#!/usr/bin/env bash

source scripts/helper.sh

echo -e "\n${LIGHTMAGENTA}Installing poetry...${NORMAL}"
if [[ ! -d $HOME/.local/share/pypoetry ]]; then
  [[ ! $PATH == *$HOME/.python/bin* ]] && export PATH=$HOME/.python/bin:$PATH
  curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python - 1> /dev/null
  echo -e "${GREEN}Done${NORMAL}"
else
  echo -e "${YELLOW}Already installed${NORMAL}"
fi
