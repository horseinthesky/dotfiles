local map = require("utils").map

-- Colors
vim.opt.termguicolors = true

vim.api.nvim_exec(
  [[
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  ]],
  false
)

-- Colorscheme
vim.opt.background = "dark"
vim.g.gruvbox_contrast_dark = "medium"
vim.g.gruvbox_invert_selection = 0
vim.g.tokyonight_style = "storm"

local colorscheme = "gruvbox"

local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
  vim.cmd [[highlight Normal guibg=#282828]]
  error("colorscheme: " .. colorscheme .. " not found")
end

vim.cmd [[highlight SignColumn guibg=NONE]]
vim.cmd [[highlight link NormalFloat Normal]]

-- Transparency toggle
vim.g.original_normal_bg = vim.fn.synIDattr(vim.fn.hlID "Normal", "bg")
vim.g.is_transparent = 0

_G.toggle_transparent = function()
  if vim.g.is_transparent == 0 then
    vim.cmd [[highlight Normal guibg=None]]
    vim.g.is_transparent = 1
  else
    vim.cmd("highlight Normal guibg=" .. vim.g.original_normal_bg)
    vim.g.is_transparent = 0
  end
end

map("n", "<C-t>", toggle_transparent, { silent = true })
