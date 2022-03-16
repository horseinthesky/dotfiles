let $CONFIG_DIR = expand('$HOME/dotfiles/files/nvim/')

" ==== Stable config ====
if !has('nvim-0.5')
  set packpath-=~/.local/share/nvim/site
  source $CONFIG_DIR/setup.vim
endif

" ==== Nightly config ====
if has('nvim-0.5')
  lua require 'setup'
  runtime! packer/packer_compiled.vim
endif
