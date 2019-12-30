" ============= VIM-PLUG PLUGINS ================
" ==== FEATURE PLUGINS ====
call plug#begin('~/.local/share/nvim/plugged')
Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'matze/vim-move'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

" ==== VISUAL PLUGINS ====
" Plug 'edkolev/tmuxline.vim'
Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'lifepillar/vim-solarized8'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'yggdroot/indentline'
Plug 'luochen1990/rainbow'
Plug 'sheerun/vim-polyglot'
call plug#end()

" ================ SETTINGS ================
set laststatus=2     " Always show statusline
set t_Co=256         " Use 256 colours (Use this setting only if your terminal supports 256 colours)
set nobackup         " Don't create annoying backup files
set noswapfile       " Dont' use swapfile
set mouse=v          " Neovim mouse disable
set scrolloff=5      " Start scrolling 5 lines before edge of viewpoint
set pastetoggle=<F2> " Paste mode toggle to paste code properly
set guicursor=       " Fix for mysterious 'q' letters
set shortmess+=c     " don't give |ins-completion-menu| messages
" set cmdheight=2      " More space for messages
" set signcolumn=yes   " Always show signcolumns (left row)
set updatetime=300   " You will have bad experience for diagnostic messages when it's default 4000.

" ==== Folding ====
set foldmethod=indent   " Fold based on indent
set foldnestmax=10      " Deepest fold is 10 levels
set nofoldenable        " Dont fold by default
set foldlevel=2         " This is just what I use

" ==== File explorer ====
map <F3> :!ls<CR>:e
let g:netrw_banner=0 " diable annoying banner
let g:netrw_browse_split=4 " open in proir window
let g:netrw_altv=1 " open splits to the right
let g:netrw_liststyle=3 " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" ==== Numbers ====
set number
set relativenumber

" ==== File autoload ====
" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" ==== History ====
set history=100
set undolevels=100
set undofile
set undodir=$HOME/.config/nvim/tmp/undo

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
let g:ale_fix_on_save = 0
let g:ale_linters = {
  \ 'python': ['flake8'],
  \ 'go': ['gofmt'],
  \ 'yaml': ['yamllint']
  \ }
let g:ale_fixers = {
  \ 'python': ['autopep8'],
  \ 'go': ['gofmt'],
  \ '*': ['remove_trailing_lines', 'trim_whitespace']
  \ }
let g:ale_python_flake8_options = '--ignore=E501,E402,F401,E701' " ignore long-lines, import on top of the file, unused modules and statement with colon
let g:ale_python_autopep8_options = '--ignore=E501'              " ignore long-lines for autopep8 fixer
let g:ale_yaml_yamllint_options='-d "{extends: relaxed, rules: {line-length: disable}}"'

" let g:airline#extensions#ale#enabled = 1
let g:ale_sign_warning = "\uf421" "  
let g:ale_sign_error = "\uf658" "  
" let g:ale_sign_error = "\uf05e" "  
" let g:ale_sign_error = "\uf65b" "  
let g:ale_echo_msg_format = '[%linter%] %code%: %s'

" Navigate between errors
nmap <silent> [a <Plug>(ale_previous_wrap)
nmap <silent> ]a <Plug>(ale_next_wrap)

" ==== TagBar ====
nmap <F8> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_sort = 1

" ==== Fugitive ====
" conflict resolution ====
nnoremap <leader>gd :Gvdiffsplit!<CR>
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
let g:multi_cursor_select_all_word_key = '<C-M>'

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
map <C-p> :Rg<CR>

" Advanced Rg with preview window
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

" Advanced Files with preview window + bat
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(
    \ <q-args>, {
      \ 'options': [
        \ '--layout=reverse',
        \ '--info=inline',
        \ '--preview',
        \ '~/.local/share/nvim/plugged/fzf.vim/bin/preview.sh {}'
      \ ]
    \ }, <bang>0)

" ==== coc ====
" Install CoC plugins
let g:coc_global_extensions = [
  \ 'coc-python',
  \ 'coc-snippets',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-yaml',
  \ 'coc-css',
  \ 'coc-html',
  \ 'coc-emmet',
  \ 'coc-xml',
  \ 'coc-tabnine',
  \ 'coc-go',
  \ 'coc-explorer',
  \ 'coc-snippets',
  \ ]

" Open/close coc-explorer
nmap ge :CocCommand explorer<CR>

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<Tab>" :
  \ coc#refresh()

" Use <Tab> and <S-Tab> to navigate the completion list:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Use <cr> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" To make <cr> select the first completion item and confirm the completion when no item has been selected:
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" Navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Use <c-space>for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()
" Show CoC extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>

" Go to definition (Ctrl+6 for return)
nmap <silent> gd <Plug>(coc-definition)
" Format using linters
command! -nargs=0 Format :call CocAction('format')

" Add missing go imports on save
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
" Add tags in Golang files
autocmd FileType go nmap ctj :CocCommand go.tags.add json<cr>
autocmd FileType go nmap cty :CocCommand go.tags.add yaml<cr>
autocmd FileType go nmap ctx :CocCommand go.tags.add xml<cr>
autocmd FileType go nmap ctc :CocCommand go.tags.clear<cr>

" ================ VISUAL SETTINGS ================
" ==== rainbow ====
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" ==== Theme ====
set background=dark
let g:gruvbox_contrast_dark='soft'
colorscheme $NVIM_COLORSCHEME

" ==== NERDTree Syntax Highlight ====
" NERDTree highlight full file name (not only icons)
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

" NERDTree folder open and close icons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

" NERDTree lag mitigating
let g:NERDTreeLimitedSyntax = 1
"
" ==== lightline ====
let g:viewplugins = '__Tagbar__\|__Mundo__\|__Mundo_Preview__\|NERD_tree\|\[coc-explorer\]'

function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction

function! LightlineFugitive()       
  if exists('*fugitive#head')
    let branch = fugitive#head()
    return expand('%:t') =~# g:viewplugins ? '' :
      \ branch !=# '' ? ' '.branch : ''
  endif                      
  return ''                    
endfunction

function! LightlineModified()
  return &ft =~ 'help' ? '' : &modified ? '' : &modifiable ? '' : ''
endfunction

function! LightlineLineInfo()
  return expand('%:t') =~# g:viewplugins ? '' : printf(' %d:%-2d', line('.'), col('.'))
endfunction

function! LightlinePercent()
  return expand('%:t') =~# g:viewplugins ? '' : ('☰ ' . 100 * line('.') / line('$')) . '%'
endfunction

function! LighlineFileformat()
  return expand('%:t') =~# g:viewplugins ? '' :
    \ &fileencoding . ' ' . FileFormatIcon()
endfunction
function! FileFormatIcon()
  return strlen(&filetype) ? WebDevIconsGetFileFormatSymbol() : 'no ft'
endfunction

function! LightlineFilenameExtended() 
  let fticon = (strlen(&filetype) ? ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') 
  let filename = LightlineFilename()
  let modified = ModifiedStatus()
  if filename == ''
      return ''
  endif
  return expand('%:t') =~# g:viewplugins ? '' :
    \ join([filename, fticon, modified],'')
endfunction
function! LightlineFilename()
  let readonly = LightlineReadonly()
  return ('' != readonly ? readonly . ' ' : '') .
    \ ('' != expand('%:t') ? expand('%:t') : '')
endfunction
function! ModifiedStatus()
  let modified = LightlineModified()
  return ('' != modified ? ' ' . modified : '')
endfunction

function! LightlineTabFiletypeIcon(n)
  let fticon = WebDevIconsGetFileTypeSymbol()
  return fticon !=# '' ? fticon : ''
endfunction

function! LightlineMode()
  let fname = expand('%:t')
  return fname =~# '^__Tagbar__' ? 'Tagbar' :
    \ fname == '__Mundo__' ? 'Mundo' :
    \ fname == '__Mundo_Preview__' ? 'Mundo Preview' :
    \ fname =~ 'NERD_tree' ? 'NERDTree' :
    \ fname =~ '\[coc-explorer\]-' ? 'Explorer' :
    \ &ft == 'unite' ? 'Unite' :
    \ &ft == 'vimfiler' ? 'VimFiler' :
    \ &ft == 'vimshell' ? 'VimShell' :
    \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

let g:lightline = {
  \ 'colorscheme': 'gruvbox',
  \ 'active': {
  \   'left': [
  \     [ 'mode', 'paste' ],
  \     [ 'fugitive', 'filename' ]
  \   ],
  \   'right': [
  \     [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
  \     [ 'percent', 'lineinfo' ],
  \     ['fileformat'],
  \   ]
  \ },
  \ 'tabline': {
  \   'left': [['tabs']],
  \   'right': [],
  \ },
  \ 'tab': {
  \   'active': ['filename', 'fticon'],
  \   'inactive': ['tabnum', 'filename'],
  \ },
  \ 'component': {
  \   'lineinfo': ' %3l:%-2v%<',
  \   'percent': '☰ %3p%%',
  \ },
  \ 'component_function': {
  \   'fugitive': 'LightlineFugitive',
  \   'mode': 'LightlineMode',
  \   'fileformat': 'LighlineFileformat',
  \   'filename': 'LightlineFilenameExtended',
  \   'lineinfo': 'LightlineLineInfo',
  \   'percent': 'LightlinePercent',
  \ },
  \ 'tab_component_function': {
  \   'fticon': 'LightlineTabFiletypeIcon',
  \ },
  \ 'component_expand': {
  \   'tabs': 'lightline#tabs',
  \   'linter_checking': 'lightline#ale#checking',
  \   'linter_warnings': 'lightline#ale#warnings',
  \   'linter_errors': 'lightline#ale#errors',
  \   'linter_ok': 'lightline#ale#ok',
  \ },
  \ 'component_type': {
  \   'tabs': 'tabsel',
  \   'linter_checking': 'left',
  \   'linter_warnings': 'warning',
  \   'linter_errors': 'error',
  \   'linter_ok': 'raw'
  \ },
  \ 'separator': {
  \   'left': '',
  \   'right': ''
  \ },
  \ 'subseparator': {
  \   'left': '',
  \   'right': ''
  \ },
  \ 'tabline_separator': {
  \   'left': '',
  \   'right': ''
  \ },
  \ 'tabline_subseparator': {
  \   'left': '|',
  \   'right': ''
  \ },
\ }

let g:lightline#ale#indicator_checking = " "
let g:lightline#ale#indicator_warnings = " "
let g:lightline#ale#indicator_errors = " "
let g:lightline#ale#indicator_ok = " "
