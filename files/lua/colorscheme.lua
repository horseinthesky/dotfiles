local utils = require("utils")

-- Colors
utils.opt("termguicolors", true)
vim.api.nvim_exec([[
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
]], false)

-- Colorscheme
utils.opt("background", "dark")
vim.g.gruvbox_contrast_dark = "medium"
vim.g.gruvbox_invert_selection = 0

vim.cmd "colorscheme gruvbox"

-- Transparency toggle
vim.g.is_transparent = 1
vim.api.nvim_exec(
  [[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE ctermbg=NONE
]],
  false
)

vim.api.nvim_exec(
  [[
  function! ToggleTransparent()
  if g:is_transparent == 0
    highlight Normal guibg=NONE ctermbg=NONE
    highlight SignColumn guibg=NONE ctermbg=NONE
    highlight LspDiagnosticsDefaultInformation ctermfg=109 guifg=#83a598
    highlight LspDiagnosticsDefaultHint ctermfg=109 guifg=#fbf1c7
    highlight LspDiagnosticsDefaultError ctermfg=167 guifg=#fb4934
    highlight LspDiagnosticsDefaultWarning ctermfg=214 guifg=#fabd2f
    let g:is_transparent = 1
  else
    set background=dark
    highlight SignColumn guibg=NONE ctermbg=NONE
    highlight LspDiagnosticsDefaultInformation ctermfg=109 guifg=#83a598
    highlight LspDiagnosticsDefaultHint ctermfg=109 guifg=#fbf1c7
    highlight LspDiagnosticsDefaultError ctermfg=167 guifg=#fb4934
    highlight LspDiagnosticsDefaultWarning ctermfg=214 guifg=#fabd2f
    let g:is_transparent = 0
  endif
  endfunction
]],
  false
)

utils.map("n", "<C-t>", "<cmd>call ToggleTransparent()<CR>", {silent = true})
