#" gruvbox colors fix
source "$HOME/.config/nvim/plugged/gruvbox/gruvbox_256palette_osx.sh"

export TERM="xterm-256color"
export EDITOR="nvim"

export WORKON_HOME=~/venv
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/local/bin/virtualenvwrapper.sh

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
plugins=(git zsh-autosuggestions)

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

# ==== Powerleve9k Settings ====
# Detect SSH connection
zsh_detect_ssh(){
    local color='%F{yellow_bold}'
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        echo -n "%{$color%}\uF489 $HOST"
    fi
}

# Fonts
POWERLEVEL9K_MODE='nerdfont-complete'

# Custom ssh settings
POWERLEVEL9K_CUSTOM_DETECT_SSH="zsh_detect_ssh"
POWERLEVEL9K_CUSTOM_DETECT_SSH_BACKGROUND="066"
POWERLEVEL9K_CUSTOM_DETECT_SSH_FOREGROUND="179"

# Environment settings
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_detect_ssh virtualenv user dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs)

# Host block settings
POWERLEVEL9K_HOST_ICON="\uF109"
POWERLEVEL9K_SSH_ICON="\uF489"

# User block settings
POWERLEVEL9K_USER_ICON="\uF415" # 
POWERLEVEL9K_ROOT_ICON="\uF198" # 
POWERLEVEL9K_USER_DEFAULT_BACKGROUND='096'
POWERLEVEL9K_USER_DEFAULT_FOREGROUND='007'
POWERLEVEL9K_USER_ROOT_BACKGROUND='052'
POWERLEVEL9K_USER_ROOT_FOREGROUND='white'

# Home block settings
POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON=''

# Dir block settings
POWERLEVEL9K_DIR_PATH_SEPARATOR="%F{black} $(print_icon 'LEFT_SUBSEGMENT_SEPARATOR') %F{black}"
POWERLEVEL9K_DIR_SHOW_WRITABLE="true"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='033'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='000'
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_DELIMITER=".."

# Virtualenv block settings
POWERLEVEL9K_VIRTUALENV_BACKGROUND='012'
POWERLEVEL9K_VIRTUALENV_FOREGROUND='027'
POWERLEVEL9K_PYTHON_ICON="\uE606"
