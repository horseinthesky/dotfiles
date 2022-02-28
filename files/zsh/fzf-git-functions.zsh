# Helpers
is_in_git_repo() {
  git rev-parse --is-inside-work-tree > /dev/null 2>&1
}

fzf-down() {
  fzf --ansi --height 50% --min-height 20 \
    --bind ctrl-f:preview-down,ctrl-b:preview-up \
    --bind ctrl-p:toggle-preview $@
}

_pager='delta --side-by-side -w ${FZF_PREVIEW_COLUMNS:-$COLUMNS}'
_format='%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an'

# fuzzy git diff
_gdNames="git diff --name-status | sed -E 's/^(.)[[:space:]]+(.*)$/[\1]  \2/'"
_gdToFilename="echo {} | sed 's/.*]  //'"

function gd () {
  is_in_git_repo || return

  # Diff files if passed as arguments
  [[ $# -ne 0 ]] && git diff $@ && return

  local repo preview
  repo=$(git rev-parse --show-toplevel)
  preview="$_gdToFilename | xargs -I % git diff $repo/% | $_pager"

  eval $_gdNames |
  fzf-down --no-sort --no-multi \
    --header 'enter to view' \
    --preview-window right:70% \
    --preview $preview \
    --bind "enter:execute:$preview | less -R" \
}

# fuzzy git add selector
function ga() {
  is_in_git_repo || return 1

  # Add files if passed as arguments
  [[ $# -ne 0 ]] && git add $@ && return

  local changed unmerged untracked files opts preview extract
  changed=$(git config --get-color color.status.changed red)
  unmerged=$(git config --get-color color.status.unmerged red)
  untracked=$(git config --get-color color.status.untracked red)

  # NOTE: paths listed by 'git status -su' mixed with quoted and unquoted style
  # remove indicators | remove original path for rename case | remove surrounding quotes
  extract="
    sed 's/^.*]  //' |
    sed 's/.* -> //' |
    sed -e 's/^\\\"//' -e 's/\\\"\$//'"

  preview="
    file=\$(echo {} | $extract)
    if (git status -s -- \$file | grep '^??') &>/dev/null; then  # diff with /dev/null for untracked files
      git diff --color=always --no-index -- /dev/null \$file | $_pager | sed '2 s/added:/untracked:/'
    else
      git diff --color=always -- \$file | $_pager
    fi"

  files=$(git -c color.status=always -c status.relativePaths=true status -su |
    sed -E 's/^(..[^[:space:]]*)[[:space:]]+(.*)$/[\1]  \2/' |
    fzf-down -0 --multi \
      --header 'enter to add' \
      --preview-window right:70% --preview $preview |
    sh -c $extract)

  [[ -n $files ]] && echo $files | tr '\n' '\0' | xargs -0 -I % git add % && return

  echo 'Nothing to add.'
}


# fuzzy git reset HEAD (unstage) selector
_gdCached="git diff --cached"
_gdCachedDiff="$_gdCached --color=always -- {} | $_pager"

function gr () {
  is_in_git_repo || return 1

  # Reset files if passed as arguments
  [[ $# -ne 0 ]] && git reset -q HEAD $@ && return

  files=$(eval "$_gdCached --name-only --relative" |
    fzf-down -0 --multi \
      --header 'enter to reset' \
      --preview-window right:70% --preview $_gdCachedDiff
  )

  [[ -n $files ]] && echo $files | tr '\n' '\0' | xargs -0 -I % git reset -q HEAD % && return

  echo 'Nothing to unstage.'
}

# fuzzy git cherry pick
function gcp () {
  is_in_git_repo || return 1

  [[ -z $1 ]] && echo "Please specify target branch" && return 1

  # Cherry pick if commit hash is passed
  [[ $# > 1 ]] && { git cherry-pick ${@:2}; return $?; }

  local base target preview
  base=$(git branch --show-current)
  target=$1
  preview="echo {1} | xargs -I % git show --color=always % | $_pager"

  git cherry $base $target --abbrev -v | cut -d ' ' -f2- |
    fzf-down -0 --multi \
      --header 'enter to cherry pick' \
      --preview-window right:70% --preview $preview |
    cut -d' ' -f1 | xargs -I % git cherry-pick %
}

# fuzzy git branch delete
_glGraphDelete="git log -n 50 --graph --color=always --format=\"$_format\" {}"

function gbd () {
  is_in_git_repo || return 1

  git branch --sort=-committerdate |
    grep --invert-match '\*' |
    cut -c 3- |
    fzf-down --multi \
      --header "enter to delete" \
      --preview-window right:70% --preview $_glGraphDelete |
    xargs --no-run-if-empty git branch --delete --force
}

# fuzzy git commit browser with previews and vim integration
_glNoGraph="git log --color=always --format=\"$_format\""
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % git show --color=always % | $_pager"
_viewGitLogLineUnfancy="$_gitLogLineToHash | xargs -I % git show %"

function glog() {
  is_in_git_repo || return 1

  eval $_glNoGraph |
  fzf-down --no-sort --reverse --tiebreak=index --no-multi \
    --header 'enter to view, ctrl-v to open in vim' \
    --preview-window right:70% \
    --preview $_viewGitLogLine \
    --bind "enter:execute:$_viewGitLogLine | less -R" \
    --bind "ctrl-v:execute:$_viewGitLogLineUnfancy | $EDITOR -"
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

function gs() {
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

# fuzzy git checkout file
function gcf() {
  is_in_git_repo || return 1

  [[ $# -ne 0 ]] && { git checkout -- $@; return $?; }

  local cmd files
  cmd="git diff --color=always -- {} | $_pager"

  files=$(
    git ls-files --modified $(git rev-parse --show-toplevel) |
    fzf-down -0 --multi \
      --header 'enter to checkout' \
      --preview-window right:70% --preview $cmd
  )

  [[ -n $files ]] && echo $files | tr '\n' '\0' | xargs -0 -I % git checkout %
}

# fuzzy git checkout branch
_glGraph='git log -n 50 --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" $(sed s/^..// <<< {} | cut -d" " -f1)'

function gco() {
  is_in_git_repo || return 1

  [[ $# -ne 0 ]] && { git checkout $@; return $?; }

  local branch=$(
    git branch --all --sort=-committerdate | grep -v HEAD |
    fzf-down --no-multi \
      --header 'enter to checkout' \
      --preview-window right:70% --preview $_glGraph
  )

  [[ -z $branch ]] && return 1

  git checkout $(echo $branch | sed "s/.* //")
}

# fuzzy git checkout branch
function gcb () {
  is_in_git_repo || return 1

  [[ $# -ne 0 ]] && { git checkout -b $@; return $?; }

  local cmd preview branch
  cmd="git branch --all --sort=-committerdate | grep -v HEAD"
  preview="git log {1} -n 50 --graph --pretty=format:'$_format' --color=always --abbrev-commit --date=relative"

  branch=$(
    eval $cmd |
    fzf-down --no-sort --no-multi --tiebreak=index \
      --header 'enter to checkout' \
      --preview-window right:70% \
      --preview $preview | awk '{print $1}'
  )

  [[ -z $branch ]] && return 1

  # track the remote branch if possible
  if ! git checkout --track $branch 2>/dev/null; then
      git checkout $branch
  fi
}

alias gd="gd"
alias ga="ga"
alias gr="gr"
alias gcp="gcp"
alias gbd="gbd"
alias glog="glog"
alias gs="gs"
alias gcf="gcf"
alias gco="gco"
alias gcb="gcb"
