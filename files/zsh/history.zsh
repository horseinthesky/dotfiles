# By default, zsh does not save the history to a file
## History file configuration
[[ -z $HISTFILE ]] && HISTFILE=$XDG_DATA_HOME/zsh/.zsh_history
#
# A number of commands that are stored in the zsh history file
[[ $SAVEHIST -lt 10000 ]] && SAVEHIST=10000

# A number of commands that are loaded into memory from the history file
[[ $HISTSIZE -lt 50000 ]] && HISTSIZE=50000

## History command configuration
setopt EXTENDED_HISTORY       # record timestamp of command in HISTFILE. Type "history -E -10" to view
setopt HIST_EXPIRE_DUPS_FIRST # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt HIST_IGNORE_DUPS       # ignore duplicated commands history list
setopt HIST_IGNORE_SPACE      # ignore commands that start with space
setopt HIST_VERIFY            # show command with history expansion to user before running it
setopt SHARE_HISTORY          # share command history data
