#!/usr/bin/env bash

source scripts/helper.sh
source /etc/os-release

echo -e "\n${LIGHTMAGENTA}Installing docker...${NORMAL}"
case $ID_LIKE in
  debian)
    packages=(
      apt-transport-https
      ca-certificates
      curl
      software-properties-common
    )
    install ${packages[@]} | grep -P "\d\K upgraded"

    echo -e "${GREY}Adding docker gpg key...${NORMAL}"
    if [[ ! -f /usr/share/keyrings/docker-archive-keyring.gpg ]]; then
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg |\
        sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    fi

    echo -e "${GREY}Adding docker gpg key...${NORMAL}"
    if [[ ! -f /etc/apt/sources.list.d/docker.list ]]; then
      echo \
        "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    fi

    echo -e "${GREY}Installing docker-ce...${NORMAL}"
    install docker-ce docker-ce-cli containerd.io | grep -E "upgraded"
    ;;
  arch)
    install docker
    ;;
esac
echo -e "${GREEN}Done${NORMAL}"

echo -e "\n${LIGHTMAGENTA}Adding $USER to docker group...${NORMAL}"
sudo usermod -aG docker $(whoami)
echo -e "${GREEN}Done${NORMAL}"

echo -e "\n${LIGHTMAGENTA}Install docker-compose...${NORMAL}"
if [[ ! -f $HOME/.local/bin/docker-compose ]]; then
  [[ ! -d $HOME/.local/bin ]] && mkdir -p $HOME/.local/bin
  curl -sL "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" \
    -o $HOME/.local/bin/docker-compose
  chmod +x $HOME/.local/bin/docker-compose
  echo -e "${GREEN}Done${NORMAL}"
else
  echo -e "${YELLOW}Already installed${NORMAL}"
fi
