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

" ======== Commands ========
" Allow files to be saved as root when forgetting to start Vim using sudo.
" https://www.youtube.com/watch?v=AcvxrF2MrrI
" https://www.youtube.com/watch?v=u1HgODpoijc
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
