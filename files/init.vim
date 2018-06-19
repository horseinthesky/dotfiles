" ================ VIM-PLUG PLUGINS ================
" ==== PLUGINS ====
call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'w0rp/ale'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'mileszs/ack.vim'
Plug 'rosenfeld/conque-term'
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
Plug 'terryma/vim-multiple-cursors'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

" ==== VISUAL PLUGINS ====
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'yggdroot/indentline'
Plug 'sheerun/vim-polyglot'

call plug#end()

" ================ SETTINGS ================
set laststatus=2     " Always show statusline
set t_Co=256         " Use 256 colours (Use this setting only if your terminal supports 256 colours)
set nobackup         " Don't create annoying backup files
set noswapfile       " Dont' use swapfile
set mouse-=a         " Neovim mouse disable"
set scrolloff=5      " start scrolling 5 lines before edge of viewpoint
set pastetoggle=<F2> " Paste mode toggle to paste code properly
set guicursor=       " Fix for mysterious 'q' letters

function! BufNewFile_PY()
  0put = '#!/usr/bin/env python3'
  1put = '# -*- coding: utf-8 -*-'
  2put = ''
  normal G
endfunction
autocmd BufNewFile *.py call BufNewFile_PY()
autocmd BufNewFile *.pyw call BufNewFile_PY()

" ==== Numbers ====
set number
set relativenumber

" ==== SPLIT NAVIGATIONS ====
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" ==== TAB ====
set tabstop=2        " 4 whitespaces for tabs visual presentation
set shiftwidth=2     " shift lines by 4 spaces
set smarttab         " set tabs for a shifttabs logic
set expandtab        " expand tabs into spaces
set smartindent

if has('autocmd')
  filetype on
  augroup VimrcTabSettings
    autocmd!
    autocmd FileType yaml            set sw=2 ts=2
    autocmd FileType json            set sw=2 ts=2
    autocmd FileType vim             set sw=2 ts=2
    autocmd FileType python          set sw=4 ts=4
    autocmd FileType yang            set sw=2 ts=2
    autocmd BufRead, BufNewFile *.j2 set ft=jinja
    autocmd FileType jinja           set sw=2 ts=2
    augroup END
endif

" ==== SYNTAX AND SEARCH ====
syntax on

set cursorline               " highlight cursorline

set hlsearch
set incsearch
set nohlsearch

set ignorecase
set smartcase

" ================ PLUGINS CONFIG ================
" ==== ALE ====
" let g:ale_linters_explicit = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {
      \ 'python': ['flake8'],
      \ 'yaml': ['yamllint']
      \ }
let g:ale_fixers = {
      \ 'python': ['autopep8']
      \ }
let g:ale_python_flake8_options = '--ignore=E501,E402,F401' " ignore long-lines, import on top of the file and unused modules
let g:ale_python_autopep8_options = '--ignore=E501' " ignore long-lines for autopep8 fixer
let g:ale_yaml_yamllint_options='-d "{extends: relaxed, rules: {line-length: disable}}"'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_fix_on_save = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %code%: %s'

" ==== TagBar ====
nmap <F8> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" ==== NERDTREE ====
map <C-t> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$', '\.o$']
let NERDTreeShowHidden=1

" ==== Easymotion ====
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

nmap f <Plug>(easymotion-s)
nmap t <Plug>(easymotion-t)

" ==== (G)UNDO ====
set history=100
set undolevels=100

nnoremap <F7> :GundoToggle<CR>
let g:gundo_prefer_python3 = 1
let g:gundo_width = 60
let g:gundo_preview_height = 25
"let g:gundo_right = 1

set undofile
set undodir=$HOME/.config/nvim/tmp/undo

" ==== deoplete ====
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 1

" <TAB> completion
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" ==== Conque-Term ====
" запуск интерпретатора на F5
nnoremap <F5> :ConqueTermSplit ipython<CR>

" а debug-mode на <F6>
nnoremap <F6> :exe "ConqueTermSplit ipython " . expand("%")<CR>
let g:ConqueTerm_StartMessages = 0
let g:ConqueTerm_CloseOnEnd = 0

" ================ VISUAL SETTINGS ================
" ==== Theme ====
set background=dark
let g:gruvbox_contrast_dark='soft'
colorscheme gruvbox

" ==== NERDTree Syntax Highlight ====
" NERDTree highlight full file name (not oly icons)
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

" NERDTree folder open and close icons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

" ==== Airline ====
let g:airline_theme='powerlineish'
let g:airline_powerline_fonts = 1

" theme support for tab separators
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'
let airline#extensions#tabline#tabs_label = '' " don't show tab label on top left
let airline#extensions#tabline#show_splits = 0 " don't show buffer label on top right
" let g:airline_left_sep = ''
" let g:airline_right_sep = ''
