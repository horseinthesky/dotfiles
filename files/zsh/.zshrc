# ==== Settings ====
# Disable CTRL-s from freezing your terminal's output.
stty stop undef

# Disable highlighting of pasted text.
# zsh-autosuggestions intercepts paste settings. So if plugin is enabled this setting has no effect.
zle_highlight=('paste:none')

# ==== Options ====
# Enable in-line comments.
setopt INTERACTIVE_COMMENTS

# ==== Plugins ====
source "$ZDOTDIR"/utils.zsh

plugins=(
  zsh-autosuggestions
  alias-tips
)

for plugin in "${plugins[@]}"; do
  add_plugin "$plugin"
done

# ==== Addons ====
addons=(
  history
  aliases
  key-bindings
  completion
  functions
  fzf-functions
  fzf-git-functions
  network-functions
  tools
)

for addon in "${addons[@]}"; do
  source_file "$addon".zsh
done

# ==== Theme ====
ZSH_THEME=powerlevel10k
P10K_THEME=lean
# P10K_THEME=rainbow

load_theme $ZSH_THEME

# Enable Powerlevel10k instant prompt. Should stay close to the top of .zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source_file p10k.zsh
