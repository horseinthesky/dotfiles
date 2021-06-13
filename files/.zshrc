# ======== ZSH ========
export ZSH_DISABLE_COMPFIX=true

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
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

# ======== SETTINGS ========
# export TERM="xterm-256color"
export EDITOR="nvim"

# Set system locales
# export LC_ALL=C.UTF-8
# export LANG=C.UTF-8

# Vi Mode
# bindkey -v
export KEYTIMEOUT=1

# ==== Functions ====
weather () {
  local options="${2:-1}"
  curl https://wttr.in/"${1}"\?"${options}"
}

erapi_key=71afe1269a1f5f7206152de2b43a9819
rate () {
  local from=${1:-usd}
  local to=${2:-rub}
  local rate=$(curl -s http://api.exchangeratesapi.io/v1/latest\?access_key=${erapi_key} | jq .rates.${(U)to})
  echo 1 ${(U)from} is ${rate} ${(U)to}
}

crate () {
  local coin=${1:-bitcoin}
  local currency=${2:-usd}
  local crate=$(curl -s https://api.coingecko.com/api/v3/simple/price\?ids=${coin}\&vs_currencies=${currency} \
    | jq .${coin}.${currency})
  echo 1 ${coin} is ${crate} $currency
}

cht () {
  local options=${2:-Q}
  curl cht.sh/${1}\?${options}
}

ip4 () {
  curl -w '\n' https://api.ipify.org
}

ip6 () {
  curl -w '\n' https://api64.ipify.org
}

# WSL 2 specific settings.
if grep -q "microsoft" /proc/version &>/dev/null; then
    # Requires: https://sourceforge.net/projects/vcxsrv/ (or alternative)
    export DISPLAY="$(/sbin/ip route | awk '/default/ { print $3 }'):0"
fi

# WSL 1 specific settings.
if grep -qE "(Microsoft|WSL)" /proc/version &>/dev/null; then
    if [ "$(umask)" = "0000" ]; then
        umask 0022
    fi

    # Requires: https://sourceforge.net/projects/vcxsrv/ (or alternative)
    export DISPLAY=:0
fi

# RIPEstat
prfx () {
  local as="${1}"
  curl -s https://stat.ripe.net/data/announced-prefixes/data.json\?resource\="${as}" | jq -r '.data.prefixes[] | .prefix'
}

lg () {
  local resource="${1}"
  local filter="${2}"
  curl -s https://stat.ripe.net/data/looking-glass/data.json\?resource\="${resource}" | jq --arg as_path "${filter}" '.data.rrcs[].peers[] | select(.as_path | contains($as_path))'
}

rpki () {
  local as="${1}"
  local prefix="${2}"
  curl -s https://stat.ripe.net/data/rpki-validation/data.json\?resource\="${as}"\&prefix="${prefix}" | jq -r '.data.status'
}

# ==== Yandex ====
if [[ $(cat /etc/hostname) == 'i104058879' ]] ; then
  export PSSH_AUTH_SOCK="/mnt/c/Users/$USER/AppData/Local/Temp/pssh-agent.sock"
  export SSH_AUTH_SOCK="${PSSH_AUTH_SOCK}"
  [[ $(ssh-add -l) =~ "$HOME/.ssh/id_rsa" ]] || ssh-add
fi

# The next line updates PATH for Yandex Cloud CLI.
[[ -f '/home/horseinthesky/yandex-cloud/path.bash.inc' ]] && source '/home/horseinthesky/yandex-cloud/path.bash.inc'

# ======== Tools ========
# fzf
if [[ -f "$HOME/.fzf.zsh" ]]; then
  source ~/.fzf.zsh

  FD_OPTIONS="--hidden --follow --exclude .git"
  export FZF_DEFAULT_COMMAND="fd --type f --type l $FD_OPTIONS"
  export FZF_DEFAULT_OPTS="--prompt ' ' --pointer '⯈' --marker=⦁ --height 60% --layout=reverse
    --color 'fg:#bdae93,fg+:#f9f5d7,hl:#fabd2f,hl+:#fabd2f,info:#8ec07c,pointer:#fb4934,marker:#fe8019,bg+:-1'"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

  bindkey '^f' fzf-cd-widget
fi

# Disable tmupx autotitle
export DISABLE_AUTO_TITLE="true"

# pyenv settings
if [[ -d $HOME/.pyenv ]] && [[ ! $PATH == *$HOME/.pyenv/bin* ]]; then
  export PATH=$HOME/.pyenv/bin:$PATH
  # eval "$(pyenv init - --no-rehash)"
  # eval "$(pyenv virtualenv-init -)"
fi

# Add ~/go/bin to PATH
export GOPATH="$HOME/go"
if [[ -d $GOPATH ]] && [[ ! $PATH == *$GOPATH/bin* ]]; then
  export PATH=$GOPATH/bin:$PATH
fi

# Add local bin to path
if [[ -d $HOME/.local/bin ]] && [[ ! $PATH == *$HOME/.local/bin* ]]; then
  export PATH=$PATH:$HOME/.local/bin
fi

# Add private bin to path
if [[ -d $HOME/bin ]] && [[ ! $PATH == *$HOME/bin* ]]; then
  export PATH=$HOME/bin:$PATH
fi

# Add python dev venv to path
if [[ -d $HOME/opt/venv ]] && [[ ! $PATH == *$HOME/opt/venv/bin* ]]; then
  export PATH=$HOME/opt/venv/bin:$PATH
fi

# nvm
[[ -d $HOME/.nvm ]] && source $HOME/.nvm/nvm.sh

# node modules
if [[ -d $HOME/opt/node_modules ]] && [[ ! $PATH == *$HOME/opt/node_modules/.bin* ]]; then
  export PATH=$HOME/opt/node_modules/.bin:$PATH
fi

# ======== ALIASES ========
alias vi=$(which nvim)
alias nv='~/.local/bin/nvim'
alias sr='sudo -E -s'
alias v='virtualenv .venv'
alias a='source ./.venv/bin/activate'
alias d='deactivate'
alias grep='grep --color=auto --line-buffered'
alias diff='diff --color -u'
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

# ======== POWERLEVEL10K SETTINGS ========
if [[ $ZSH_THEME == "powerlevel10k/powerlevel10k" ]]; then
  P10K_THEME=lean
  # P10K_THEME=rainbow

  source $HOME/dotfiles/files/p10k.zsh
fi
