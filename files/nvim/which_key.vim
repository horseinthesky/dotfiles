let g:which_key_use_floating_win = 0
let g:which_key_timeout = 100

" Change the colors if you want
highlight default link WhichKey          Special
highlight default link WhichKeySeperator String
highlight default link WhichKeyGroup     Number
highlight default link WhichKeyDesc      Identifier

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noruler
  \| autocmd BufLeave <buffer> set laststatus=2 ruler

" Map leader to which_key
nnoremap <silent> <leader> :silent <c-u> :silent WhichKey 'leader'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual 'leader'<CR>

" Create map to add keys to
let g:which_leader_map =  {}
let g:which_leader_map["'"] = ["'", 'horizontal split']
let g:which_leader_map[";"] = [';', 'vertical split']
let g:which_leader_map["`"] = ['', 'terminal']
let g:which_leader_map.d = ['', 'doge generate']
let g:which_leader_map.I = ['', 'indentline toggle']
let g:which_leader_map.T = ['', 'replace tabs']
let g:which_leader_map.W = ['', 'strip whitespaces']
let g:which_leader_map.v = ['', 'reselect pasted text']
let g:which_leader_map.R = ['', 'reload buffer']
let g:which_leader_map.F = ['', 'format']
let g:which_leader_map.i = ['', 'lsp info']
let g:which_leader_map.s = {
  \ 'name' : '+sessions',
  \ 'c' : ['SClose!', 'session close'],
  \ 'd' : ['SDelete!', 'session delete'],
  \ 'l' : ['SLoad!', 'session load'],
  \ 's' : ['SSave!', 'session save'],
\ }
let g:which_leader_map.b = {
  \ 'name' : '+buffers',
  \ 'd' : ['', 'delete buffer'],
  \ 'p' : ['', 'pick buffer'],
\ }
let g:which_leader_map.t = {
  \ 'name' : '+tabs',
  \ 't' : ['', 'new tab'],
  \ 'l' : ['', 'next tab'],
  \ 'h' : ['', 'previous tab'],
  \ 'j' : ['', 'last tab'],
  \ 'k' : ['', 'first tab'],
  \ 'c' : ['', 'close tab'],
  \ 'o' : ['', 'only this tab'],
  \ 'H' : ['', 'tab move left'],
  \ 'L' : ['', 'tab move right'],
  \ 'J' : ['', 'tab move first'],
  \ 'K' : ['', 'tab move last'],
\ }
let g:which_leader_map.q = {
  \ 'name' : '+quicklist',
  \ 'o' : ['', 'open quicklist'],
  \ 'c' : ['', 'close quicklist'],
\ }
let g:which_leader_map.l = {
  \ 'name' : '+loclist',
  \ 'o' : ['', 'open loclist'],
  \ 'c' : ['', 'close loclist'],
\ }
let g:which_leader_map.r = {
  \ 'name' : '+replace',
  \ 'r' : ['', 'replace all entries'],
  \ 'c' : ['', 'replace with confirmation'],
  \ 's' : ['', 'replace one entry'],
\ }
let g:which_leader_map.c = {
  \ 'name' : '+code',
  \ 'a' : ['', 'code action'],
  \ 'd' : ['', 'definition'],
  \ 'i' : ['', 'implementation'],
  \ 'h' : ['', 'hover'],
  \ 'r' : ['', 'rename'],
  \ 's' : ['', 'sinature help'],
  \ 'D' : ['', 'line diagnistics'],
  \ 'l' : ['', 'diagnostics to loclist'],
\ }
let g:which_leader_map.f = {
  \ 'name' : '+find',
  \ 'b' : ['', 'builtins'],
  \ 'f' : ['', 'files'],
  \ 'G' : ['', 'live grep'],
  \ 'w' : ['', 'word'],
  \ 'r' : ['', 'registers'],
  \ 's' : ['', 'search'],
  \ 'L' : ['', 'line'],
  \ 'm' : ['', 'marks'],
  \ 'M' : ['', 'keymaps'],
  \ 'o' : ['', 'options'],
  \ 'O' : ['', 'oldfiles'],
  \ 'c' : ['', 'comands'],
  \ 'a' : ['', 'autocommands'],
  \ 't' : ['', 'treesitter'],
  \ 'h' : ['', 'help'],
  \ 'B' : ['', 'buffers'],
  \ 'H' : ['', 'highlights'],
  \ 'C' : ['', 'colorscheme'],
  \ 'S' : ['', 'symbols'],
  \ 'g' : {
    \ 'name' : '+git' ,
    \ 'b' : ['', 'branches'],
    \ 'c' : ['', 'cimmits'],
    \ 's' : ['', 'status'],
  \ },
  \ 'l' : {
    \ 'name' : '+lsp' ,
    \ 'd' : ['', 'document diagnostics'],
    \ 'D' : ['', 'workspace diagnostics'],
    \ 's' : ['', 'document symbols'],
    \ 'S' : ['', 'workspace symbols'],
  \ },
\ }

" Register which key map
call which_key#register('leader', "g:which_leader_map")
