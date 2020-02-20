let s:viewplugins = '__Tagbar__\|__vista__\|__Mundo__\|__Mundo_Preview__\|NERD_tree\|\[Plugins\]\|\[coc-explorer\]'

function! LightlineFugitive()       
  if exists('*fugitive#head')
    let l:branch = fugitive#head()
    return winwidth(0) > 55 ?
      \ expand('%:t') =~# s:viewplugins ? ''
        \ : l:branch !=# '' ? ' '.l:branch
          \ : ''
      \ : ''
  endif                      
  return ''                    
endfunction

function! LightlineLineInfo()
  return winwidth(0) > 60 ?
    \ expand('%:t') =~# s:viewplugins ? ''
      \ : printf(' %d:%-d', line('.'), col('.'))
    \ : ''
endfunction

function! LightlinePercent()
  return winwidth(0) > 65 ?
    \ expand('%:t') =~# s:viewplugins ? ''
      \ : '☰ ' . 100 * line('.') / line('$') . '%'
    \ : ''
endfunction

function! LighlineFileformat()
  return winwidth(0) > 70 ?
    \ expand('%:t') =~# s:viewplugins ? ''
      \ : &fileencoding . FileFormatIcon()
    \ : ''
endfunction
function! FileFormatIcon()
  return strlen(&filetype) ? ' ' . WebDevIconsGetFileFormatSymbol()
    \ : ' no ft'
endfunction

function! LightlineMode()
  let l:fname = expand('%:t')
  return l:fname =~# '^__Tagbar__' ? 'Tagbar'
    \ : l:fname == '__vista__' ? 'Vista'
    \ : l:fname == '__Mundo__' ? 'Mundo'
    \ : l:fname == '__Mundo_Preview__' ? 'Mundo Preview'
    \ : l:fname =~ 'NERD_tree' ? 'NERDTree'
    \ : l:fname =~ '\[Plugins\]' ? 'Plugins'
    \ : l:fname =~ '\[coc-explorer\]-' ? 'Explorer'
    \ : &ft == 'unite' ? 'Unite'
    \ : &ft == 'vimfiler' ? 'VimFiler'
    \ : &ft == 'vimshell' ? 'VimShell'
    \ : winwidth(0) > 50 ? lightline#mode()
    \ : ''
endfunction

function! LightlineFilenameExtended() 
  let l:fticon = (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() . ' ' : '') 
  let l:filename = LightlineFilename()
  let l:modified = LightlineModified()
  if l:filename == ''
      return ''
  endif
  return expand('%:t') =~# s:viewplugins ? '' :
    \ join([l:fticon, l:filename, l:modified],'')
endfunction
function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction
function! LightlineFilename()
  let l:readonly = LightlineReadonly()
  return ('' != l:readonly ? l:readonly . ' ' : '') .
    \ ('' != expand('%:t') ? expand('%:t') : '')
endfunction
function! LightlineModified()
  return &ft =~ 'help' ? '' : &modified ? ' ' : &modifiable ? '' : ' '
endfunction

function! LightlineTabFiletypeIcon(n)
  let l:fticon = WebDevIconsGetFileTypeSymbol()
  return l:fticon !=# '' ? l:fticon : ''
endfunction

function! LightlineTabname(n) abort
  let l:bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
  let l:fname = expand('#' . l:bufnr . ':t')
  return l:fname =~# '^__Tagbar__' ? 'Tagbar' :
    \ l:fname == '__Mundo__' ? 'Mundo' :
    \ l:fname == '__Mundo_Preview__' ? 'Mundo Preview' :
    \ l:fname =~ 'NERD_tree' ? 'NERDTree' :
    \ l:fname =~ '\[coc-explorer\]-' ? 'Explorer' :
    \ l:fname =~ '\[Plugins\]' ? 'Plugins' :
    \ ('' != l:fname ? l:fname : '[No Name]')
endfunction

" ALE statusline components
function! LightlineAleWarnings() abort
  if !LightlineAleLinted()
    return ''
  endif
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:all_non_errors == 0 ? '' : g:ale_sign_warning . ' ' . all_non_errors
endfunction

function! LightlineAleErrors() abort
  if !LightlineAleLinted()
    return ''
  endif
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  return l:all_errors == 0 ? '' : g:ale_sign_error . ' ' . all_errors
endfunction

function! LightlineAleOk() abort
  if !LightlineAleLinted()
    return ''
  endif
  let l:counts = ale#statusline#Count(bufnr(''))
  return l:counts.total == 0 ? ' ' : ''
endfunction

function! LightlineAleChecking() abort
  return ale#engine#IsCheckingBuffer(bufnr('')) ? ' ' : ''
endfunction

function! LightlineAleLinted() abort
  return get(g:, 'ale_enabled', 0) == 1
    \ && getbufvar(bufnr(''), 'ale_linted', 0) > 0
    \ && ale#engine#IsCheckingBuffer(bufnr('')) == 0
endfunction

" Autoupdate statusline
augroup LightLineOnALE
  autocmd!
  autocmd User ALEJobStarted call lightline#update()
  autocmd User ALELintPost call lightline#update()
  autocmd User ALEFixPost call lightline#update()
augroup end

let g:lightline = {
  \ 'colorscheme': $NVIM_COLORSCHEME,
  \ 'active': {
  \   'left': [
  \     [ 'mode', 'paste' ],
  \     [ 'fugitive', 'filename' ],
  \   ],
  \   'right': [
  \     [ 'linter_checking', 'linter_errors', 'linter_warnings', 'percent', 'lineinfo', 'linter_ok' ],
  \     [ 'fileformat' ],
  \   ]
  \ },
  \ 'tabline': {
  \   'left': [['tabs']],
  \   'right': [],
  \ },
  \ 'tab': {
  \   'active': ['fticon', 'filename',],
  \   'inactive': ['tabnum', 'filename'],
  \ },
  \ 'component': {
  \   'lineinfo': ' %3l/%L:%-2v%<',
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
  \   'filename': 'LightlineTabname',
  \ },
  \ 'component_expand': {
  \   'tabs': 'lightline#tabs',
  \   'linter_warnings': 'LightlineAleWarnings',
  \   'linter_errors': 'LightlineAleErrors',
  \   'linter_ok': 'LightlineAleOk',
  \   'linter_checking': 'LightlineAleChecking',
  \ },
  \ 'component_type': {
  \   'tabs': 'tabsel',
  \   'linter_warnings': 'warning',
  \   'linter_errors': 'error',
  \   'linter_ok': 'raw',
  \   'linter_checking': 'left',
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
