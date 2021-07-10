# ==== FZF ====
is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf --ansi --height 50% --min-height 20 \
    --bind ctrl-f:preview-down,ctrl-b:preview-up \
    --bind ctrl-/:toggle-preview "$@"
}

alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
_glGraph='git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$(sed s/^..// <<< {} | cut -d" " -f1)"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | delta'"
_viewGitLogLineUnfancy="$_gitLogLineToHash | xargs -I % sh -c 'git show %'"

# git commit browser with previews and vim integration
fgl() {
  is_in_git_repo || return

  glNoGraph |
    fzf-down --no-sort --reverse --tiebreak=index --no-multi \
      --preview="$_viewGitLogLine" \
      --header "enter to view, ctrl-v to open in nvim" \
      --bind "enter:execute:$_viewGitLogLine | less -R" \
      --bind "ctrl-v:execute:$_viewGitLogLineUnfancy | $EDITOR_NIGHTY -"
}

fgc() {
  is_in_git_repo || return

  local branches=$(git branch --all | grep -v HEAD)
  local branch=$(echo "$branches" |
    fzf-down --no-multi \
      --preview-window right:70% --preview $_glGraph \
      -d $(( 2 + $(wc -l <<< "$branches")))
  )

  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
fgs() {
  local out q k sha
  while out=$(
    git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
    fzf --ansi --no-sort --query="$q" --print-query \
        --expect=ctrl-d,ctrl-b);
  do
    IFS=$'\n'; set -f
    lines=($(<<< "$out"))
    unset IFS; set +f
    q="${lines[0]}"
    k="${lines[1]}"
    sha="${lines[-1]}"
    sha="${sha%% *}"
    [[ -z "$sha" ]] && continue
    if [[ "$k" == 'ctrl-d' ]]; then
      git diff $sha
    elif [[ "$k" == 'ctrl-b' ]]; then
      git stash branch "stash-$sha" $sha
      break;
    else
      git -c color.ui=always stash show -p $sha | less -+F
    fi
  done
}

gstash() {
  local out k reflog

  out=(
    $(git stash list --pretty='%C(yellow)%gd %>(14)%Cgreen%cr %C(blue)%gs' |
      fzf --no-sort \
        --header='enter:show, ctrl-d:diff, ctrl-o:pop, ctrl-y:apply, ctrl-x:drop' \
        --preview-window right:70% --reverse \
        --preview='git stash show --color=always -p $(cut -d" " -f1 <<< {}) | head -'$LINES \
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

fw() {
  # cd ~/$(find ~/netinfra_* -type d -prune -exec basename {} ';' | sort | uniq | nl | fzf | cut -f 2)
  cd $HOME/$(fd -t d "netinfra|ni_" $HOME | sed 's|.*/||' | fzf)
}
