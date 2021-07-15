# Helpers
is_in_git_repo() {
  git rev-parse --is-inside-work-tree > /dev/null 2>&1
}

fzf-down() {
  fzf --ansi --height 50% --min-height 20 \
    --bind ctrl-f:preview-down,ctrl-b:preview-up \
    --bind ctrl-/:toggle-preview "$@"
}

_pager='delta --side-by-side -w ${FZF_PREVIEW_COLUMNS:-$COLUMNS}'

# fuzzy git diff
_gd="git diff --name-status | sed -E 's/^(.)[[:space:]]+(.*)$/[\1]  \2/'"
_gdToFilename="echo {} | sed 's/.*]  //'"
_viewGitDiff="$_gdToFilename | xargs -I % git diff % | $_pager"

fgd () {
  is_in_git_repo || return

  eval $_gd |
  fzf-down --no-sort --no-multi \
    --header 'enter to view' \
    --preview-window right:70% \
    --preview $_viewGitDiff \
    --bind "enter:execute:$_viewGitDiff | less -R" \
}

# fuzzy git branch checkout
_glGraph='git log -n 50 --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$(sed s/^..// <<< {} | cut -d" " -f1)"'

fgc() {
  is_in_git_repo || return 1

  local branch=$(
    git branch --sort=-committerdate |
    fzf-down --no-multi \
      --header 'enter to checkout' \
      --preview-window right:70% --preview $_glGraph \
  )

  [[ -z $branch ]] && return

  git checkout $(echo "$branch" | sed "s/.* //")
}

# fuzzy git branch delete
_glGraphDelete='git log -n 50 --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" {}'

fgD () {
  is_in_git_repo || return 1

  git branch |
    grep --invert-match '\*' |
    cut -c 3- |
    fzf-down --multi \
      --header "enter to delete" \
      --preview-window right:70% --preview $_glGraphDelete |
    xargs --no-run-if-empty git branch --delete --force
}

# git commit browser with previews and vim integration
_glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % git show % | $_pager"
_viewGitLogLineUnfancy="$_gitLogLineToHash | xargs -I % sh -c 'git show %'"

fgl() {
  is_in_git_repo || return 1

  eval $_glNoGraph |
  fzf-down --no-sort --reverse --tiebreak=index --no-multi \
    --header 'enter to view, ctrl-v to open in vim' \
    --preview-window right:70% \
    --preview $_viewGitLogLine \
    --bind "enter:execute:$_viewGitLogLine | less -R" \
    --bind "ctrl-v:execute:$_viewGitLogLineUnfancy | $EDITOR_NIGHTLY -"
}

# fgs - easier way to deal with stashes
# type fgs to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-o pops a stash
# ctrl-y applies a stash
# ctrl-x dropss a stash
_gsStashShow='git stash show --color=always -p $(cut -d" " -f1 <<< {})'
_gsStashShowFancy="$_gsStashShow | $_pager"
_gsDiff='git diff --color=always $(cut -d" " -f1 <<< {})'

fgs() {
  is_in_git_repo || return 1

  local out k reflog

  out=(
    $(git stash list --pretty='%C(yellow)%gd %>(14)%Cgreen%cr %C(blue)%gs' |
      fzf-down --no-sort --reverse --no-multi \
        --header 'enter to show, ctrl-d to diff, ctrl-o to pop, ctrl-y to apply, ctrl-x to drop' \
        --preview-window right:70% \
        --preview $_gsStashShowFancy \
        --bind "enter:execute:$_gsStashShowFancy | less -R > /dev/tty" \
        --bind "ctrl-d:execute:$_gsDiff | $_pager | less -R > /dev/tty" \
        --expect=ctrl-o,ctrl-y,ctrl-x
    )
  )

  k=${out[1]}
  reflog=${out[2]}

  [ -n $reflog ] && case $k in
    ctrl-o) git stash pop $reflog ;;
    ctrl-y) git stash apply $reflog ;;
    ctrl-x) git stash drop $reflog ;;
  esac
}
