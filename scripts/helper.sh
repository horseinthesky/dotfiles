RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
GREY="\e[90m"
LIGHTRED="\e[91m"
LIGHTGREEN="\e[92m"
LIGHTYELLOW="\e[93m"
LIGHTBLUE="\e[94m"
LIGHTMAGENTA="\e[95m"
LIGHTCYAN="\e[96m"
LIGHTGREY="\e[37m"
WHITE="\e[97m"
NORMAL="\e[0m"

XDG_CONFIG_HOME=$HOME/.config
XDG_DATA_HOME=$HOME/.local/share
XDG_CACHE_HOME=$HOME/.cache

DOTFILES_HOME=$HOME/dotfiles/files

source /etc/os-release

header () {
  echo -e "\n${LIGHTMAGENTA}$1${NORMAL}"
  printf "${LIGHTMAGENTA}%$(($(tput cols) / 3))s${NORMAL}\n" | tr " " "="
}

success () {
  local msg=${1:-Done}
  echo -e "${GREEN}$msg${NORMAL}\n"
}

error () {
  echo -e "${LIGHTRED}$1${NORMAL}\n"
}

warning () {
  echo -e "${YELLOW}$1${NORMAL}"
}

info () {
  echo -e "${GREY}$1${NORMAL}"
}

install () {
  case $ID in
    debian|ubuntu)
      sudo apt-get update -y 1> /dev/null
      sudo apt-get install ${@} -y | grep -E "upgraded"
      ;;
    arch|manjaro)
      sudo pacman -Sy --noconfirm 1> /dev/null
      sudo pacman -S ${@} --noconfirm --needed
      ;;
    *)
      error "Distro $ID is not supported"
      return 1
      ;;
  esac
}

download () {
  local path=$1
  local dest=$2
  local filename=$(echo $path | awk -F/ '{print $NF}')

  [[ ! -d $(dirname $dest) ]] && mkdir -p $(dirname $dest)

  info "Downloading $filename..."

  if [[ -f $dest/$filename ]]; then
    warning "$filename already exists"
    return
  fi

  curl -fsSL $1 -o ${2}/$filename
  if [[ $? -ne 0 ]]; then
    error "Failed to download $filename"
    return 1
  fi

  success "$filename downloaded"
}

symlink () {
  local link=$2
  local file=$1

  info "Symlinking $link for $file"

  if [[ -f $link ]] && [[ ! -L $link ]]; then
    cp $link $link.bak
    info "$link backed up"
  elif [[ -d $link ]] && [[ ! -L $link ]]; then
    cp -R $link $link.bak
    info "$link backed up"
  fi

  local symlink_dir=$(dirname $link)
  [[ ! -d $symlink_dir ]] && mkdir -p $symlink_dir

  ln -snf $file $link
  success
}

clone () {
  local path_prefix=${3:-}
  local tool=$(echo ${1} | cut -d "/" -f 2)

  info "Cloning $tool..."

  if [[ -d ${2}/$path_prefix$tool ]]; then
    warning "$tool already exists. Updating..."
    cd ${2}/$path_prefix$tool && git pull 1> /dev/null
    success

    return
  fi

  git clone -q https://github.com/${1}.git ${2}/$path_prefix$tool
  if [[ $? -ne 0 ]]; then
    error "Failed to clone $tool"
    return 1
  fi

  success "$tool cloned"
}

cargo_install () {
  local tool binary
  IFS=, read -r tool binary <<< ${1}

  info "Installing $tool..."

  if [[ ! -d $HOME/.cargo ]]; then
    error "Cargo is not found. Can't procced"
    return 1
  fi

  PATH=$HOME/.cargo/bin:$PATH

  if [[ -z $binary ]]; then
    binary=$tool
  fi

  # Fresh install
  if [[ -z $(which $binary) ]]; then
    cargo install $tool

    if [[ $? -ne 0 ]]; then
      error "Failed to install $tool"
      return 1
    fi

    success "$tool installed"
    return
  fi

  # Update
  local current_version=$($binary --version 2> /dev/null | grep -P -o "\d+\.\d+\.\d+" | head -n 1)
  local latest_version=$(cargo search $tool | head -n 1 | awk '{print $3}' | tr -d '"')

  if [[ $current_version == $latest_version ]]; then
    success "Latest ($latest_version) version is already installed"
    return
  fi

  info "Newer version ($latest_version) found. Updating..."
  cargo install $tool --force

  if [[ $? -ne 0 ]]; then
    error "Failed to update $tool to the latest ($latest_version) version"
    return 1
  fi

  warning "$tool updated to the latest ($latest_version) version"
}

go_install () {
  local tool=$(echo ${1} | awk -F/ '{print $NF}')

  info "Installing $tool..."

  PATH=$HOME/.local/bin:$PATH

  if [[ -z $(which go) ]]; then
    error "Go is not found. Can't procced"
    return 1
  fi

  if [[ -n $(which $tool) ]]; then
    success "$tool already exists"
    return
  fi

  go install github.com/${1}@latest
  success "$tool installed"
}
