" ============= VIM-PLUG PLUGINS ================
" ==== FEATURE PLUGINS ====
call plug#begin('~/.local/share/nvim/plugged')
Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'matze/vim-move'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
Plug 'liuchengxu/vista.vim'
Plug 'simnalamburt/vim-mundo'
Plug 'kkoomen/vim-doge'

" ==== VISUAL PLUGINS ====
Plug 'chrisbra/Colorizer'
Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-solarized8'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'yggdroot/indentline'
Plug 'blueyed/vim-diminactive'
Plug 'sheerun/vim-polyglot'
call plug#end()

" ================ SETTINGS ================
set laststatus=2       " Always show statusline
set t_Co=256           " Use 256 colours (Use this setting only if your terminal supports 256 colours)
set nobackup           " Don't create annoying backup files
set noswapfile         " Dont' use swapfile
set mouse=v            " Neovim mouse disable
set scrolloff=5        " Start scrolling 5 lines before edge of viewpoint
set pastetoggle=<F2>   " Paste mode toggle to paste code properly
set guicursor=         " Fix for mysterious 'q' letters
set shortmess+=c       " don't give |ins-completion-menu| messages
" set cmdheight=2      " More space for messages
" set signcolumn=yes   " Always show signcolumns (left row)
set updatetime=300     " You will have bad experience for diagnostic messages when it's default 4000.
set colorcolumn=80,120 " add vertical lines on columns

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Replace all tabs with 4 whitespaces
nnoremap <leader>T :%s/\t/    /g<CR>

" Strip all trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Reselect the text that was just pasted
nnoremap <leader>v V`]

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" ==== Folding ====
set foldmethod=indent  " Fold based on indent
set foldnestmax=10     " Deepest fold is 10 levels
set nofoldenable       " Dont fold by default
set foldlevel=2        " This is just what I use

" ==== File explorer ====
map <F3> :!ls<CR>:e
let g:netrw_banner=0                           " diable annoying banner
let g:netrw_browse_split=4                     " open in proir window
let g:netrw_altv=1                             " open splits to the right
let g:netrw_liststyle=3                        " tree view
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

" ==== SPLITS ====
set splitbelow splitright " new horizontal split to appear below and vertical split to appear on the right

" Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Split resizing
nnoremap <silent> <C-Left> :vertical resize +3<CR>
nnoremap <silent> <C-Right> :vertical resize -3<CR>
nnoremap <silent> <C-Up> :resize +3<CR>
nnoremap <silent> <C-Down> :resize -3<CR>

" ==== TAB ====
" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm0 :tabmove 0<cr>
map <leader>tm :tabmove $<cr>
map <leader>tl :tabnext<cr>
map <leader>th :tabprevious<cr>

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
let g:ale_lint_on_text_changed = 'normal'
" `'always'`, `'1'`, or `1` - Check buffers on |TextChanged| or |TextChangedI|.
" `'normal'`            - Check buffers only on |TextChanged|.
" `'insert'`            - Check buffers only on |TextChangedI|.
" `'never'`, `'0'`, or `0`  - Never check buffers on changes.
"
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
" let g:ale_sign_warning = "\uf421" "  
" let g:ale_sign_error = "\uf05e" "  
" let g:ale_sign_warning = "\uf12a" " 
" let g:ale_sign_error = "\uf00d" "  
let g:ale_sign_warning = "\uf06a" "  
let g:ale_sign_error = "\uf658" "  
let g:ale_echo_msg_format = '[%linter%] %code%: %s'

" Navigate between errors
nmap <silent> [a <Plug>(ale_previous_wrap)
nmap <silent> ]a <Plug>(ale_next_wrap)

" ==== TagBar ====
nmap <F8> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_sort = 1

" ==== Vista ====
nnoremap <F7> :Vista!!<CR>
let g:vista#renderer#enable_icon = 1
let g:vista_default_executive = 'coc'
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#icons = {
  \   "function": "\uf794",
  \   "variable": "\uf71b",
  \  }

" ==== Fugitive ====
" conflict resolution
nnoremap <leader>gd :Gvdiffsplit!<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

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
nnoremap <F5> :MundoToggle<CR>
let g:mundo_prefer_python3 = 1
let g:mundo_width = 25
let g:mundo_preview_bottom = 1
let g:mundo_close_on_revert = 1
" let g:mundo_preview_height = 25
" let g:mundo_right = 1

" ==== doge ====
" Runs on <leader>d and TAB/S-TAB for jumping TODOs
let g:doge_doc_standard_python = 'google'

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
  \ 'coc-translator',
  \ 'coc-marketplace',
  \ ]

" coc-translator settings
" popup
nmap <Leader>t <Plug>(coc-translator-p)
" echo
nmap <Leader>e <Plug>(coc-translator-e)
" replace
nmap <Leader>r <Plug>(coc-translator-r)

" Open/close coc-explorer
nmap ge :CocCommand explorer<CR>

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>d  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>s  :<C-u>CocList outline<cr>
" Open CoC marketplace
nnoremap <silent> <space>m  :<C-u>CocList marketplace<cr>

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Go to definition (Ctrl+^ for return)
nmap <silent> gd <Plug>(coc-definition)
" Open a list of references of an object in a split
nmap <silent> gr <Plug>(coc-references)

" Use gh - get hint - to show documentation in preview window.
nnoremap <silent> gh :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Format using linters
command! -nargs=0 Format :call CocAction('format')
nnoremap <leader>f :call CocAction('format')<cr>
" Formatting selected code.
xmap <leader>fs <Plug>(coc-format-selected)
nmap <leader>fs <Plug>(coc-format-selected)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" `:SI` command for organize imports of the current buffer.
command! -nargs=0 SI :call CocAction('runCommand', 'editor.action.organizeImport')
nnoremap <leader>s :call CocAction('runCommand', 'editor.action.organizeImport')<CR>

" Add missing go imports on save
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
" Add tags in Golang files
autocmd FileType go nmap ctj :CocCommand go.tags.add json<cr>
autocmd FileType go nmap cty :CocCommand go.tags.add yaml<cr>
autocmd FileType go nmap ctx :CocCommand go.tags.add xml<cr>
autocmd FileType go nmap ctc :CocCommand go.tags.clear<cr>

" ================ VISUAL SETTINGS ================
" ==== Colorizer
map <leader>ct :ColorToggle<cr>
map <leader>cs :ColorSwapFgBg<cr>

" ==== indentline ====
let g:indentLine_fileTypeExclude = ['tagbar']
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" let g:indentLine_setColors = 0
let g:indentLine_color_term = 239

" ==== Theme ====
set background=dark
let g:gruvbox_contrast_dark='soft'
colorscheme $NVIM_COLORSCHEME

" ==== diminactive ===
let g:diminactive_use_syntax = 1

" ==== lightline ====
source ~/dotfiles/files/lightline.vim
