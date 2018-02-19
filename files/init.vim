" ================ VIM-PLUG PLUGINS ================
" ==== PLUGINS ====
call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'jiangmiao/auto-pairs'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'rking/ag.vim'
Plug 'rosenfeld/conque-term'
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
Plug 'vim-syntastic/syntastic'
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-multiple-cursors'
Plug 'sjl/gundo.vim'
Plug 'lepture/vim-jinja'

" ==== VISUAL PLUGINS ====
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons' 
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

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

function! s:Visual()
  return visualmode() == 'V'
endfunction

function! s:Move(address, at_limit)
  if s:Visual() && !a:at_limit
    execute "'<,'>move " . a:address
    call feedkeys('gv=', 'n')
  endif
  call feedkeys('gv', 'n')
endfunction

function! Move_Up() abort range
  let l:at_top=a:firstline == 1
  call s:Move("'<-2", l:at_top)
endfunction

function! Move_Down() abort range
  let l:at_bottom=a:lastline == line('$')
  call s:Move("'>+1", l:at_bottom)
endfunction

" Move VISUAL LINE selection within buffer.
xnoremap <silent> K :call Move_Up()<CR>
xnoremap <silent> J :call Move_Down()<CR>

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
" ==== TagBar ====
nmap <F8> :TagbarToggle<CR>
let g:tagbar_autofocus = 1 

" ==== NERDTREE ====
map <C-t> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$', '\.o$']
let NERDTreeShowHidden=1

" ==== NERD Commenter ====
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" ==== Easymotion ====
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

nmap f <Plug>(easymotion-s)
nmap t <Plug>(easymotion-t)

" ==== Syntastic ====
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height=1
let g:syntastic_aggregate_errors = 1 

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_python_checkers = [ 'flake8' ] " 'pylint', 'pycodestyle', 'pep8', 'pyflakes', 'python']
let g:syntastic_python_flake8_args = '--ignore="E501"' " ignore long lines
let g:syntastic_yaml_checkers = ['yamlxs']

" Better :sign interface symbols
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'

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
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : deoplete#manual_complete()

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
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'

" let g:airline_left_sep = ''
" let g:airline_right_sep = ''
