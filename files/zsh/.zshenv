# XDG Base Directory Specification
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache

# Zsh config dir
export ZDOTDIR=$XDG_CONFIG_HOME/zsh

# Editor vars
# export TERM="xterm-256color"
export EDITOR=nvim
export EDITOR_NIGHTLY=$HOME/.local/bin/nvim

# Set system locales
# export LC_ALL=C.UTF-8
# export LANG=C.UTF-8

# Python cache dir
export PYTHONPYCACHEPREFIX=$HOME/.cache/cpython/
