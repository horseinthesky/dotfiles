source_file() {
  if [[ -f $ZDOTDIR/$1 ]]; then
    source $ZDOTDIR/$1
  else
    echo -e "\e[93m \e[97mFile $1 does not exist"
  fi
}

add_plugin() {
  if [[ -d $XDG_DATA_HOME/zsh/plugins/$1 ]]; then
    source $XDG_DATA_HOME/zsh/plugins/$1/$1.plugin.zsh
  else
    echo -e "\e[93m \e[97mPlugin $1 does not exist"
  fi
}

load_theme() {
  if [[ -d $XDG_DATA_HOME/zsh/themes/$1 ]]; then
    source $XDG_DATA_HOME/zsh/themes/$1/$1.zsh-theme
  else
    echo -e "\e[93m \e[97mTheme $1 does not exist"
  fi
}
