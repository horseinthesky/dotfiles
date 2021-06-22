#!/usr/bin/env bash

source scripts/helper.sh

WINDOWS_STARTUP_DIR=/mnt/c/Users/$USER/AppData/Roaming/Microsoft/Windows/Start\ Menu/Programs/Startup

echo -e "\n${LIGHTMAGENTA}Copying autohotkey.ahk to Windows Startup dir${NORMAL}"
if [[ ! -z $WSLENV ]]; then

  if [[ -f ${WINDOWS_STARTUP_DIR}/autohotkey.ahk ]]; then
    echo -e "${YELLOW}Already exists. Updating${NORMAL}"
  fi

  cp files/autohotkey.ahk "$WINDOWS_STARTUP_DIR"/
  echo -e "${GREEN}Done${NORMAL}"
else
  echo -e "${YELLOW}Abort. Not a WSL environment${NORMAL}"
fi
