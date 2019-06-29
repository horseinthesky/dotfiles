" ================ VIM-PLUG PLUGINS ================
" ==== PLUGINS ====
call plug#begin('~/.local/share/nvim/plugged')
Plug 'Valloric/YouCompleteMe' , { 'do': 'python3 install.py --clang-completer' }
Plug 'w0rp/ale'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'matze/vim-move'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'mileszs/ack.vim'
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
Plug 'simnalamburt/vim-mundo'
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
set mouse=v          " Neovim mouse disable
set scrolloff=5      " start scrolling 5 lines before edge of viewpoint
set pastetoggle=<F2> " Paste mode toggle to paste code properly
set guicursor=       " Fix for mysterious 'q' letters

" ==== Numbers ====
set number
set relativenumber

" ==== History ====
set history=100
set undolevels=100
set undofile
set undodir=$HOME/.config/nvim/tmp/undo

" ==== Add shebang to new python files ====
function! BufNewFile_PY()
  0put = '#!/usr/bin/env python3'
  1put = '# -*- coding: utf-8 -*-'
  2put = ''
  normal G
endfunction
autocmd BufNewFile *.py call BufNewFile_PY()
autocmd BufNewFile *.pyw call BufNewFile_PY()

" ==== SPLIT NAVIGATIONS ====
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" ==== TAB ====
set tabstop=2        " 2 whitespaces for tabs visual presentation
set shiftwidth=2     " shift lines by 2 spaces
set smarttab         " set tabs for a shifttabs logic
set expandtab        " expand tabs into spaces
set smartindent

" Change TAB key behavior base on filetype
if has('autocmd')
  filetype on
  augroup VimrcTabSettings
    autocmd!
    autocmd FileType python setlocal sw=4 ts=4
    autocmd FileType go     setlocal sw=8 ts=8 noet
  augroup END
endif

" ==== SYNTAX AND SEARCH ====
syntax on
set cursorline       " highlight cursorline
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
      \ 'go': ['gofmt'],
      \ 'yaml': ['yamllint']
      \ }
let g:ale_fixers = {
      \ 'python': ['autopep8'],
      \ 'go': ['gofmt']
      \ }
let g:ale_python_flake8_options = '--ignore=E501,E402,F401,E701' " ignore long-lines, import on top of the file, unused modules and statement with colon
let g:ale_python_autopep8_options = '--ignore=E501'              " ignore long-lines for autopep8 fixer
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
let g:tagbar_autoclose = 1
let g:tagbar_sort = 1

" ==== Fugitive Conflict Resolution ====
nnoremap <leader>gd :Gvdiff<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

" ==== NERDTREE ====
map <C-t> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$', '\.o$']
let NERDTreeShowHidden=1

" ==== Easymotion ====
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

nmap f <Plug>(easymotion-s)
nmap t <Plug>(easymotion-t)

" ==== vim-move ====
let g:move_key_modifier = 'S'

" ==== vim-multiple-cursors ====
let g:multi_cursor_select_all_word_key = '<S-n>'

" ==== mundo ====
nnoremap <F7> :MundoToggle<CR>
let g:mundo_prefer_python3 = 1
let g:mundo_width = 25
let g:mundo_preview_bottom = 1
let g:mundo_close_on_revert = 1
" let g:mundo_preview_height = 25
" let g:mundo_right = 1

" ==== fzf ====
map ; :Files<CR>

" no vim statusline when fzf is opened
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" ==== YouCompeteMe settings ====
set completeopt-=preview
let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_auto_trigger = 0

" ==== deoplete ====
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 1

" <TAB> completion for deoplete
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

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

" NERDTree lag mitigating
let g:NERDTreeLimitedSyntax = 1

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
