# ==== Settings ====
export ZSH_DISABLE_COMPFIX=true

# Disable CTRL-s from freezing your terminal's output.
stty stop undef

zle_highlight=('paste:none')

# ==== Options ====
setopt INTERACTIVE_COMMENTS  # Enable in-line comments

# ==== Plugins ====
source $ZDOTDIR/utils.zsh

plugins=(
  zsh-autosuggestions
  alias-tips
)

for plugin in ${plugins[@]}; do
  add_plugin $plugin
done

# ==== Addons ====
source_file history.zsh
source_file aliases.zsh
source_file key-bindings.zsh
source_file completion.zsh
source_file functions.zsh
source_file fzf-functions.zsh
source_file fzf-git-functions.zsh
source_file network-functions.zsh
source_file tools.zsh

# ==== Theme ====
ZSH_THEME=powerlevel10k

load_theme $ZSH_THEME

P10K_THEME=lean
# P10K_THEME=rainbow

source_file p10k.zsh

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
