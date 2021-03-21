local utils = require('utils')

-- Colors
utils.opt('termguicolors', true)
vim.api.nvim_exec([[
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
]], false)

-- Colorscheme
utils.opt('background', 'dark')
vim.g.gruvbox_contrast_dark='medium'
vim.g.gruvbox_invert_selection = 0

vim.cmd 'colorscheme gruvbox'

-- Transparency toggle
vim.g.is_transparent = 1
vim.cmd 'highlight Normal guibg=NONE ctermbg=NONE'

vim.api.nvim_exec([[
  function! ToggleTransparent()
  if g:is_transparent == 0
    highlight Normal guibg=NONE ctermbg=NONE
    let g:is_transparent = 1
  else
    set background=dark
    let g:is_transparent = 0
  endif
  endfunction
]], false)

utils.map('n', '<C-t>', '<cmd>call ToggleTransparent()<CR>', {silent = true})
