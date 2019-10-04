export NVIM_COLORSCHEME=gruvbox

# Shell colorscheme fix
if [[ "$NVIM_COLORSCHEME" == "solarized8" ]]; then
    # solarized8 color fix
    source "$HOME/.local/share/nvim/plugged/vim-solarized8/scripts/solarized8.sh"
else
    # gruvbox colors fix
    source "$HOME/.local/share/nvim/plugged/gruvbox/gruvbox_256palette_osx.sh"
fi

# Add ~/go/bin to PATH
export PATH="/home/$USER/go/bin:$PATH"

# Set system locales
export LC_ALL=C.UTF-8
export LANG=C.UTF-8

export TERM="xterm-256color"
export EDITOR="nvim"
export ZSH_DISABLE_COMPFIX=true

# ssh-agent
eval `ssh-agent`  && ssh-add

# pyenv settings
export PATH="/home/$USER/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# pipenv settings
eval "$(pipenv --completion)"

# poetry settings
source $HOME/.poetry/env

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME=spaceship/spaceship
ZSH_THEME=powerlevel10k/powerlevel10k

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
plugins=(
  git
  zsh-autosuggestions
  sudo
)

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

# lsd aliases
alias ll='lsd -lA --group-dirs first'
alias ls='lsd --group-dirs first'

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'
export FZF_DEFAULT_OPTS="--extended"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

if [[ "$ZSH_THEME" == "powerlevel10k/powerlevel10k" ]]; then
  # ==== Powerlevel9k Settings ====
  # Mode
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
  POWERLEVEL9K_CUSTOM_DETECT_SSH_FOREGROUND="gold1" # 220

  # OS block settings
  POWERLEVEL9K_LINUX_UBUNTU_ICON='\uF30C' # 
  if [ -f /etc/os-release ]; then
      # freedesktop.org and systemd
      . /etc/os-release
      if [[ $ID == 'ubuntu' ]]; then
          POWERLEVEL9K_OS_ICON_BACKGROUND='166' # darkorange3
          POWERLEVEL9K_OS_ICON_FOREGROUND='grey93' # 255
      elif [[ $ID == 'centos' || $ID == 'redhat' ]]; then
          POWERLEVEL9K_OS_ICON_BACKGROUND='160' # red3
          POWERLEVEL9K_OS_ICON_FOREGROUND='000' # black
      fi
  fi

  # User block settings
  POWERLEVEL9K_USER_ICON='\uF415' # 
  # POWERLEVEL9K_ROOT_ICON="\uF198" # 
  POWERLEVEL9K_ROOT_ICON='\uF09C' # 
  POWERLEVEL9K_USER_DEFAULT_BACKGROUND='plum4' # 096
  POWERLEVEL9K_USER_DEFAULT_FOREGROUND='grey93' # 255
  POWERLEVEL9K_USER_ROOT_BACKGROUND='darkred' # 088
  POWERLEVEL9K_USER_ROOT_FOREGROUND='grey93' # 255
  # RED_HAT_ICON='\uF309' # 
  # LINUX_ICON='\uE712' # 

  # Home block settings
  POWERLEVEL9K_HOME_ICON='\uF015' # 
  POWERLEVEL9K_HOME_SUB_ICON='\uF07C' # 
  POWERLEVEL9K_FOLDER_ICON='\uF115' # 

  # Dir block settings
  POWERLEVEL9K_DIR_PATH_SEPARATOR="%F{237} $(print_icon 'LEFT_SUBSEGMENT_SEPARATOR') %F{237}"
  # POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\UE0BC'
  # POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='\UE0BA'
  # POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\uE0B4'
  # POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='\uE0B6'
  # POWERLEVEL9K_SHORTEN_STRATEGY="truncate_beginning"
  # POWERLEVEL9K_SHORTEN_DELIMITER='..'
  POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
  POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='dodgerblue1'
  POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='grey23' # 237
  POWERLEVEL9K_DIR_HOME_BACKGROUND='dodgerblue1'
  POWERLEVEL9K_DIR_HOME_FOREGROUND='grey23' # 237
  POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='dodgerblue1'
  POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='grey23' # 237
  POWERLEVEL9K_DIR_ETC_BACKGROUND='indianred'
  POWERLEVEL9K_DIR_ETC_FOREGROUND='grey23' # 237

  # Dir Writable settings
  # POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
  POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND='red3' # 160
  POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND='yellow1' # 226

  # VCS settings
  POWERLEVEL9K_VCS_BRANCH_ICON='\uF126 '
  POWERLEVEL9K_VCS_GIT_GITHUB_ICON='\uF408 ' # 
  # POWERLEVEL9K_VCS_GIT_GITHUB_ICON='\uF113 ' # 
  POWERLEVEL9K_VCS_GIT_GITLAB_ICON='\uF296 ' # 
  POWERLEVEL9K_VCS_GIT_BITBUCKET_ICON='\uF171 ' # 
  POWERLEVEL9K_VCS_STAGED_ICON='\uF055' # 
  # POWERLEVEL9K_VCS_STAGED_ICON='\u271A' # ✚
  POWERLEVEL9K_VCS_UNTRACKED_ICON='\uF00D' # 
  POWERLEVEL9K_VCS_UNSTAGED_ICON='\uF421' # 
  # POWERLEVEL9K_VCS_UNSTAGED_ICON='\u00b1' # ±
  POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='\uF0AB' # 
  # POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='\u2193' #↓
  POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='\uF0AA' # 
  # POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='\u2191' # ↑
  POWERLEVEL9K_VCS_COMMIT_ICON='\uf417'
  POWERLEVEL9K_VCS_CLEAN_FOREGROUND='grey23' # 237
  POWERLEVEL9K_VCS_CLEAN_BACKGROUND='chartreuse3' # 076
  POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='grey23' # 237
  POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='red1' # 196
  POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='grey23' # 237
  POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow1' # 226

  # Virtualenv block settings
  POWERLEVEL9K_VIRTUALENV_FOREGROUND='dodgerblue3' # 004
  POWERLEVEL9K_VIRTUALENV_BACKGROUND='gold1' # 220
  POWERLEVEL9K_PYTHON_ICON='\uE606'

  # Pyenv block settings
  POWERLEVEL9K_PYENV_FOREGROUND='dodgerblue3' # 004
  POWERLEVEL9K_PYENV_BACKGROUND='gold1' # 220
  # POWERLEVEL9K_PYENV_PROMPT_ALWAYS_SHOW=true

  # Time block settings
  POWERLEVEL9K_TIME_FORMAT="%D{\uf017 %H:%M \uf073 %d.%m.%y}"

  # Prompt settings
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon custom_detect_ssh user dir_writable dir virtualenv pyenv)
  POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs)
  POWERLEVEL9K_PROMPT_ON_NEWLINE=true
  # POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
  # POWERLEVEL9K_DISABLE_RPROMPT=true
  POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{$POWERLEVEL9K_OS_ICON_BACKGROUND}\u256D\u2500"
  POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{$POWERLEVEL9K_OS_ICON_BACKGROUND}\u2570\uf460%F{default} "
  # POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{249}\u250f"
  # POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{249}\u2517%F{default} "
fi
