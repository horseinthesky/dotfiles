local utils = require "config.utils"

local colorscheme = vim.g.theme

local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
  utils.error("colorscheme: " .. colorscheme .. " not found")
  return
end
