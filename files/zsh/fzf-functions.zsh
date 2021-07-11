# ==== General ====
fw() {
  # cd ~/$(find ~/netinfra_* -type d -prune -exec basename {} ';' | sort | uniq | nl | fzf | cut -f 2)
  cd $HOME/$(fd -t d "netinfra|ni_" $HOME | sed 's|.*/||' | fzf)
}

fenv () {
  virtualenv .venv -p=$(ll $HOME/.local/bin | grep python | awk '{print $11}' |
    fzf --delimiter='python' --with-nth=2
  )
}

# ==== Git ====
is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf --ansi --height 50% --min-height 20 \
    --bind ctrl-f:preview-down,ctrl-b:preview-up \
    --bind ctrl-/:toggle-preview "$@"
}

# fuzzy git branch checkout
_glGraph='git log -n 50 --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$(sed s/^..// <<< {} | cut -d" " -f1)"'

fgc() {
  is_in_git_repo || return

  local branch=$(
    git branch --sort=-committerdate |
    fzf-down --no-multi \
      --header 'enter:checkout' \
      --preview-window right:70% --preview $_glGraph \
  )

  [[ -z $branch ]] && return

  git checkout $(echo "$branch" | sed "s/.* //")
}

# fuzzy git branch delete
_glGraphDelete='git log -n 50 --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" {}'

fgd () {
  is_in_git_repo || return

  git branch |
    grep --invert-match '\*' |
    cut -c 3- |
    fzf-down --multi \
      --header "enter:delete" \
      --preview-window right:70% --preview $_glGraphDelete |
    xargs --no-run-if-empty git branch --delete --force
}

# git commit browser with previews and vim integration
_glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show % | delta'"
_viewGitLogLineUnfancy="$_gitLogLineToHash | xargs -I % sh -c 'git show %'"

fgl() {
  is_in_git_repo || return

  eval $_glNoGraph |
  fzf-down --no-sort --reverse --tiebreak=index --no-multi \
    --header "enter to view, ctrl-v to open in vim" \
    --preview-window right:70% \
    --preview $_viewGitLogLine \
    --bind "enter:execute:$_viewGitLogLine | less -R" \
    --bind "ctrl-v:execute:$_viewGitLogLineUnfancy | $EDITOR_NIGHTLY -"
}

# fgs - easier way to deal with stashes
# type fgs to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
_gitStashToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitStash="| xargs -I % sh -c 'git show --color=always % | delta'"
fgs() {
  local out k reflog

  out=(
    $(git stash list --pretty='%C(yellow)%gd %>(14)%Cgreen%cr %C(blue)%gs' |
      fzf-down --no-sort \
        --header='enter:show, ctrl-d:diff, ctrl-o:pop, ctrl-y:apply, ctrl-x:drop' \
        --preview-window right:70% --reverse \
        --preview='git stash show --color=always -p $(cut -d" " -f1 <<< {})' \
        --bind='enter:execute(git stash show --color=always -p $(cut -d" " -f1 <<< {}) | less -r > /dev/tty)' \
        --bind='ctrl-d:execute(git diff --color=always $(cut -d" " -f1 <<< {}) | less -r > /dev/tty)' \
        --expect=ctrl-o,ctrl-y,ctrl-x)
  )

  k=${out[1]}
  reflog=${out[2]}

  [ -n "$reflog" ] && case "$k" in
    ctrl-o) git stash pop $reflog ;;
    ctrl-y) git stash apply $reflog ;;
    ctrl-x) git stash drop $reflog ;;
  esac
}
