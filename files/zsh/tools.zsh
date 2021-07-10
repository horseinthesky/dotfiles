# ======== Tools ========
# Disable tmupx autotitle
export DISABLE_AUTO_TITLE="true"

# fzf
if [[ -f "$HOME/.fzf.zsh" ]]; then
  source ~/.fzf.zsh

  FD_OPTIONS="--hidden --follow --exclude .git"
  export FZF_DEFAULT_COMMAND="fd --type f --type l $FD_OPTIONS"
  export FZF_DEFAULT_OPTS="--prompt ' ' --pointer '⯈' --marker=⦁ --height 60% --layout=reverse
    --color 'fg:#bdae93,fg+:#f9f5d7,hl:#fabd2f,hl+:#fabd2f,info:#8ec07c,pointer:#fb4934,marker:#fe8019,bg+:-1'"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

  bindkey '^f' fzf-cd-widget
fi

# pyenv settings
if [[ -d $HOME/.pyenv ]] && [[ ! $PATH == *$HOME/.pyenv/bin* ]]; then
  export PATH=$HOME/.pyenv/bin:$PATH
  # eval "$(pyenv init - --no-rehash)"
  # eval "$(pyenv virtualenv-init -)"
fi

# Add ~/go/bin to PATH
export GOPATH="$HOME/go"
if [[ -d $GOPATH ]] && [[ ! $PATH == *$GOPATH/bin* ]]; then
  export PATH=$GOPATH/bin:$PATH
fi

# Add local bin to path
if [[ -d $HOME/.local/bin ]] && [[ ! $PATH == *$HOME/.local/bin* ]]; then
  export PATH=$PATH:$HOME/.local/bin
fi

# Add python dev venv to path
if [[ -d $HOME/.python ]] && [[ ! $PATH == *$HOME/.python/bin* ]]; then
  export PATH=$HOME/.python/bin:$PATH
fi

# fnm
[[ -d $HOME/.fnm ]] && export PATH=$PATH:$HOME/.fnm && eval "$(fnm env)"

# yarn
if [[ -d $HOME/.yarn ]] && [[ ! $PATH == *$HOME/.yarn/bin* ]]; then
  export PATH=$HOME/.yarn/bin:$PATH
fi

# cargo
if [[ -d $HOME/.cargo ]] && [[ ! $PATH == *$HOME/.cargo/bin* ]]; then
  export PATH=$PATH:$HOME/.cargo/bin
fi

# zoxide
[[ ! -z $(which zoxide) ]] && eval "$(zoxide init zsh)"
