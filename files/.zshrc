export NVIM_COLORSCHEME=gruvbox

# Shell colorscheme fix
if [[ "$NVIM_COLORSCHEME" == "solarized8" ]]; then
  # solarized8 color fix
  source "$HOME/.local/share/nvim/plugged/vim-solarized8/scripts/solarized8.sh"
else
  # gruvbox colors fix
  source "$HOME/.local/share/nvim/plugged/gruvbox/gruvbox_256palette_osx.sh"
fi

# Disable tmupx autotitle
export DISABLE_AUTO_TITLE="true"

# Add ~/go/bin to PATH
export GOPATH="/home/$USER/go"
if [[ -d "$GOPATH" ]]; then
  export PATH="$PATH:$GOPATH/bin"
fi

# Add /snap/bin to path
export SNAPPATH="/snap/bin"
if [[ -d "$SNAPPATH" ]]; then
  export PATH="$PATH:$SNAPPATH"
fi

# Set system locales
export LC_ALL=C.UTF-8
export LANG=C.UTF-8

export TERM="xterm-256color"
export EDITOR="nvim"
export ZSH_DISABLE_COMPFIX=true

# ssh-agent
[[ $(cat /etc/hostname) == 'horseinthesky-w' ]] && eval `ssh-agent` && ssh-add

# pyenv settings
if [[ -d "$HOME/.pyenv" ]]; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  # eval "$(pyenv virtualenv-init -)"
fi

# pipenv settings
eval "$(pipenv --completion)"

# poetry settings
if [[ -d "$HOME/.poetry" ]]; then
  source $HOME/.poetry/env
fi

# fzf
if [[ -f "$HOME/.fzf.zsh" ]]; then
  [[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
  export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'
  export FZF_DEFAULT_OPTS="--extended"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

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
  forgit
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

# Vi Mode
# bindkey -v
export KEYTIMEOUT=1

# ======== ALIASES ========
alias vi=$(which nvim)
alias suroot='sudo -E -s'

# lsd aliases
alias ll='lsd -lA --group-dirs first'
alias ls='lsd --group-dirs first'

# tmux aliases
alias tn='tmux new -s '
alias ta='tmux a -t '
alias tk='tmux kill-session -t '
alias tl='tmux ls'
alias tpl='tmuxp load '

# ==== Powerlevel10k Settings ====
if [[ "$ZSH_THEME" == "powerlevel10k/powerlevel10k" ]]; then
  # Mode
  POWERLEVEL9K_MODE='nerdfont-complete'

  # Prompt settings
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    custom_host
    custom_user
    dir_writable
    dir
    virtualenv
    pyenv
    newline
    prompt_char
  )
  POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs battery)
  # POWERLEVEL9K_PROMPT_ON_NEWLINE=true
  # POWERLEVEL9K_DISABLE_RPROMPT=true
  POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{249}\u250f"
  POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{249}\u2517%F{default}"

  # Hot reload allows you to change POWERLEVEL9K options after Powerlevel10k has been initialized.
  # For example, you can type POWERLEVEL9K_BACKGROUND=red and see your prompt turn red. Hot reload
  # can slow down prompt by 1-2 milliseconds, so it's better to keep it turned off unless you
  # really need it.
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=false

  # Host block settings
  # POWERLEVEL9K_LINUX_ICON='\uE712' #  
  # POWERLEVEL9K_LINUX_REDHAT_ICON='\uF309' #  
  # POWERLEVEL9K_LINUX_UBUNTU_ICON='\uF31B' #  
  custom_host(){
    if [[ -n "$WSL_DISTRO_NAME" ]]; then
      OS_ICON="\uF17A"
    else
      source /etc/os-release
      case $ID in
        "ubuntu")
          OS_ICON="\uF31B"
          ;;
        "centos")
          OS_ICON="\uF309"
          ;;
      esac
    fi
    echo -n "$OS_ICON $HOST"
  }

  POWERLEVEL9K_CUSTOM_HOST="custom_host"
  if [[ -n "$WSL_DISTRO_NAME" ]]; then
    POWERLEVEL9K_CUSTOM_HOST_BACKGROUND=230
    POWERLEVEL9K_CUSTOM_HOST_FOREGROUND=039
  else
    source /etc/os-release
    case $ID in
      "ubuntu")
        POWERLEVEL9K_CUSTOM_HOST_BACKGROUND=166
        POWERLEVEL9K_CUSTOM_HOST_FOREGROUND=229
        ;;
      "centos")
        POWERLEVEL9K_CUSTOM_HOST_BACKGROUND=160
        POWERLEVEL9K_CUSTOM_HOST_FOREGROUND=000
        ;;
    esac
  fi

  # User block settings
  POWERLEVEL9K_USER_ICON='\uF415' #  
  POWERLEVEL9K_ROOT_ICON='\uF198' #  
  # POWERLEVEL9K_ROOT_ICON='\uF09C' #  
  # POWERLEVEL9K_USER_DEFAULT_BACKGROUND=096 # plum4
  # POWERLEVEL9K_USER_DEFAULT_FOREGROUND=229 # wheat1
  # POWERLEVEL9K_USER_ROOT_BACKGROUND=88 # darkred
  # POWERLEVEL9K_USER_ROOT_FOREGROUND=229 #wheat1

  POWERLEVEL9K_HOST_ICON='\uF109' #  
  POWERLEVEL9K_SSH_ICON='\uF489' #  
  DEFAULT_GREY=237 # grey23

  zsh_detect_ssh(){
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
      echo -n "$(print_icon 'SSH_ICON') "
    else
      echo -n "$(print_icon 'HOST_ICON') "
    fi
  }
  custom_user(){
    case $(whoami) in
      "root")
        USER_ICON=$POWERLEVEL9K_ROOT_ICON
        ;;
      *)
        USER_ICON=$POWERLEVEL9K_USER_ICON
        ;;
    esac
    echo -n "$USER_ICON $(whoami) $(zsh_detect_ssh)"
  }

  POWERLEVEL9K_CUSTOM_USER="custom_user"
  if [[ $(whoami) == "root" ]]; then
    POWERLEVEL9K_CUSTOM_USER_BACKGROUND=88
    POWERLEVEL9K_CUSTOM_USER_FOREGROUND=229
  else
    # POWERLEVEL9K_CUSTOM_USER_BACKGROUND=096
    # POWERLEVEL9K_CUSTOM_USER_FOREGROUND=229
    POWERLEVEL9K_CUSTOM_USER_BACKGROUND=214
    POWERLEVEL9K_CUSTOM_USER_FOREGROUND=094
  fi

  # Home block settings
  POWERLEVEL9K_HOME_ICON='\uF015' #  
  POWERLEVEL9K_HOME_SUB_ICON='\uF07C' #  
  POWERLEVEL9K_FOLDER_ICON='\uF115' #  

  # Dir block settings
  POWERLEVEL9K_DIR_PATH_SEPARATOR="%F{237} $(print_icon 'LEFT_SUBSEGMENT_SEPARATOR') %F{237}"
  # POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\UE0BC ' #   
  # POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='\UE0BA ' # 
  # POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\uE0B4' # 
  # POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='\uE0B6' # 
  # POWERLEVEL9K_SHORTEN_STRATEGY="truncate_beginning"
  # POWERLEVEL9K_SHORTEN_DELIMITER='..'
  POWERLEVEL9K_SHORTEN_DIR_LENGTH=2

  POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='dodgerblue1' # 033
  POWERLEVEL9K_DIR_DEFAULT_FOREGROUND=$DEFAULT_GREY
  POWERLEVEL9K_DIR_HOME_BACKGROUND='dodgerblue1' # 033
  POWERLEVEL9K_DIR_HOME_FOREGROUND=$DEFAULT_GREY
  POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='dodgerblue1' # 033
  POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND=$DEFAULT_GREY

  # POWERLEVEL9K_DIR_ETC_BACKGROUND=167
  POWERLEVEL9K_DIR_ETC_BACKGROUND=142
  POWERLEVEL9K_DIR_ETC_FOREGROUND=$DEFAULT_GREY
  # POWERLEVEL9K_ETC_ICON=''
  POWERLEVEL9K_ETC_ICON=''

  # Dir Writable settings
  POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND=167
  POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND=214

  # VCS settings
  POWERLEVEL9K_ICON_BEFORE_CONTENT=true
  # Custom prefix.
  # typeset -g POWERLEVEL9K_VCS_PREFIX='%fon '
  # Enable counters for staged, unstaged, etc.
  typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED,CONFLICTED,COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=-1

  POWERLEVEL9K_VCS_BRANCH_ICON='\uF126 ' # 
  # POWERLEVEL9K_VCS_GIT_GITHUB_ICON='\uF408' #  
  POWERLEVEL9K_VCS_GIT_GITHUB_ICON='\uF113 ' #  
  POWERLEVEL9K_VCS_GIT_GITLAB_ICON='\uF296 ' #  
  POWERLEVEL9K_VCS_GIT_BITBUCKET_ICON='\uF171 ' #  
  POWERLEVEL9K_VCS_GIT_ICON='\uF7A1 ' #  
  POWERLEVEL9K_VCS_STAGED_ICON='\uF055 ' #  
  POWERLEVEL9K_VCS_UNTRACKED_ICON='\uF00D ' #  
  POWERLEVEL9K_VCS_UNSTAGED_ICON='\uF421 ' #  
  POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='\uF0AB ' #  
  POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='\uF0AA ' #  
  POWERLEVEL9K_VCS_COMMIT_ICON='\uf417 ' # 
  # Gruvbox for VCS
  POWERLEVEL9K_VCS_CLEAN_FOREGROUND=$DEFAULT_GREY
  POWERLEVEL9K_VCS_CLEAN_BACKGROUND=142
  POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=$DEFAULT_GREY
  POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=167 #indianred
  POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=$DEFAULT_GREY
  POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=214 # orange1

  # Virtualenv block settings
  POWERLEVEL9K_VIRTUALENV_FOREGROUND='dodgerblue3' # 004
  POWERLEVEL9K_VIRTUALENV_BACKGROUND='gold1' # 220
  POWERLEVEL9K_PYTHON_ICON='\uE606' #  

  # Pyenv block settings
  POWERLEVEL9K_PYENV_FOREGROUND='dodgerblue3' # 004
  POWERLEVEL9K_PYENV_BACKGROUND='gold1' # 220
  # POWERLEVEL9K_PYENV_PROMPT_ALWAYS_SHOW=true

  # Time block settings
  POWERLEVEL9K_TIME_FORMAT="%D{\uf017 %H:%M \uf073 %d.%m.%y}"

  # Public IP block settings
  # Public IP color.
  typeset -g POWERLEVEL9K_PUBLIC_IP_FOREGROUND=94
  # Custom icon.
  typeset -g POWERLEVEL9K_PUBLIC_IP_VISUAL_IDENTIFIER_EXPANSION=''

  # Battery block settings
  # Show battery in red when it's below this level and not connected to power supply.
  typeset -g POWERLEVEL9K_BATTERY_LOW_THRESHOLD=20
  typeset -g POWERLEVEL9K_BATTERY_LOW_FOREGROUND=167
  # Show battery in green when it's charging or fully charged.
  typeset -g POWERLEVEL9K_BATTERY_{CHARGING,CHARGED}_FOREGROUND=142
  # Show battery in yellow when it's discharging.
  typeset -g POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND=214
  # Battery background color
  typeset -g POWERLEVEL9K_BATTERY_{LOW,CHARGING,CHARGED,DISCONNECTED}_BACKGROUND=$DEFAULT_GREY
  # Battery pictograms going from low to high level of charge.
  typeset -g POWERLEVEL9K_BATTERY_STAGES=$'\uf58d\uf579\uf57a\uf57b\uf57c\uf57d\uf57e\uf57f\uf580\uf581\uf578'
  # Don't show the remaining time to charge/discharge.
  typeset -g POWERLEVEL9K_BATTERY_VERBOSE=false

  # Transient prompt works similarly to the builtin transient_rprompt option. It trims down prompt
  # when accepting a command line. Supported values:
  #
  #   - off:      Don't change prompt when accepting a command line.
  #   - always:   Trim down prompt when accepting a command line.
  #   - same-dir: Trim down prompt when accepting a command line unless this is the first command
  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=always

  # Transparent background. 
  typeset -g POWERLEVEL9K_PROMPT_CHAR_BACKGROUND= 
  # Green prompt symbol if the last command succeeded. 
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=142
  # Red prompt symbol if the last command failed.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=167
  # Default prompt symbol.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
  # Prompt symbol in command vi mode.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮'
  # Prompt symbol in visual vi mode.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='Ⅴ'
  # Prompt symbol in overwrite vi mode.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIOWR_CONTENT_EXPANSION='▶'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OVERWRITE_STATE=true
  # No line terminator if prompt_char is the last segment. 
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=''
  # No line introducer if prompt_char is the first segment. 
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL= 
  # No surrounding whitespace. 
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_{LEFT,RIGHT}_WHITESPACE= 
fi
