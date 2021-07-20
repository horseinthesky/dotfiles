  # ____ ___  __  __ ____  _     _____ _____ ___ ___  _   _
#  / ___/ _ \|  \/  |  _ \| |   | ____|_   _|_ _/ _ \| \ | |
# | |  | | | | |\/| | |_) | |   |  _|   | |  | | | | |  \| |
# | |__| |_| | |  | |  __/| |___| |___  | |  | | |_| | |\  |
#  \____\___/|_|  |_|_|   |_____|_____| |_| |___\___/|_| \_|
 #

# +---------+
# | General |
# +---------+

# zstyle pattern for the completion
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# Complist gives access to menuselect
# Should be called before compinit
zmodload zsh/complist

# Use hjlk in menu selection (during completion)
# Doesn't work well with interactive mode
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

bindkey -M menuselect '^xg' clear-screen
bindkey -M menuselect '^xi' vi-insert                      # Insert
bindkey -M menuselect '^xh' accept-and-hold                # Hold
bindkey -M menuselect '^xn' accept-and-infer-next-history  # Next
bindkey -M menuselect '^xu' undo                           # Undo

autoload -U compinit; compinit

# Show hidden files in completion menu
_comp_options+=(globdots)

# +---------+
# | Options |
# +---------+

setopt GLOB_COMPLETE        # Show autocompletion menu with globs
setopt AUTO_CD              # No need to type cd to cd
setopt LIST_PACKED          # More compact completion menu
setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.

# +---------+
# | zstyles |
# +---------+

# Ztyle pattern
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# Define completers
zstyle ':completion:*' completer _extensions _complete _approximate

# Comletion menu on <TAB> for every completer
zstyle ':completion:*' menu select

# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''

# Groups order
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

# See ZSHCOMPWID "completion matching control"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Host completions for remote connections
zstyle -e ':completion:*:(pssh|ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# Sort by modification date for every completer
zstyle ':completion:*' file-sort modification

# Use cache for commands using cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/.zcompcache

# Autocomplete options for cd instead of directory stack
zstyle ':completion:*' complete-options true

# Complete zoxide with dirs only
compdef _dirs z

# Complete the alias when _expand_alias is used as a function
zstyle ':completion:*' complete true

# Expand aliases by pressing Ctrl-x a
zle -C alias-expension complete-word _generic
bindkey '^xa' alias-expension
zstyle ':completion:alias-expension:*' completer _expand_alias

# Groups format
zstyle ':completion:*:*:*:*:corrections' format $'\e[93m \e[97m %d%f'
zstyle ':completion:*:*:*:*:descriptions' format $'\e[95m 硫\e[97m%d%f'
zstyle ':completion:*:*:*:*:messages' format $'\e[94m \e[97m%d%f'
zstyle ':completion:*:*:*:*:warnings' format $'\e[91m  \e[97mNo Matches Found%f'

# Colors for files and directory
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}
