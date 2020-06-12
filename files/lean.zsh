# Basic style options that define the overall look of your prompt. You probably don't want to
# change them.
typeset -g POWERLEVEL9K_BACKGROUND=
typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=  # no surrounding whitespace
typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '  # separate segments with a space
typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=        # no end-of-line symbol

# Prefixes
DEFAULT_PREFIX_COLOR=249
typeset -g POWERLEVEL9K_{CUSTOM_HOST,VCS}_PREFIX='%F{$DEFAULT_PREFIX_COLOR}on '
typeset -g POWERLEVEL9K_{DIR,VIRTUALENV}_PREFIX='%F{$DEFAULT_PREFIX_COLOR}in '
typeset -g POWERLEVEL9K_PYENV_PREFIX='%F{$DEFAULT_PREFIX_COLOR}via '
typeset -g POWERLEVEL9K_BATTERY_PREFIX='%F{$DEFAULT_PREFIX_COLOR}at '

# Host block settings
typeset -g POWERLEVEL9K_CUSTOM_HOST="custom_host"
if [[ -n "$WSL_DISTRO_NAME" ]]; then
  typeset -g POWERLEVEL9K_CUSTOM_HOST_FOREGROUND=039
else
  source /etc/os-release
  case $ID in
    ubuntu)
      typeset -g POWERLEVEL9K_CUSTOM_HOST_FOREGROUND=166
      ;;
    debian)
      typeset -g POWERLEVEL9K_CUSTOM_HOST_FOREGROUND=197
      ;;
    centos)
      typeset -g POWERLEVEL9K_CUSTOM_HOST_FOREGROUND=160
      ;;
    manjaro)
      typeset -g POWERLEVEL9K_CUSTOM_HOST_FOREGROUND=041
      ;;
    arch)
      typeset -g POWERLEVEL9K_CUSTOM_HOST_FOREGROUND=039
      ;;
    *)
      typeset -g POWERLEVEL9K_CUSTOM_HOST_FOREGROUND=032
      ;;
  esac
fi

# User block settings
typeset -g POWERLEVEL9K_CUSTOM_USER="custom_user"
if [[ $(whoami) == "root" ]]; then
  typeset -g POWERLEVEL9K_CUSTOM_USER_FOREGROUND=167
else
  typeset -g POWERLEVEL9K_CUSTOM_USER_FOREGROUND=174
fi

# Dir block settings
typeset -g POWERLEVEL9K_DIR_FOREGROUND=033 # dodgerblue1
typeset -g POWERLEVEL9K_DIR_{DEFAULT,HOME,HOME_SUBFOLDER}_FOREGROUND=033 # dodgerblue1
typeset -g POWERLEVEL9K_DIR_NOT_WRITABLE_FOREGROUND=167
typeset -g POWERLEVEL9K_DIR_ETC_FOREGROUND=142

# Dir Writable settings
typeset -g POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND=167
typeset -g POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_ICON=' '

# Virtualenv block settings
typeset -g POWERLEVEL9K_{VIRTUALENV,PYENV}_FOREGROUND=220

# Battery background color
typeset -g POWERLEVEL9K_BATTERY_{LOW,CHARGING,CHARGED,DISCONNECTED}_BACKGROUND=

# CPU and RAM
typeset -g POWERLEVEL9K_{CPU,RAM}_BACKGROUND=

# VCS block settings
typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=142
typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=167 #indianred
typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=214 # orange1

# Formatter for Git status.
#
# You can edit the function to customize how Git status looks.
#
# VCS_STATUS_* parameters are set by gitstatus plugin. See reference:
# https://github.com/romkatv/gitstatus/blob/master/gitstatus.plugin.zsh.
function my_git_formatter() {
  emulate -L zsh

  if [[ -n $P9K_CONTENT ]]; then
    # If P9K_CONTENT is not empty, use it. It's either "loading" or from vcs_info (not from
    # gitstatus plugin). VCS_STATUS_* parameters are not available in this case.
    typeset -g my_git_format=$P9K_CONTENT
    return
  fi

  if (( $1 )); then
    # Styling for up-to-date Git status.
    local       meta='%f'     # default foreground
    local      clean='%142F'  # green foreground
    local   modified='%214F'  # yellow foreground
    local  untracked='%208F'  # orange foreground
    local conflicted='%167F'  # red foreground
    local    stashed='%109F'  # blue foreground
  else
    # Styling for incomplete and stale Git status.
    local       meta='%244F'  # grey foreground
    local      clean='%244F'  # grey foreground
    local   modified='%244F'  # grey foreground
    local  untracked='%244F'  # grey foreground
    local conflicted='%244F'  # grey foreground
    local    stashed='%244F'  # blue foreground
  fi

  local res
  local where  # branch or tag
  if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
    res+="${clean}${(g::)POWERLEVEL9K_VCS_BRANCH_ICON}"
    where=${(V)VCS_STATUS_LOCAL_BRANCH}
  elif [[ -n $VCS_STATUS_TAG ]]; then
    res+="${meta}#"
    where=${(V)VCS_STATUS_TAG}
  fi

  # If local branch name or tag is at most 32 characters long, show it in full.
  # Otherwise show the first 12 … the last 12.
  # Tip: To always show local branch name in full without truncation, delete the next line.
  (( $#where > 32 )) && where[13,-13]="…"
  res+="${clean}${where//\%/%%}"  # escape %

  # Display the current Git commit if there is no branch or tag.
  # Tip: To always display the current Git commit, remove `[[ -z $where ]] &&` from the next line.
  [[ -z $where ]] && res+="${meta}@${clean}${VCS_STATUS_COMMIT[1,8]}"

  # Show tracking branch name if it differs from local branch.
  if [[ -n ${VCS_STATUS_REMOTE_BRANCH:#$VCS_STATUS_LOCAL_BRANCH} ]]; then
    res+="${meta}:${clean}${(V)VCS_STATUS_REMOTE_BRANCH//\%/%%}"  # escape %
  fi

  #  42 if behind the remote.
  (( VCS_STATUS_COMMITS_BEHIND )) && res+=" ${clean}${(g::)POWERLEVEL9K_VCS_COMMITS_BEHIND_ICON}${VCS_STATUS_COMMITS_BEHIND}"
  #  42 if ahead of the remote; no leading space if also behind the remote: ⇣42⇡42.
  (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && res+=" "
  (( VCS_STATUS_COMMITS_AHEAD  )) && res+="${clean}${(g::)POWERLEVEL9K_VCS_COMMITS_AHEAD_ICON}${VCS_STATUS_COMMITS_AHEAD}"
  #  42 if behind the push remote.
  (( VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" ${clean}${(g::)POWERLEVEL9K_VCS_PUSH_COMMITS_BEHIND_ICON}${VCS_STATUS_PUSH_COMMITS_BEHIND}"
  (( VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" "
  #  42 if ahead of the push remote; no leading space if also behind:  42  42.
  (( VCS_STATUS_PUSH_COMMITS_AHEAD  )) && res+="${clean}${(g::)POWERLEVEL9K_VCS_PUSH_COMMITS_AHEAD_ICON}${VCS_STATUS_PUSH_COMMITS_AHEAD}"
  #  42 if have stashes.
  (( VCS_STATUS_STASHES        )) && res+=" ${stashed}${(g::)POWERLEVEL9K_VCS_STASH_ICON}${VCS_STATUS_STASHES}"
  # 'merge' if the repo is in an unusual state.
  [[ -n $VCS_STATUS_ACTION     ]] && res+=" ${conflicted}${VCS_STATUS_ACTION}"
  #  42 if have merge conflicts.
  (( VCS_STATUS_NUM_CONFLICTED )) && res+=" ${conflicted}${(g::)POWERLEVEL9K_VCS_CONFLICTED_ICON}${VCS_STATUS_NUM_CONFLICTED}"
  #  42 if have staged changes.
  (( VCS_STATUS_NUM_STAGED     )) && res+=" ${modified}${(g::)POWERLEVEL9K_VCS_STAGED_ICON}${VCS_STATUS_NUM_STAGED}"
  #  42 if have unstaged changes.
  (( VCS_STATUS_NUM_UNSTAGED   )) && res+=" ${modified}${(g::)POWERLEVEL9K_VCS_UNSTAGED_ICON}${VCS_STATUS_NUM_UNSTAGED}"
  #  42 if have untracked files.
  # Remove the next line if you don't want to see untracked files at all.
  (( VCS_STATUS_NUM_UNTRACKED  )) && res+=" ${untracked}${(g::)POWERLEVEL9K_VCS_UNTRACKED_ICON}${VCS_STATUS_NUM_UNTRACKED}"

  typeset -g my_git_format=$res
}
functions -M my_git_formatter 2>/dev/null

# Don't count the number of unstaged, untracked and conflicted files in Git repositories with
# more than this many files in the index. Negative value means infinity.
#
# If you are working in Git repositories with tens of millions of files and seeing performance
# sagging, try setting POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY to a number lower than the output
# of `git ls-files | wc -l`. Alternatively, add `bash.showDirtyState = false` to the repository's
# config: `git config bash.showDirtyState false`.
typeset -g POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY=-1

# Don't show Git status in prompt for repositories whose workdir matches this pattern.
# For example, if set to '~', the Git repository at $HOME/.git will be ignored.
# Multiple patterns can be combined with '|': '~(|/foo)|/bar/baz/*'.
typeset -g POWERLEVEL9K_VCS_DISABLED_WORKDIR_PATTERN='~'

# Disable the default Git status formatting.
typeset -g POWERLEVEL9K_VCS_DISABLE_GITSTATUS_FORMATTING=true
# Install our own Git status formatter.
typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='${$((my_git_formatter(1)))+${my_git_format}}'
typeset -g POWERLEVEL9K_VCS_LOADING_CONTENT_EXPANSION='${$((my_git_formatter(0)))+${my_git_format}}'

# Icon color.
typeset -g POWERLEVEL9K_VCS_VISUAL_IDENTIFIER_COLOR=142
typeset -g POWERLEVEL9K_VCS_LOADING_VISUAL_IDENTIFIER_COLOR=244
# Custom icon.
# typeset -g POWERLEVEL9K_VCS_VISUAL_IDENTIFIER_EXPANSION='⭐'

# Show status of repositories of these types. You can add svn and/or hg if you are
# using them. If you do, your prompt may become slow even when your current directory
# isn't in an svn or hg reposotiry.
typeset -g POWERLEVEL9K_VCS_BACKENDS=(git)
