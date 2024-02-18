# root
alias sr='sudo -E -s'

# dirs
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'

alias md='mkdir -p'
alias rd='rm -rf'

# virtualenv
alias v='virtualenv .venv'
alias a='source ./.venv/bin/activate'
alias d='deactivate'

# docker
alias dp='docker ps -a'
alias di='docker images -a'

alias dre='docker rm $(docker ps -a -q -f status=exited)'
alias dri='docker rmi -f $(docker images -qf dangling=true)'

# k8s
k () {
  if [[ -n $(whence kubectl) ]]; then
    kubectl $@
  else
    microk8s kubectl $@
  fi
}

# poetry
alias pr='poetry run python'
alias pe='poetry env use'
alias pc='poetry config --list'
alias pi='poetry install'
alias pa='poetry add'
alias pt='poetry show --tree'
alias pu='poetry update'

# tmux
alias tn='tmux new -s '
alias ta='tmux a -t '
alias tk='tmux kill-session -t '
alias tK='tmux kill-server'
alias tl='tmux ls'
alias tpl='tmuxp load '

# misc
alias nv='~/.local/bin/nvim'
alias pp='ptpython'

alias grep='grep --color=auto --line-buffered'
alias diff='diff --color -u'

alias bw="sudo $HOME/.cargo/bin/bandwhich -d 8.8.8.8"
alias b="btm"
alias p="procs"
alias du="dust"
alias ll='lsd -lA --group-dirs first'

export EZA_COLORS="da=33"
alias l='eza --group-directories-first -la --icons --header --color-scale age'
t () {
  local depth=${2:-2}
  local dir=${1:-.}
  l --tree --level $depth $dir
}

# arc
alias ast='arc status'
alias acm='arc checkout trunk'
alias al='arc pull'
alias ap='arc push'
alias arh='arc reset --hard'
alias aco='arc checkout'
alias acb='arc checkout -b'

# vpn fix
alias vpn='sudo dpkg -i /usr/share/get-cert-tpm/*.deb'

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
alias gcl='git config --list'
alias gt='cd "$(git rev-parse --show-toplevel || echo .)"'
alias gfg='git ls-files | grep'
alias grv='git remote -v'
alias gcm='git checkout $(git_main_branch)'

alias gst='git status'
alias gss='git status -s'
alias gsb='git status -sb'

alias gl='git pull'
alias glo='git pull origin $(git branch --show-current)'
alias glum='git pull upstream $(git_main_branch)'

alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpf!='git push --force'
alias gpo='git push origin $(git branch --show-current)'
alias gpu='git push upstream'
alias gpoat='git push origin --all && git push origin --tags'

alias grh='git reset --hard'
alias groh='git reset origin/$(git branch --show-current) --hard'

alias grm='git rm'
alias grmc='git rm --cached'

alias gbl='git blame -b -w'
alias gcam='git commit -a -m'

alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'

alias gds='git diff --staged'
alias gdc='git diff --cached'
alias gdw='git diff --word-diff'
alias gdcw='git diff --cached --word-diff'
alias gdt='git diff-tree --no-commit-id --name-only -r'

alias gf='git fetch'
alias gfo='git fetch origin'

alias gbsup='git branch --set-upstream-to=origin/$(git branch --show-current)'
alias gpsup='git push --set-upstream origin $(git branch --show-current)'

alias gm='git merge'
alias gmom='git merge origin/$(git_main_branch)'
alias gmum='git merge upstream/$(git_main_branch)'
alias gma='git merge --abort'

alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase -i'
alias grbm='git rebase $(git_main_branch)'
alias grbo='git rebase --onto'
alias grbs='git rebase --skip'

alias gsl='git stash list'
alias gsp='git stash push'
alias gss='git stash save'
alias gsu='gss --include-untracked'
alias gsa='git stash apply'
alias gsp='git stash pop'
alias gsd='git stash drop'
alias gsc='git stash clear'
alias gsall='git stash --all'

function grename() {
  if [[ -z $1 || -z $2 ]]; then
    echo "Usage: $0 old_branch new_branch"
    return 1
  fi

  # Rename branch locally
  git branch -m $1 $2

  # Rename branch in origin remote
  if git push origin :$1; then
    git push --set-upstream origin $2
  fi
}
