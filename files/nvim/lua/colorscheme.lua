local utils = require "config.utils"

local colorscheme = vim.g.theme

local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
  utils.error(string.format("colorscheme '%s' not found", colorscheme))
  return
end
