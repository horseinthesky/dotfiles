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
# export LC_ALL=C.UTF-8
# export LANG=C.UTF-8

export TERM="xterm-256color"
export EDITOR="nvim"
export ZSH_DISABLE_COMPFIX=true

# ssh-agent
if [[ $(cat /etc/hostname) == 'horseinthesky-w' ]]; then
  export PSSH_AUTH_SOCK="/mnt/c/Users/$USER/AppData/Local/Temp/pssh-agent.sock"
  export SSH_AUTH_SOCK="${PSSH_AUTH_SOCK}"
  if ! [[ $(ssh-add -l) =~ "/home/$USER/.ssh/id_rsa" ]]; then
    ssh-add
  fi
fi
# The next line updates PATH for Yandex Cloud CLI.
if [ -f '/home/horseinthesky/yandex-cloud/path.bash.inc' ]; then source '/home/horseinthesky/yandex-cloud/path.bash.inc'; fi

# pyenv settings
if [[ -d "$HOME/.pyenv" ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
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
  alias-tips
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
alias nv=$(which nvim)
alias sr='sudo -E -s'

# ranger aliases
alias ra='ranger'

# lsd aliases
alias ll='lsd -lA --group-dirs first'
alias ls='lsd --group-dirs first'
alias lr='lsd -lAR --group-dirs first'

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

  # P10K theme
  P10K_THEME="lean"
  # P10K_THEME="rainbow"

  # Theme
  source $HOME/dotfiles/files/p10k.zsh
fi
