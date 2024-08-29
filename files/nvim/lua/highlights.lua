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
vim.api.nvim_set_hl(0, "Delimiter", { link = "Special" })
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

-- Trailing whitespaces
local config = {
  highlight = "Error",
  ignored_filetypes = {
    "help",
    "lspinfo",
    "alpha",
    "lazy",
    "TelescopePrompt",
    "crates.nvim",
  },
  ignore_terminal = true,
}

local function highlight()
  if not vim.fn.hlexists(config.highlight) then
    utils.error(string.format("highlight group %s does not exist", config.highlight))
    return
  end

  if config.ignore_terminal and vim.bo.buftype == "terminal" then
    return
  end

  if vim.tbl_contains(config.ignored_filetypes, vim.bo.filetype) then
    return
  end

  local command = string.format([[match %s /\s\+$/]], config.highlight)
  vim.cmd(command)
end

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.schedule(function()
      highlight()
    end)
  end,
})
