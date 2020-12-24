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
export TERM="xterm-256color"
export EDITOR="nvim"

export NVIM_COLORSCHEME=gruvbox

# Shell colorscheme fix
if [[ "$NVIM_COLORSCHEME" == "solarized8" ]]; then
  # solarized8 color fix
  source "$HOME/.local/share/nvim/plugged/vim-solarized8/scripts/solarized8.sh"
else
  # gruvbox colors fix
  source "$HOME/.local/share/nvim/plugged/gruvbox/gruvbox_256palette_osx.sh"
fi

# Set system locales
# export LC_ALL=C.UTF-8
# export LANG=C.UTF-8

# Disable tmupx autotitle
export DISABLE_AUTO_TITLE="true"

# fzf
if [[ -f "$HOME/.fzf.zsh" ]]; then
  source ~/.fzf.zsh
  export FZF_DEFAULT_COMMAND='fd --type f --type d --follow --hidden --exclude .git'
  export FZF_DEFAULT_OPTS='--height 60% --layout=reverse
    --preview "bat --style=numbers --color=always --line-range :500 {}"
    --color 'fg:230,fg+:229,hl:214,hl+:214,info:108''
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# pyenv settings
if [[ -d "$HOME/.pyenv" ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  # eval "$(pyenv init - --no-rehash)"
  # eval "$(pyenv virtualenv-init -)"
fi

# poetry settings
[[ -d "$HOME/.poetry" ]] &&  source $HOME/.poetry/env

# Vi Mode
# bindkey -v
export KEYTIMEOUT=1

weather () {
  local options="${2:-1}"
  curl https://wttr.in/"${1}"\?"${options}"
}

rate () {
  local FROM="${1:-USD}"
  local TO="${2:-RUB}"
  curl -s https://api.ratesapi.io/api/latest\?base\="${FROM}" | jq .rates."${TO}"
}

crate () {
  local coin="${1:-bitcoin}"
  local currency="${2:-usd}"
  curl -s https://api.coingecko.com/api/v3/simple/price\?ids="${coin}"\&vs_currencies="${currency}" \
    | jq ."${coin}"."${currency}"
}

cht () {
  local options="${2:-Q}"
  curl cht.sh/"${1}"\?"${options}"
}

ip4 () {
  curl https://api.ipify.org
}

ip6 () {
  curl https://api64.ipify.org
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
# ==== Yandex ====
# ssh-agent
# YA_HOSTNAMES=('horseinthesky-w' 'i104058879')
if [[ $(cat /etc/hostname) == 'horseinthesky-w' ]] || [[ $(cat /etc/hostname) == 'i104058879' ]] ; then
  export PSSH_AUTH_SOCK="/mnt/c/Users/$USER/AppData/Local/Temp/pssh-agent.sock"
  export SSH_AUTH_SOCK="${PSSH_AUTH_SOCK}"
  [[ $(ssh-add -l) =~ "/home/$USER/.ssh/id_rsa" ]] || ssh-add
fi

# The next line updates PATH for Yandex Cloud CLI.
[[ -f '/home/horseinthesky/yandex-cloud/path.bash.inc' ]] && source '/home/horseinthesky/yandex-cloud/path.bash.inc'

# ======== PATH ========
# Add ~/go/bin to PATH
export GOPATH="$HOME/go"
[[ -d "$GOPATH" ]] && export PATH="$PATH:$GOPATH/bin"

# Add /snap/bin to path
export SNAPPATH="/snap/bin"
[[ -d "$SNAPPATH" ]] && export PATH="$PATH:$SNAPPATH"

# Add pipx to path
export PIPXPATH="$HOME/.local/bin"
[[ -d "$PIPXPATH" ]] && export PATH="$PATH:$PIPXPATH"

# ======== ALIASES ========
alias vi=$(which nvim)
alias nv=$(which nvim)
alias sr='sudo -E -s'
alias diff='diff --color -u'
alias vid='vdiff'

vdiff () {
    if [ "${#}" -ne 2 ] ; then
        echo "vdiff requires two arguments"
        echo "  comparing dirs:  vdiff dir_a dir_b"
        echo "  comparing files: vdiff file_a file_b"
        return 1
    fi

    local left="${1}"
    local right="${2}"

    if [ -d "${left}" ] && [ -d "${right}" ]; then
        nvim +"DirDiff ${left} ${right}"
    else
        nvim -d "${left}" "${right}"
    fi
}

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

# ======== POWERLEVEL10K SETTINGS ========
if [[ "$ZSH_THEME" == "powerlevel10k/powerlevel10k" ]]; then
  P10K_THEME="lean"
  # P10K_THEME="rainbow"

  source $HOME/dotfiles/files/p10k.zsh
fi
