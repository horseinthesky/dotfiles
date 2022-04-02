  # ____ ___  __  __ ____  _     _____ _____ ___ ___  _   _
#  / ___/ _ \|  \/  |  _ \| |   | ____|_   _|_ _/ _ \| \ | |
# | |  | | | | |\/| | |_) | |   |  _|   | |  | | | | |  \| |
# | |__| |_| | |  | |  __/| |___| |___  | |  | | |_| | |\  |
#  \____\___/|_|  |_|_|   |_____|_____| |_| |___\___/|_| \_|
 #

# +---------+
# | General |
# +---------+

# Load more completions
fpath=(
  $ZDOTDIR/complete
  $XDG_DATA_HOME/zsh/plugins/zsh-completions/src
  $fpath
)

# Allow C-w to delete words separated by | or - or .
WORDCHARS='|-.'

# Complist gives access to menuselect
# Should be called before compinit
zmodload zsh/complist

autoload -U compinit; compinit -d $XDG_DATA_HOME/zsh/.zcompdump

# Show hidden files in completion menu
_comp_options+=(globdots)

# +---------+
# | Options |
# +---------+

# Trigger the completion after a glob * instead of expanding it.
setopt GLOB_COMPLETE

# Automatically highlight first element of completion menu
setopt MENU_COMPLETE

# No need to type cd to cd
setopt AUTO_CD

# The completion menu takes less space
setopt LIST_PACKED

# Automatically list choices on ambiguous completion
setopt AUTO_LIST

# By default, the cursor goes at the end of the word when completion start.
# Setting this will not move the cursor and the completion will happen on both end of the word completed
setopt COMPLETE_IN_WORD

# +---------+
# | Keymaps |
# +---------+

# Use hjlk in menu selection (during completion)
# Doesn't work well with interactive mode
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Clear the screen without leaving the menu selection
bindkey -M menuselect '^xg' clear-screen

# Inveractive mode (filters completion as you type)
bindkey -M menuselect '^xi' vi-insert

# Insert match and keep the completion menu open
bindkey -M menuselect '^xh' accept-and-hold

# Insert the match and, in case of directories, open completion menu to complete its children.
bindkey -M menuselect '^xn' accept-and-infer-next-history

# Undo completion insertion
bindkey -M menuselect '^xu' undo

# +---------+
# | zstyles |
# +---------+

# Ztyle pattern
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# ======== General =======
# Define completers
zstyle ':completion:*' completer _extensions _complete _approximate

# Use cache for commands using cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/.zcompcache

# Highlights menu selection
zstyle ':completion:*' menu select

# Sort by modification date for every completer
zstyle ':completion:*' file-sort modification

# Disable "Display all possibilities?" message
zstyle ':completion:*' list-prompt ''

# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''

# Groups order
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

# Setting the style matcher-list allows you to filter the matches of the completion with even more patterns.
# See ZSHCOMPWID "completion matching control"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# ==== Specifics ====
# Autocomplete options for cd instead of directory stack
zstyle ':completion:*' complete-options true

# Complete the alias when _expand_alias is used as a function
zstyle ':completion:*' complete true

# Expand aliases by pressing Ctrl-x a
zle -C alias-expension complete-word _generic
bindkey '^xa' alias-expension
zstyle ':completion:alias-expension:*' completer _expand_alias

# Host completions for remote connections
zstyle -e ':completion:*:(pssh|ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# Complete zoxide with dirs only
compdef _dirs z

# ==== Colors ====
local meta='%f'  # default foreground
local orange='%F{#fe8019}'
local ivory='%F{#d5c4a1}'
local green='%F{#b8bb26}'
local yellow='%F{#fabd2f}'
local red='%F{#fb4934}'
local blue='%F{#83a598}'
local magenta='%F{#d3869b}'

# Groups format
zstyle ':completion:*:*:*:*:corrections' format "${yellow}  ${ivory}%d${meta}"
zstyle ':completion:*:*:*:*:descriptions' format "${magenta} 硫${ivory}%d${meta}"
zstyle ':completion:*:*:*:*:messages' format "${blue}  ${ivory}%d${meta}"
zstyle ':completion:*:*:*:*:warnings' format "${red}  ${ivory}No Matches Found${meta}"

# Colors for files and directory
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
