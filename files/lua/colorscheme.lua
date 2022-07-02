local utils = require "utils"

-- Colorscheme options
vim.opt.termguicolors = true
vim.opt.background = "dark"

local colorscheme = vim.g.theme

local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
  utils.error("colorscheme: " .. colorscheme .. " not found")
  return
end

-- Colors fix
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "SignColumn", {})

-- Transparency toggle
vim.g.original_normal_bg = vim.fn.synIDattr(vim.api.nvim_get_hl_id_by_name "Normal", "bg")
vim.g.original_normal_fg = vim.fn.synIDattr(vim.api.nvim_get_hl_id_by_name "Normal", "fg")

vim.g.is_transparent = 0

local function toggle_transparent()
  if vim.g.is_transparent == 0 then
    vim.api.nvim_set_hl(0, "Normal", {
      fg = vim.g.original_normal_fg,
      bg = nil,
    })
    vim.g.is_transparent = 1
  else
    vim.api.nvim_set_hl(0, "Normal", {
      fg = vim.g.original_normal_fg,
      bg = vim.g.original_normal_bg,
    })
    vim.g.is_transparent = 0
  end
end

utils.map("n", "<C-t>", toggle_transparent, { silent = true })
