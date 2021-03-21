let $CONFIG_DIR = expand('$HOME/dotfiles/files/nvim/')

" ==== Stable config ====
if !has('nvim-0.5')
  source $CONFIG_DIR/setup.vim
endif

" ==== Nightly config ====
if has('nvim-0.5')
  runtime! packer/packer_compiled.vim
  lua require 'setup'
endif

call which_key#register('<leader>', 'g:which_key_map')
nnoremap <silent> <leader> :<c-u>WhichKey '<leader>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<leader>'<CR>
let g:which_key_use_floating_win = 0
let g:which_key_max_size = 0
let g:which_key_timeout = 100
let g:which_key_display_names = {'<CR>': '↵', '<TAB>': '⇆'}

autocmd! FileType which_key
autocmd FileType which_key set laststatus=0 | autocmd BufLeave <buffer> set laststatus=2

let g:which_key_map =  {}
let g:which_key_map["'"] = [ '<C-W>s', 'split below']
let g:which_key_map.s = {
  \ 'name' : '+sessions',
  \ 'c' : ['SClose!' , 'close session'],
  \ 'd' : ['SDelete!', 'delete session'],
  \ 'l' : ['SLoad!', 'load session'],
  \ 's' : ['SSave!', 'save session'],
\ }

" let g:which_key_map['<leader>'] = {
"       \ 'name' : '+windows' ,
"       \ "'" : ["<leader>'"  , 'new horizontal split']  ,
"       \ 'w' : ['<C-W>w'     , 'other-window']          ,
"       \ 'd' : ['<C-W>c'     , 'delete-window']         ,
"       \ '-' : ['<C-W>s'     , 'split-window-below']    ,
"       \ '|' : ['<C-W>v'     , 'split-window-right']    ,
"       \ '2' : ['<C-W>v'     , 'layout-double-columns'] ,
"       \ 'h' : ['<C-W>h'     , 'window-left']           ,
"       \ 'j' : ['<C-W>j'     , 'window-below']          ,
"       \ 'l' : ['<C-W>l'     , 'window-right']          ,
"       \ 'k' : ['<C-W>k'     , 'window-up']             ,
"       \ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
"       \ 'J' : [':resize +5'  , 'expand-window-below']   ,
"       \ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
"       \ 'K' : [':resize -5'  , 'expand-window-up']      ,
"       \ '=' : ['<C-W>='     , 'balance-window']        ,
"       \ 's' : ['<C-W>s'     , 'split-window-below']    ,
"       \ 'v' : ['<C-W>v'     , 'split-window-below']    ,
"       \ '?' : ['Windows'    , 'fzf-window']            ,
"       \ }

" ======== Autocommands ========
augroup auto_checktime
  autocmd!
  " Notify if file is changed outside of vim
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

" Turning relativenumer on/off when changing window focus
" autocmd BufEnter,Winenter,FocusGained * if &l:filetype == 'startuptime' | setlocal nonumber, norelativenumber | endif
autocmd FileType startuptime setlocal nonumber norelativenumber
autocmd TermOpen * setlocal nonumber norelativenumber | startinsert

let g:disable_line_numbers = [
  \ 'NvimTree', 'help', 'list', 'startuptime',
  \ 'startify', 'TelescopePrompt', 'Mundo',
\ ]

function! s:SetNumber(set)
  if empty(&filetype) || index(g:disable_line_numbers, &filetype) > -1
    return
  endif
  if a:set
    setlocal relativenumber
  else
    setlocal norelativenumber
  endif
endfunction

augroup line_numbers
  autocmd!
  autocmd BufEnter,Winenter,FocusGained * call s:SetNumber(1)
  autocmd BufLeave,Winleave,FocusLost * call s:SetNumber(0)
augroup END

" Return to last edit position when opening files (You want this!)
function! s:RestoreCursor()
  let l:last_pos = line("'\"")
  if l:last_pos > 0 && l:last_pos <= line('$')
    exe 'normal! g`"'
  endif
endfunction
autocmd BufReadPost * call s:RestoreCursor()

" ==== Abbreviations ====
" adds a shebang taken from the filetype
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
