# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets

# Use emacs key bindings
bindkey -e

# +------------------------------------+
# | Using terminfo in Application Mode |
# +------------------------------------+

typeset -g -A key

key[Backspace]="${terminfo[kbs]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[CTRLL]="${terminfo[kLFT5]}"
key[CTRLR]="${terminfo[kRIT5]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"

# Setup key accordingly
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" reverse-menu-complete
[[ -n "${key[CTRLL]}" ]] && bindkey -- "${key[CTRLL]}" backward-word
[[ -n "${key[CTRLR]}" ]] && bindkey -- "${key[CTRLR]}" forward-word

# Start typing + [Up-Arrow] - fuzzy find history forward
if [[ -n "${key[Up]}" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search

  bindkey -- "${key[Up]}" up-line-or-beginning-search
fi

# Start typing + [Down-Arrow] - fuzzy find history backward
if [[ -n "${key[Down]}" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search

  bindkey -- "${key[Down]}" down-line-or-beginning-search
fi

# [Ctrl-r] - Search backward incrementally for a specified string.
# The string may begin with ^ to anchor the search to the beginning of the line.
bindkey -- "^r" history-incremental-search-backward

# [Space] - don't do history expansion
bindkey -- " " magic-space

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey -- "\C-x\C-e" edit-command-line

# Copy previous shell work (useful when renaming)
bindkey -- "^p" copy-prev-shell-word

# Put sudo in front of command: bindkey <Esc><Esc>
_sudo-command-line () {
  # Use last command if no command given
  [[ -z $BUFFER ]] && LBUFFER=$(fc -ln -1)

  # Save beginning space
  local WHITESPACE=""

  if [[ ${LBUFFER:0:1} = " " ]]; then
    WHITESPACE=" "
    LBUFFER="${LBUFFER:1}"
  fi

  if [[ $BUFFER = sudo\ * ]]; then
    LBUFFER=${BUFFER:5}
  else
    LBUFFER="sudo $LBUFFER"
  fi

  # Preserve beginning space
  LBUFFER=${WHITESPACE}${LBUFFER}
}

zle -N _sudo-command-line

bindkey -- "\e\e" _sudo-command-line

# Make sure that the terminal is in application mode when zle is active.
# Only then values from $terminfo are valid
# Downside: when a CLI / TUI doesn't use application mode, some keys won't work.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
  autoload -Uz add-zle-hook-widget
  function zle_application_mode_start { echoti smkx }
  function zle_application_mode_stop { echoti rmkx }
  add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
  add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi
