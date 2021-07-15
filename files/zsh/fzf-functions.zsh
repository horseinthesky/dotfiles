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
