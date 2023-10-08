# ======== Tools ========
# Disable tmupx autotitle
export DISABLE_AUTO_TITLE=true

# snaps
[[ -d /snap/bin && ! $PATH == */snap/bin* ]] && export PATH=$PATH:/snap/bin

# fzf
if [[ -f $HOME/.fzf.zsh ]]; then
  source $HOME/.fzf.zsh

  FD_OPTIONS="--hidden --follow --exclude .git"
  export FZF_DEFAULT_COMMAND="fd --type f --type l $FD_OPTIONS"
  export FZF_DEFAULT_OPTS="
    --prompt ' '
    --pointer '►'
    --marker=⦁
    --height 60%
    --layout=reverse
    --color
      'fg:#bdae93,fg+:#f9f5d7,hl:#fabd2f,hl+:#fabd2f,info:#8ec07c,pointer:#fb4934,marker:#fe8019,bg+:-1'
  "
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
[[ -d $HOME/go && ! $PATH == *$HOME/go/bin* ]] && export PATH=$HOME/go/bin:$PATH

# Add local bin to path
[[ -d $HOME/.local/bin && ! $PATH == *$HOME/.local/bin* ]] && export PATH=$PATH:$HOME/.local/bin

# Add python dev venv to path
[[ -d $HOME/.python && ! $PATH == *$HOME/.python/bin* ]] && export PATH=$HOME/.python/bin:$PATH

# fnm
if [[ -d $HOME/.fnm ]] && [[ ! $PATH == *$HOME/.fnm* ]]; then
  export PATH=$PATH:$HOME/.fnm
  eval "$(fnm env)"
fi

# yarn
[[ -d $HOME/.yarn && ! $PATH == *$HOME/.yarn/bin* ]] && export PATH=$HOME/.yarn/bin:$PATH

# cargo
[[ -d $HOME/.cargo && ! $PATH == *$HOME/.cargo/bin* ]] && export PATH=$PATH:$HOME/.cargo/bin

# zoxide
[[ -z $(whence z) ]] && eval "$(zoxide init zsh)"
