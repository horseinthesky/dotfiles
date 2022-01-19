fw() {
  cd $HOME/$(fd -t d "netinfra|ni_" --max-depth 1 $HOME | sed 's|.*/||' | fzf)
}

fenv () {
  virtualenv .venv -p=$(ll $HOME/.local/bin | grep python | awk '{print $11}' |
    fzf --delimiter='python' --with-nth=2
  )
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


