" ==== Providers ====
" let g:loaded_clipboard_provider = 0
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
let g:python3_host_prog = '/usr/bin/python3'
let g:node_host_prog = '/usr/lib/node_modules/neovim/bin/cli.js'

syntax on

" ==== Search ====
set incsearch
set nohlsearch
set ignorecase
set smartcase

set inccommand=nosplit                " incremental substitution shows substituted text before applying
set laststatus=2                      " Always show statusline
set noshowmode                        " No to duplicate statusline
set nobackup                          " Don't create annoying backup files
set iskeyword+=-                      " Treat dash separated words as a word text object
set mouse=v                           " Diable mouse (if enabled temp. disable with holding Shift)
set scrolloff=10                      " Start scrolling 10 lines before edge of viewpoint
set pastetoggle=<F2>                  " Paste mode toggle to paste code properly
set guicursor=                        " Fix for mysterious 'q' letters
set completeopt=menu,menuone,noselect " Set completeopt to have a better completion experience
set shortmess+=c                      " don't give |ins-completion-menu| messages
set updatetime=300                    " Faster completion (default is 4000)
set timeoutlen=500                    " By default timeoutlen is 1000 ms
" set cmdheight=2                       " More space for messages

" ==== Windows ====
set number
set relativenumber
set listchars=tab:\ ,trail:·,precedes:←,extends:→,space:·,eol:↲,nbsp:␣
" set list

" ==== Cursor ====
set cursorline                        " Highlight cursorline
set colorcolumn=80,120                " Add vertical lines on columns
set linebreak                         " Word wrap
" set signcolumn=yes                    " Always show signcolumns (left row)

" ==== Folding ====
set foldmethod=indent                 " Fold based on indent
set foldnestmax=10                    " Deepest fold is 10 levels
set nofoldenable                      " Dont fold by default
set foldlevel=2                       " This is just what I use

" ==== History ====
set history=100
set undolevels=100
set undofile
set undodir=$HOME/.config/nvim/tmp/undo

" ==== Splits ====
set splitbelow                        " new horizontal split to appear below
set splitright                        " new vertical split to appear on the right

" ==== Buffers ====
set showtabline=1                     " show tabs only when 2 or more open
set noswapfile                        " Dont' use swapfile
set shiftwidth=2                      " shift lines by 2 spaces
set tabstop=2                         " 2 whitespaces for tabs visual presentation
set smarttab                          " set tabs for a shifttabs logic
set expandtab                         " expand tabs into spaces
set smartindent
set shiftround                        " When shifting lines, round the indentation to the nearest multiple of “shiftwidth.”

augroup TabSettings
  autocmd!
  " vim-commentary help
  autocmd BufRead,BufNewFile *.conf,*.cfg setlocal filetype=config
  autocmd FileType config       setlocal commentstring=#\ %s

  autocmd FileType python       setlocal sw=4 ts=4
  autocmd FileType jinja        setlocal sw=0
  autocmd FileType go           setlocal sw=8 ts=8 noet
augroup END
