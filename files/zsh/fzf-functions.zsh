fw() {
  local projects=$HOME/work

  if [[ ! -d $projects ]]; then
    echo -e "$projects dir does not exist"
    return 1
  fi

  local project=$(fd -t d --max-depth 1 . $projects | sed 's|.*/||' | fzf)

  [[ -z $project ]] && return

  cd $projects/$project
}

fenv () {
  local version=$(ll $HOME/.local/bin | grep python | awk '{print $11}' |
    fzf --delimiter='python' --with-nth=2
  )

  [[ -z $version ]] && return

  virtualenv .venv -p=$version
}

fdrc () {
  local containers=$(docker ps | tail -n +2 | awk '{print $1" "$NF}' | fzf -m | cut -d " " -f 1 | tr "\n" " ")

  [[ -z $containers ]] && return

  docker rm $(echo $containers) -f
}

fdri () {
  local images=$(docker images | tail -n +2 | awk '{print $1" "$3}' | fzf -m |  cut -d " " -f 2 | tr "\n" " ")

  [[ -z $images ]] && return

  docker rmi $(echo $images) -f
}

fpac () {
  pacman -Slq |
    fzf --multi --preview 'pacman -Si {1}' |
    xargs -ro sudo pacman -S
}

fapt () {
  apt list |
    fzf --multi --delimiter="/" --with-nth=1 --preview 'apt-cache policy {1}' |
    awk -F/ '{print $1}' |
    xargs -ro sudo apt-get install
}

c () {
  local languages=(
    python
    go
    lua
  )

  local utils=(
    tar
    xargs
    awk
  )

  local selected=$(printf "$(echo $languages | tr ' ' '\n')\n$(echo $utils | tr ' ' '\n')" | fzf)

  echo -n "query: "
  read query

  if printf $languages | grep -qs $selected; then
    curl cht.sh/$selected/$(echo $query | tr ' ' '+')\?Q
  else
    curl cht.sh/$selected~$query\?Q
  fi
}
