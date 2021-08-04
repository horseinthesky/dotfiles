call plug#begin('~/.local/share/nvim/plugged')
" ==== Feature plugins ====
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'voldikss/vim-floaterm'
Plug 'dstein64/vim-startuptime'
Plug 'liuchengxu/vim-which-key'
Plug 'easymotion/vim-easymotion'
Plug 'mg979/vim-visual-multi'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'simnalamburt/vim-mundo'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'AndrewRadev/linediff.vim'

" ==== Visual plugins ====
Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-solarized8'
Plug 'chrisbra/Colorizer'
Plug 'ryanoasis/vim-devicons'
Plug 'machakann/vim-highlightedyank'
Plug 'yggdroot/indentline'
Plug 'blueyed/vim-diminactive'
Plug 'ntpeters/vim-better-whitespace'
Plug 'sheerun/vim-polyglot'

" ==== Statusline ====
Plug 'itchyny/lightline.vim'
call plug#end()

" ==== Plugin settings ====
" ==== ALE ====
" let g:ale_linters_explicit = 1
let g:ale_lint_on_text_changed = 'normal'
" `'always'`, `'1'`, or `1` - Check buffers on |TextChanged| or |TextChangedI|.
" `'normal'`            - Check buffers only on |TextChanged|.
" `'insert'`            - Check buffers only on |TextChangedI|.
" `'never'`, `'0'`, or `0`  - Never check buffers on changes.
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
let g:ale_python_flake8_options = '--max-line-length 160 --ignore=E402' " ignore import on top of the file
let g:ale_python_autopep8_options = '--max-line-length 160'
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

" ==== Fugitive ====
" conflict resolution
nnoremap <leader>gd :Gvdiffsplit!<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

" ==== Easymotion ====
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

nmap f <Plug>(easymotion-s)

" ==== vim-visual-multi ====
let g:VM_mouse_mappings = 1

" ==== linediff ====
map <leader>ld :Linediff<CR>
map <leader>lr :LinediffReset<CR>

" ==== mundo ====
nnoremap <F7> :MundoToggle<CR>
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
let g:fzf_colors = {
  \ 'hl':      ['fg', 'Search'],
  \ 'hl+':     ['fg', 'Search'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'pointer': ['fg', 'Statement'],
  \ 'marker':  ['fg', 'Special'],
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

" ==== utlisnips ====
" Trigger configuration.
let g:UltiSnipsExpandTrigger='<C-s>'
let g:UltiSnipsJumpForwardTrigger='Tab>'
let g:UltiSnipsJumpBackwardTrigger='<S-Tab>'

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" ==== floaterm ====
let g:floaterm_position = 'bottom'
let g:floaterm_width = 1.0
let g:floaterm_height = 0.5

let g:floaterm_keymap_toggle = '<F3>'
let g:floaterm_keymap_prev   = '<F5>'
let g:floaterm_keymap_next   = '<F6>'

nnoremap <F4> <cmd>FloatermNew python<CR>
tnoremap <F4> <cmd>FloatermNew python<CR>

" ==== coc ====
let g:coc_disable_startup_warning = 1

" Install CoC plugins
let g:coc_global_extensions = [
  \ 'coc-python',
  \ 'coc-vimlsp',
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
  \ 'coc-marketplace',
  \ ]

" Close NVIM if CoC Explorer is the only buffer opened
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

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
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Go to definition (Ctrl+^ for return)
nmap <silent> <leader>cd <Plug>(coc-definition)
" Open a list of references of an object in a split
nmap <silent> gr <Plug>(coc-references)

" Use gh to show documentation in preview window.
nnoremap <silent> gh :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Format using linters
command! -nargs=0 Format :call CocAction('format')
nnoremap <leader>F :call CocAction('format')<cr>

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')
nnoremap <leader>s :call CocAction('runCommand', 'editor.action.organizeImport')<CR>

" Add missing go imports on save
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
" Add tags in Golang files
autocmd FileType go nmap ctj :CocCommand go.tags.add json<cr>
autocmd FileType go nmap cty :CocCommand go.tags.add yaml<cr>
autocmd FileType go nmap ctx :CocCommand go.tags.add xml<cr>
autocmd FileType go nmap ctc :CocCommand go.tags.clear<cr>

" ================ Visual plugin settings ================
" ==== startify ====
let g:startify_files_number = 10
let g:startify_session_persistence = 1
let g:startify_bookmarks = [
  \ { 'v': '~/.config/nvim/init.vim' },
  \ { 'z': '~/.zshrc' },
\ ]
let g:startify_lists = [
  \ { 'type': 'bookmarks', 'header': ['   Bookmarks'] },
  \ { 'type': 'dir',       'header': ['   Recent files'] },
  \ { 'type': 'sessions',  'header': ['   Saved sessions'] },
\ ]

nnoremap <leader>ss <cmd>SSave!<CR>
nnoremap <leader>sl <cmd>SLoad!<CR>
nnoremap <leader>sc <cmd>SClose!<CR>
nnoremap <leader>sd <cmd>SDelete!<CR>

" ==== highlightedyank ====
let g:highlightedyank_highlight_duration = 100

" ==== Colorizer ====
map <leader>ct :ColorToggle<cr>
map <leader>cs :ColorSwapFgBg<cr>

" ==== better-whitespace ====
let g:better_whitespace_guicolor="#fb4934"
let g:better_whitespace_filetypes_blacklist = ['dashboard', 'packer']

nnoremap ]w :NextTrailingWhitespace<CR>
nnoremap [w :PrevTrailingWhitespace<CR>

" ==== indentline ====
let g:indentLine_fileTypeExclude = ['help', 'markdown', 'startify', 'json']
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" let g:indentLine_setColors = 0
let g:indentLine_color_term = 239

nnoremap <leader>I :IndentLinesToggle<CR>

" ==== diminactive ===
let g:diminactive_use_syntax = 1
