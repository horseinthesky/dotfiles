alias sr='sudo -E -s'

alias vi=$(which nvim)
alias nv='~/.local/bin/nvim'

alias v='virtualenv .venv'
alias a='source ./.venv/bin/activate'
alias d='deactivate'

alias grep='grep --color=auto --line-buffered'
alias diff='diff --color -u'
alias ra='ranger'
alias bw="sudo $HOME/.cargo/bin/bandwhich -d 1.1.1.1"
alias t="btm"
alias p="procs"
alias du="dust"

# lsd
alias ll='lsd -lA --group-dirs first'
alias ls='lsd --group-dirs first'
alias lr='lsd -lAR --group-dirs first'

# exa
alias ex='exa --group-directories-first -la --icons --header'
alias et='ex --tree --level'

# tmux
alias tn='tmux new -s '
alias ta='tmux a -t '
alias tk='tmux kill-session -t '
alias tK='tmux kill-server'
alias tl='tmux ls'
alias tpl='tmuxp load '
