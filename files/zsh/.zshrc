# ==== Settings ====
zle_highlight=('paste:none')
export ZSH_DISABLE_COMPFIX=true

# ==== ohmyzsh ====
# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME=powerlevel10k/powerlevel10k

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
  sudo
  alias-tips
)

# ==== Sources ====
source $HOME/.ohmyzsh/oh-my-zsh.sh
source $ZDOTDIR/functions.zsh
source $ZDOTDIR/fzf-functions.zsh
source $ZDOTDIR/fzf-git-functions.zsh
source $ZDOTDIR/network-functions.zsh
source $ZDOTDIR/tools.zsh
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/completion.zsh

# ==== Theme ====
if [[ $ZSH_THEME == "powerlevel10k/powerlevel10k" ]]; then
  P10K_THEME=lean
  # P10K_THEME=rainbow

  source $ZDOTDIR/p10k.zsh
fi

# ==== WSL ====
# WSL 2 specific settings.
if grep -q "microsoft" /proc/version &>/dev/null; then
  # Requires: https://sourceforge.net/projects/vcxsrv/ (or alternative)
  export DISPLAY="$(/sbin/ip route | awk '/default/ { print $3 }'):0"
fi

# WSL 1 specific settings.
if grep -qE "(Microsoft|WSL)" /proc/version &>/dev/null; then
  if [ "$(umask)" = "0000" ]; then
    umask 0022
  fi

  # Requires: https://sourceforge.net/projects/vcxsrv/ (or alternative)
  export DISPLAY=:0
fi

# ==== Yandex ====
if [[ $(cat /proc/sys/kernel/hostname) == 'i104058879' ]] ; then
  export PSSH_AUTH_SOCK="/mnt/c/Users/$USER/AppData/Local/Temp/pssh-agent.sock"
  export SSH_AUTH_SOCK="${PSSH_AUTH_SOCK}"
  [[ $(ssh-add -l) =~ "$HOME/.ssh/id_rsa" ]] || ssh-add
fi

# The next line updates PATH for Yandex Cloud CLI.
[[ -f '/home/horseinthesky/yandex-cloud/path.bash.inc' ]] && source '/home/horseinthesky/yandex-cloud/path.bash.inc'
