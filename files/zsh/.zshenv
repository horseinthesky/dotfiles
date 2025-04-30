# XDG Base Directory Specification
# https://specifications.freedesktop.org/basedir-spec/latest/
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# ZSH config dir
export ZDOTDIR=$XDG_CONFIG_HOME/zsh

# Editor vars
export TERM="xterm-256color"
export EDITOR=$HOME/.local/bin/nvim

# Python cache dir
export PYTHONPYCACHEPREFIX=$XDG_CACHE_HOME/cpython/
