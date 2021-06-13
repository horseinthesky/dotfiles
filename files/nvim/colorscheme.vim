" Colors
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Colorscheme
set background=dark
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_invert_selection = 0

colorscheme gruvbox
highlight PmenuSel blend=0
highlight SignColumn guibg=NONE

" Transparency toggle
let g:original_normal_bg = synIDattr(hlID("Normal"), "bg")
let g:is_transparent = 0

function! ToggleTransparent()
  if g:is_transparent == 0
    highlight Normal guibg=None
    let g:is_transparent = 1
  else
    " set background=dark
    exe 'highlight Normal guibg=' . g:original_normal_bg
    let g:is_transparent = 0
  endif
endfunction

nnoremap <silent> <C-t> :call ToggleTransparent()<CR>
