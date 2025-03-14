# ==== Tools ====
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
    --no-separator
    --no-scrollbar
    --layout=reverse
    --height 60%
    --prompt ' '
    --pointer ''
    --marker=⦁
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
[[ -z $(command -v z) ]] && eval "$(zoxide init zsh)"

# yc & ycp
[[ -d $HOME/yandex-cloud && ! $PATH == *$HOME/yandex-cloud/bin* ]] && export PATH=$HOME/yandex-cloud/bin:$PATH
[[ -d $HOME/ycp && ! $PATH == *$HOME/ycp/bin* ]] && export PATH=$HOME/ycp/bin:$PATH
[[ -f $HOME/yandex-cloud/completion.zsh.inc ]] && source $HOME/yandex-cloud/completion.zsh.inc

# ==== Yandex ====
# if [[ $(cat /proc/sys/kernel/hostname) == 'carbon9' ]] ; then
# fi
# export PSSH_AUTH_SOCK="/mnt/c/Users/$USER/AppData/Local/Temp/pssh-agent.sock"
# export SSH_AUTH_SOCK="${PSSH_AUTH_SOCK}"
# [[ $(ssh-add -l) =~ "$HOME/.ssh/id_rsa" ]] || ssh-add

# ==== MWS ====
load_mws() {
  local mwsenv="$HOME"/.mwsenv

  if [[ ! -f "$mwsenv" ]]; then
    echo -e "\e[93m \e[97mMWS env file $1 does not exist"
    return
  fi

  source "$mwsenv"
}

[[ $(cat /proc/sys/kernel/hostname) == "0000NBB0W095X1D" ]] && load_mws
