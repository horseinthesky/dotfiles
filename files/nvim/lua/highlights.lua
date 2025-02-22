local utils = require "utils"

local colorscheme = vim.g.theme
local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
  utils.error("colorscheme: " .. colorscheme .. " not found")
  return
end

-- Transparency toggle
local non_transparent_params = {}
local is_transparent = false

local function toggle_transparent()
  if is_transparent then
    vim.api.nvim_set_hl(0, "Normal", { bg = non_transparent_params.bg })
    is_transparent = false
    return
  end

  non_transparent_params = vim.api.nvim_get_hl(0, { name = "Normal", link = false })

  vim.api.nvim_set_hl(0, "Normal", {
    bg = nil,
  })
  is_transparent = true
end

utils.map("n", "<C-t>", toggle_transparent, { silent = true })

-- Highlight trailing whitespaces
local config = {
  highlight = "Error",
  ignored_filetypes = {
    "help",
    "checkhealth",
    "alpha",
    "lazy",
    "TelescopePrompt",
    "crates.nvim",
  },
  ignore_terminal = true,
}

local function highlight_trailing_whitespaces()
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
      highlight_trailing_whitespaces()
    end)
  end,
})
