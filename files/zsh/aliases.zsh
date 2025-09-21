# root
alias sr='sudo -E -s'

# dirs
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'

alias md='mkdir -p'
alias rd='rm -rf'

# Local env stuff
alias nv='$HOME/.local/bin/nvim'
alias pp='ptpython'

# Python virtualenv
alias v='virtualenv .venv'
alias a='source ./.venv/bin/activate'
alias d='deactivate'

# containers
alias c='incus'

alias dc='docker ps -a'
alias di='docker images -a'
alias dl='docker logs'
alias drc='docker rm $(docker ps -a -q -f status=exited)'
alias dri='docker rmi -f $(docker images -qf dangling=true)'

alias k='kubectl'
alias kx='kubectx'
alias kn='kubens'
alias h='helm'

# tmux
alias tn='tmux new -s '
alias ta='tmux a -t '
alias tk='tmux kill-session -t '
alias tK='tmux kill-server'
alias tl='tmux ls'
alias tpl='tmuxp load '

# misc
alias dig='dig +noall +answer +stats'
alias r='nc -vz'

alias grep='grep --color=auto --line-buffered'
alias diff='diff --color -u'

# tools
alias bw="sudo $HOME/.cargo/bin/bandwhich -d 8.8.8.8"
alias b="btm"
alias p="procs"
alias du="dust"

export EZA_COLORS="da=33"
alias l='eza --group-directories-first -la --icons --header --color-scale age'
t () {
  local depth=${2:-2}
  local dir=${1:-.}
  l --tree --level $depth $dir
}

# git
git_main_branch () {
  command git rev-parse --git-dir &>/dev/null || return

  local branch
  for branch in main trunk; do
    if command git show-ref -q --verify refs/heads/$branch; then
      echo $branch
      return
    fi
  done

  echo master
}

alias g='git'
alias gt='cd "$(git rev-parse --show-toplevel || echo .)"'
alias gcl='git config --list'
alias grv='git remote -v'
alias gst='git status'
alias gbl='git blame -b -w'
alias gcm='git checkout $(git_main_branch)'
alias gcam='git commit -am'

alias gf='git fetch'
alias gfo='git fetch origin'

alias gl='git pull'
alias glo='git pull origin $(git branch --show-current)'

alias gp='git push'
alias gpo='git push origin $(git branch --show-current)'

alias grh='git reset --hard'
alias groh='git reset origin/$(git branch --show-current) --hard'
