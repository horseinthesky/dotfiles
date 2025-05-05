# Fuzzy work projects
fw() {
  local projects=$HOME/work

  if [[ ! -d $projects ]]; then
    echo -e "$projects dir does not exist"
    return 1
  fi

  local project=$(fd -t d --max-depth 1 . $projects | awk -F/ '{print $(NF-1)}' | fzf)
  [[ -z $project ]] && return

  cd $projects/$project
}

# Fuzzy python venv
fenv () {
  local version=$(ls -la $HOME/.local/bin | grep python | awk '{print $9}' |
    fzf --delimiter='python' --with-nth=2
  )
  [[ -z $version ]] && return

  virtualenv .venv -p=$version
}

# Fuzzy docker remove containers
fdrc () {
  local containers=$(docker ps -a | tail -n +2 | awk '{print $1" "$2}' | fzf -m | cut -d " " -f 1 | tr "\n" " ")
  [[ -z $containers ]] && return

  docker rm $(echo $containers) -f
}

# Fuzzy docker remove images
fdri () {
  local images=$(docker images | tail -n +2 | awk '{print $1" "$2" "$3}' | column -t | fzf -m | awk '{print $NF}' | tr "\n" " ")
  [[ -z $images ]] && return

  docker rmi $(echo $images) -f
}

# Fuzzy docker logs
fdl () {
  local container=$(docker ps -a | tail -n +2 | awk '{print $1" "$2}' | column -t | fzf | cut -d " " -f 1)
  [[ -z $container ]] && return

  docker logs $container
}

# Fuzzy pacman install
fpac () {
  pacman -Slq |
    fzf --multi --preview 'pacman -Si {1}' |
    xargs -ro sudo pacman -S
}

# Fuzzy apt install
fapt () {
  apt list 2>/dev/null |
    fzf --multi --delimiter="/" --with-nth=1 --preview 'apt-cache policy {1}' |
    awk -F/ '{print $1}' |
    xargs -ro sudo apt-get install
}

# Fuzzy cheat sheet
fcht () {
  local languages=(
    python
    go
    rust
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

# Fuzzy teleport ssh
s () {
  # Pass args to teleport ssh if any
  [[ $# -ne 0 ]] && teleport ssh $@ && return

  local host=$(tsh ls | tail -n +3 | awk '{print $1" "$NF}' | column -t | fzf | cut -d " " -f 1)
  [[ -z $host ]] && return

  tsh ssh $host
}
