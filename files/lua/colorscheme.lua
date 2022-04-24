local utils = require "utils"

vim.opt.termguicolors = true
vim.opt.background = "dark"

local colorscheme = vim.g.theme

local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
  utils.error("colorscheme: " .. colorscheme .. " not found")
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

utils.map("n", "<C-t>", toggle_transparent, { silent = true })
