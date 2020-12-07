" ============= VIM-PLUG PLUGINS ================
" ==== FEATURE PLUGINS ====
call plug#begin('~/.local/share/nvim/plugged')
Plug 'dense-analysis/ale'
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
Plug 'AndrewRadev/sideways.vim'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'will133/vim-dirdiff'
Plug 'AndrewRadev/linediff.vim'

" ==== VISUAL PLUGINS ====
Plug 'chrisbra/Colorizer'
Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-solarized8'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'yggdroot/indentline'
Plug 'machakann/vim-highlightedyank'
Plug 'blueyed/vim-diminactive'
Plug 'dhruvasagar/vim-zoom'
Plug 'ntpeters/vim-better-whitespace'
Plug 'sheerun/vim-polyglot'
call plug#end()

" ================ SETTINGS ================
" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

if has("nvim")
  set inccommand=split " incremental substitution shows substituted text before applying
endif
set laststatus=2       " Always show statusline
set nobackup           " Don't create annoying backup files
set noswapfile         " Dont' use swapfile
set iskeyword+=-       " treat dash separated words as a word text object
set mouse=v            " Neovim mouse disable
set scrolloff=5        " Start scrolling 5 lines before edge of viewpoint
set pastetoggle=<F2>   " Paste mode toggle to paste code properly
set noshowmode         " We don't need to see things like -- INSERT -- anymore
set guicursor=         " Fix for mysterious 'q' letters
set shortmess+=c       " don't give |ins-completion-menu| messages
" set cmdheight=2      " More space for messages
" set signcolumn=yes   " Always show signcolumns (left row)
set updatetime=300     " Faster completion (default is 4000)
set timeoutlen=500     " By default timeoutlen is 1000 ms
set colorcolumn=80,120 " add vertical lines on columns

autocmd FileType * set formatoptions-=o " Stop newline continution of comments

let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:python3_host_prog = '/usr/bin/python3'

" ==== Numbers ====
set number
set relativenumber

" ==== Folding ====
set foldmethod=indent  " Fold based on indent
set foldnestmax=10     " Deepest fold is 10 levels
set nofoldenable       " Dont fold by default
set foldlevel=2        " This is just what I use

" ==== History ====
set history=100
set undolevels=100
set undofile
set undodir=$HOME/.config/nvim/tmp/undo

" ==== SYNTAX AND SEARCH ====
syntax on
set cursorline         " highlight cursorline
set incsearch
set nohlsearch
set ignorecase
set smartcase

" ==== SPLITS ====
nnoremap <leader>; :vsplit n<CR>
nnoremap <leader>' :split n<CR>

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

" ==== TABS ====
set showtabline=1    " show tabs only when 2 or more open

" Buffers
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" <tab> / <s-tab> | Circular windows navigation
nnoremap <tab> :tabn<cr>
nnoremap <S-tab> :tabp<cr>

" Useful mappings for managing tabs
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>
nnoremap <leader>tl :tabnext<cr>
nnoremap <leader>th :tabprevious<cr>

nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>to :tabonly<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>tm0 :tabmove 0<cr>
nnoremap <leader>tm :tabmove $<cr>

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
    autocmd FileType python       setlocal sw=4 ts=4
    autocmd FileType jinja        setlocal sw=0
    autocmd FileType go           setlocal sw=8 ts=8 noet
  augroup END
endif

" ==== Bindings ====
" Reload init.vim
nnoremap <leader>r :source ~/dotfiles/files/init.vim<cr>

" Alternate way to save
nnoremap <C-s> :w<CR>
" Alternate way to quit
nnoremap <C-Q> :wq!<CR>

"gp selects code that was just pasted in the visual mode last used
nnoremap <expr> gp  '`[' . strpart(getregtype(), 0, 1) . '`]'

" Press * to search for the term under the cursor and then press a key below
" to replace all instances of it in the current file.
" Second binding is for comfirmation.
nnoremap <leader>rr :%s///g<Left><Left>
nnoremap <leader>rc :%s///gc<Left><Left><Left>

" The same as above but instead of acting on the whole file it will be
" restricted to the previously visually selected range. You can do that by
" pressing *, visually selecting the range you want it to apply to and then
" press a key below to replace all instances of it in the current selection.
xnoremap <Leader>rr :s///g<Left><Left>
xnoremap <Leader>rc :s///gc<Left><Left><Left>

" Press key below on the word or on visual selection and type a replacement term.
" Press . to repeat the replacement again. Useful
" for replacing a few instances of the term (comparable to multiple cursors).
nnoremap <leader>rs :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <leader>rs "sy:let @/=@s<CR>cgn

" Replace all tabs with 4 whitespaces
nnoremap <leader>T :%s/\t/    /g<CR>

" Strip all trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Reselect the text that was just pasted
nnoremap <leader>v V`]

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" ==== Terminal ====
tnoremap <expr> <esc> &filetype == 'fzf' ? "\<esc>" : "\<c-\>\<c-n>"

" ==== Abbreviations ====
" no one is really happy until you have this shortcuts
inoreabbrev <expr> #!! "#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" ==== File autoload ====
" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" ==== File explorer ====
" type :Explore
map <F3> :!ls<CR>:e
let g:netrw_banner=0                           " diable annoying banner
let g:netrw_browse_split=4                     " open in proir window
let g:netrw_altv=1                             " open splits to the right
let g:netrw_liststyle=3                        " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

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
  \ 'sh': ['shellcheck'],
  \ 'python': ['flake8'],
  \ 'go': ['gofmt'],
  \ 'yaml': ['yamllint'],
  \ 'javascript': ['eslint']
  \ }
let g:ale_fixers = {
  \ 'python': ['autopep8'],
  \ 'go': ['gofmt'],
  \ 'javascript': ['prettier', 'eslint'],
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

" ==== vim-commentary ====
autocmd BufRead,BufNewFile *.conf setlocal filetype=config
autocmd BufRead,BufNewFile *.cfg setlocal filetype=config
autocmd FileType config setlocal commentstring=#\ %s

" ==== linediff ====
map <leader>ld :Linediff<CR>
map <leader>lr :LinediffReset<CR>

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

" ==== sideways ====
nnoremap <leader>h :SidewaysLeft<cr>
nnoremap <leader>l :SidewaysRight<cr>

" ==== fzf ====
let g:fzf_colors = {
  \ 'hl':      ['fg', 'Search'],
  \ 'hl+':     ['fg', 'Search'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
\ }

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
\ }

let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.5, 'yoffset': 1 } }

nnoremap ; :Files<CR>
nnoremap <C-p> :Rg<CR>
nnoremap <leader>bl :BLines<CR>
nnoremap <leader>m :Maps<CR>
nnoremap <leader>co :Commands<CR>

" Hide statusline
autocmd! FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

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
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" ==== coc ====
let g:coc_disable_startup_warning = 1
" Install CoC plugins
let g:coc_global_extensions = [
  \ 'coc-python',
  \ 'coc-snippets',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-html',
  \ 'coc-yaml',
  \ 'coc-css',
  \ 'coc-emmet',
  \ 'coc-tabnine',
  \ 'coc-tsserver',
  \ 'coc-go',
  \ 'coc-explorer',
  \ 'coc-translator',
  \ 'coc-marketplace',
  \ ]

" coc-translator settings
" popup
nmap <Leader>tp <Plug>(coc-translator-p)
" echo
nmap <Leader>te <Plug>(coc-translator-e)
" replace
" nmap <Leader>r <Plug>(coc-translator-r)

" Search a word across whole project
" https://www.youtube.com/watch?v=q7gr6s8skt0
" CocSearch uses rg under the hood so it is possible to use options
" :CocSearch <regex> -A 20
" All matches are presented in one buffer. Once changed, all files changed
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>

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

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

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
" ==== highlightedyank ====
let g:highlightedyank_highlight_duration = 100

" ==== Colorizer ====
map <leader>ct :ColorToggle<cr>
map <leader>cs :ColorSwapFgBg<cr>

" ==== better-whitespace ====
let g:better_whitespace_ctermcolor=167
nnoremap ]w :NextTrailingWhitespace<CR>
nnoremap [w :PrevTrailingWhitespace<CR>

" ==== indentline ====
let g:indentLine_fileTypeExclude = ['tagbar', 'markdown']
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" let g:indentLine_setColors = 0
let g:indentLine_color_term = 239

" ==== Theme ====
set background=dark
let g:gruvbox_contrast_dark='soft'
let g:gruvbox_invert_selection='0'
colorscheme $NVIM_COLORSCHEME

" ==== diminactive ===
let g:diminactive_use_syntax = 1

" ==== lightline ====
if filereadable(expand("~/dotfiles/files/lightline.vim"))
  source ~/dotfiles/files/lightline.vim
endif
