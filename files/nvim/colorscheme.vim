" Colors
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Colorscheme
set background=dark
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_invert_selection = 0

colorscheme gruvbox

" Transparency toggle
let g:is_transparent = 1
highlight Normal guibg=NONE ctermbg=NONE
highlight! default link VertSplit Normal
highlight SignColumn guibg=NONE ctermbg=NONE
highlight PmenuSel blend=0

function! ToggleTransparent()
  if g:is_transparent == 0
    highlight Normal guibg=NONE ctermbg=NONE
    highlight! default link VertSplit Normal
    highlight SignColumn guibg=NONE ctermbg=NONE
    highlight PmenuSel blend=0
    let g:is_transparent = 1
  else
    set background=dark
    let g:is_transparent = 0
  endif
endfunction

nnoremap <silent> <C-t> :call ToggleTransparent()<CR>
