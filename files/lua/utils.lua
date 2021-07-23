local M = {}

function M.map(mode, key, action, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, key, action, options)
end

-- TODO: rewrite to `nvim_set_hl()` when API will be stable
-- https://github.com/kraftwerk28/dotfiles/blob/master/.config/nvim/lua/utils.lua#L119
function M.highlight(cfg)
  local fg, bg = cfg.fg or cfg[2], cfg.bg or cfg[3]
  local _gui, _guisp = cfg.gui or cfg[4], cfg.guisp or cfg[5]
  local guifg = fg and " guifg=" .. fg or ""
  local guibg = bg and " guibg=" .. bg or ""
  local gui = _gui and " gui=" .. _gui or ""
  local guisp = _guisp and " guisp=" .. _guisp or ""
  vim.cmd("highlight " .. cfg[1] .. guifg .. guibg .. gui .. guisp)
end

M.icons = {
  dos = "", -- e70f
  unix = "", -- f17c
  mac = "", -- f179
  paste = "", -- f691
  circle = "", -- f62e
  git = "", -- f7a1
  branch = "", -- f418
  added = "", -- f457
  removed = "", --f458
  modified = "", --f459
  locker = "", -- f023
  not_modifiable = "", -- f05e
  unsaved = "", -- f0c7
  pencil = "", -- f040
  page = "☰", -- 2630
  line_number = "", -- e0a1
  connected = "", -- f817
  disconnected = "", -- f818
  gears = "", -- f085
  poop = "💩", -- 1f4a9
  ok = "", -- f058
  error = "", -- f658
  warning = "", -- f06a
  info = "", -- f05a
  -- hint = "", -- f834
  hint = "" -- f059
}

-- Gruvbox
M.colors = {
  bg0_h = "#1d2021",
  bg0 = "#282828",
  bg1 = "#3c3836",
  bg2 = "#504945",
  bg3 = "#665c54",
  bg4 = "#7c6f64",
  gray = "#928374",
  fg0 = "#fbf1c7",
  fg1 = "#ebdbb2",
  fg2 = "#d5c4a1",
  fg3 = "#bdae93",
  fg4 = "#a89984",
  bright_red = "#fb4934",
  bright_green = "#b8bb26",
  bright_yellow = "#fabd2f",
  bright_blue = "#83a598",
  bright_purple = "#d3869b",
  bright_aqua = "#8ec07c",
  bright_orange = "#fe8019",
  neutral_red = "#cc241d",
  neutral_green = "#98971a",
  neutral_yellow = "#d79921",
  neutral_blue = "#458588",
  neutral_purple = "#b16286",
  neutral_aqua = "#689d6a",
  neutral_orange = "#d65d0e",
  faded_red = "#9d0006",
  faded_green = "#79740e",
  faded_yellow = "#b57614",
  faded_blue = "#076678",
  faded_purple = "#8f3f71",
  faded_aqua = "#427b58",
  faded_orange = "#af3a03"
}

return M
