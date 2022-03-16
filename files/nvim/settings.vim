" ==== Providers ====
" let g:loaded_clipboard_provider = 0
let g:clipboard = {
  \ 'name': 'void',
  \ 'copy': {
  \   '+': {-> v:true},
  \   '*': {-> v:true}
  \ },
  \ 'paste': {
  \   '+': {-> []},
  \   '*': {-> []}
  \ }
\ }

let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
let g:python3_host_prog = '~/.python/bin/python'
let g:node_host_prog = '~/.local/share/yarn/global/node_modules/neovim/bin/cli.js'

syntax on

" ==== Gerenal ====
set inccommand=nosplit                " Incremental substitution shows substituted text before applying
set laststatus=2                      " Always show statusline
set noshowmode                        " No to duplicate statusline
set nobackup                          " Don't create annoying backup files
set iskeyword+=-                      " Treat dash separated words as a word text object
set mouse=v                           " Diable mouse (if enabled temp. disable with holding Shift)
set winblend=10                       " Transparency for floating windows
set pumblend=10                       " Transparency for popup-menu
set scrolloff=10                      " Start scrolling 10 lines before edge of viewpoint
set pastetoggle=<F2>                  " Paste mode toggle to paste code properly
set guicursor=                        " Fix for mysterious 'q' letters
set completeopt=menu,menuone,noselect " Set completeopt to have a better completion experience
set shortmess+=c                      " don't give |ins-completion-menu| messages
set guifont=DejavuSansMono\ NF:h16    " Font
set updatetime=300                    " Faster completion (default is 4000)
set timeoutlen=500                    " Timeout for a mapped sequence to complete. (1000 ms by default)
" set cmdheight=2                       " More space for messages

" ==== Clipboard ====
" set clipboard=unnamedplus

" ==== Search ====
set incsearch
set nohlsearch
set ignorecase
set smartcase

" ==== Windows ====
set number
set relativenumber
set listchars=tab:\ ,trail:·,precedes:←,extends:→,space:·,eol:↲,nbsp:␣
" set list

" ==== Cursor ====
set cursorline                        " Highlight cursorline
set colorcolumn=80,100                " Add vertical lines on columns
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
  autocmd FileType toml         setlocal commentstring=#\ %s
  autocmd FileType terraform    setlocal commentstring=#\ %s

  autocmd FileType python       setlocal sw=4 ts=4
  autocmd FileType make         setlocal sw=4 ts=4 noet
  autocmd FileType jinja        setlocal sw=0
  autocmd FileType go           setlocal sw=8 ts=8 noet
augroup END

" Return to last edit position when opening files (You want this!)
function! s:RestoreCursor()
  let l:last_pos = line("'\"")
  if l:last_pos >= 1 && l:last_pos <= line('$')
    exe 'normal! g`"'
  endif
endfunction
autocmd BufReadPost * call s:RestoreCursor()

" Turning relativenumber on/off when changing window focus
autocmd TermOpen * setlocal nonumber norelativenumber | startinsert

" Notify if file is changed outside of vim
augroup auto_checktime
  autocmd!
  " Trigger `checktime` when files changes on disk
  " https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
  " https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
    \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

  " Notification after file change
  " https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
  autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
augroup END

" Allow files to be saved as root when forgetting to start Vim using sudo.
" https://www.youtube.com/watch?v=AcvxrF2MrrI
" https://www.youtube.com/watch?v=u1HgODpoijc
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
