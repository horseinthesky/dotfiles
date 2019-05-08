# gruvbox colors fix
source "$HOME/.config/nvim/plugged/gruvbox/gruvbox_256palette_osx.sh"

export TERM="xterm-256color"
export EDITOR="nvim"
export ZSH_DISABLE_COMPFIX="true"

# pyenv settings
export PATH="/home/$USER/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# poetry settings
source $HOME/.poetry/env

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/horseinthesky/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions colorize)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias vi=$(which nvim)
alias suroot='sudo -E -s'

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'
export FZF_DEFAULT_OPTS="--extended"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# ==== Powerlevel9k Settings ====
# Fonts
POWERLEVEL9K_MODE='nerdfont-complete'

# Host block settings
POWERLEVEL9K_HOST_ICON='\uF109' # 
POWERLEVEL9K_SSH_ICON='\uF489' # 

# Detect SSH connection
zsh_detect_ssh(){
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        echo -n "\uF489 $HOST"
    else
        echo -n "$(print_icon 'HOST_ICON') $HOST"
    fi
}

# Custom ssh settings
POWERLEVEL9K_CUSTOM_DETECT_SSH="zsh_detect_ssh"
POWERLEVEL9K_CUSTOM_DETECT_SSH_BACKGROUND="paleturquoise4" # 066
POWERLEVEL9K_CUSTOM_DETECT_SSH_FOREGROUND="olive" # 011

# OS block settings
OS_ICON='\uF30C' # 
POWERLEVEL9K_OS_ICON_BACKGROUND='darkorange' # 208
POWERLEVEL9K_OS_ICON_FOREGROUND='white' # 007
POWERLEVEL9K_LINUX_UBUNTU_ICON='\UF30C' # 

# User block settings
# RED_HAT_ICON=""
POWERLEVEL9K_USER_ICON='\uF415' # 
# POWERLEVEL9K_ROOT_ICON="\uF198" # 
POWERLEVEL9K_ROOT_ICON='\uF09C' # 
POWERLEVEL9K_USER_DEFAULT_BACKGROUND='plum4' # 096
POWERLEVEL9K_USER_DEFAULT_FOREGROUND='white' # 007
POWERLEVEL9K_USER_ROOT_BACKGROUND='darkred' # 088
POWERLEVEL9K_USER_ROOT_FOREGROUND='white' # 007

# Home block settings
# POWERLEVEL9K_HOME_ICON='\uE12C'
# POWERLEVEL9K_HOME_SUB_ICON='\UE18D '
# POWERLEVEL9K_FOLDER_ICON='\uE818 '

# Dir block settings
POWERLEVEL9K_DIR_PATH_SEPARATOR="%F{black} $(print_icon 'LEFT_SUBSEGMENT_SEPARATOR') %F{black}"
# POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\UE0BC'
# POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='\UE0BA'
# POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\uE0B4'
# POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='\uE0B6'
# POWERLEVEL9K_DIR_SHOW_WRITABLE=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_DELIMITER=".."
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='dodgerblue1' # 033
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='black' # 000

# VCS settings
POWERLEVEL9K_VCS_BRANCH_ICON='\uF126 '
POWERLEVEL9K_VCS_GIT_GITHUB_ICON='\uF408 '
POWERLEVEL9K_VCS_STAGED_ICON='\u00b1'
POWERLEVEL9K_VCS_UNTRACKED_ICON='\u25CF'
POWERLEVEL9K_VCS_UNSTAGED_ICON='\u00b1'
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='\u2193'
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='\u2191'
POWERLEVEL9K_VCS_COMMIT_ICON='\uf417'

# Virtualenv block settings
POWERLEVEL9K_VIRTUALENV_FOREGROUND='blue' # 004
POWERLEVEL9K_VIRTUALENV_BACKGROUND='gold1' # 220
POWERLEVEL9K_PYTHON_ICON='\uE606'

# Pyenv block settings
POWERLEVEL9K_PYENV_FOREGROUND='blue' # 004
POWERLEVEL9K_PYENV_BACKGROUND='gold1' # 220
# POWERLEVEL9K_PYENV_PROMPT_ALWAYS_SHOW=true

# Time block settings
POWERLEVEL9K_TIME_FORMAT="%D{\uf017 %H:%M \uf073 %d.%m.%y}"

# Environment settings
# POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon custom_detect_ssh user dir_writable dir virtualenv pyenv)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{208}\u256D\u2500"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{208}\u2570\uf460%F{default} "
# POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{249}\u250f"
# POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{249}\u2517%F{default} "
