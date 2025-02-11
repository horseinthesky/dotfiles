local M = {}

-- General
function M.wide_enough(width)
  if vim.fn.winwidth(0) > width then
    return true
  end
  return false
end

function M.buffer_not_empty()
  if vim.fn.empty(vim.fn.expand "%:t") ~= 1 then
    return true
  end
  return false
end

-- Icons
M.icons = {
  dos = "", -- e70f
  unix = "", -- f17c
  mac = "", -- f179
  code = "", -- e000
  dot = "", -- f111
  duck = "󰇥 ", -- f01e5
  page = "☰", -- 2630
  arrow = "", -- e285
  play_arrow = "", -- e602
  line_number = "", -- e0a1
  connected = "󰌘", -- f0318
  disconnected = "󰌙", -- f0319
  gears = "", -- f085
  poop = "💩", -- 1f4a9
  question = "", -- f128
  bug = "", -- f188
  git = {
    logo = "󰊢", -- f02a2
    branch = "", -- e725
  },
  square = {
    plus = "", -- f0f
    minus = "", --f146
    dot = "", --f264
  },
  circle = {
    plus = "", -- f055
    minus = "", --f056
    dot = "", -- f28d
  },
  file = {
    locked = "", -- f023
    not_modifiable = "", -- f05e
    unsaved = "", -- f0c7
    modified = "", -- f040
  },
  diagnostic = {
    ok = "", -- f058
    error = "", -- f057
    warning = "", -- f06a
    info = "", -- f05a
    -- hint = "󰌵", -- f0335
    hint = "", -- f059
  },
  sep = {
    right_filled = "", -- e0b6
    left_filled = "", -- e0b4
    -- right_filled = " ", -- e0ca
    -- left_filled = " ", -- e0c8
    -- right_filled = "", -- e0b2
    -- left_filled = "", -- e0b0
    -- right = "", -- e0b3
    -- left = "", -- e0b1
    -- right = "", -- e0b7
    -- left = "", -- e0b5
    right = "", -- e621
    left = "", -- e621
  },
}

-- LSP & Diagnostics
function M.get_lsp_clients()
  local buf_client_names = {}

  for _, client in pairs(vim.lsp.get_clients { bufnr = vim.api.nvim_get_current_buf() }) do
    local client_name = string.match(client.name, "(.-)_.*") or string.match(client.name, "(.-)-.*") or client.name

    table.insert(buf_client_names, client_name)
  end

  return table.concat(buf_client_names, ", ")
end

function M.diagnostic_exists()
  return not vim.tbl_isempty(vim.lsp.get_clients { bufnr = vim.api.nvim_get_current_buf() })
end

local diag_map = {
  [vim.diagnostic.severity.ERROR] = M.icons.diagnostic.error,
  [vim.diagnostic.severity.WARN] = M.icons.diagnostic.warning,
  [vim.diagnostic.severity.INFO] = M.icons.diagnostic.info,
  [vim.diagnostic.severity.HINT] = M.icons.diagnostic.hint,
}

function M.if_diagnostic_ok()
  local e = M.get_diagnostic_by_severity(vim.diagnostic.severity.ERROR)
  local w = M.get_diagnostic_by_severity(vim.diagnostic.severity.WARN)
  local i = M.get_diagnostic_by_severity(vim.diagnostic.severity.INFO)
  local h = M.get_diagnostic_by_severity(vim.diagnostic.severity.HINT)

  if #w ~= 0 or #e ~= 0 or #i ~= 0 or #h ~= 0 then
    return ""
  end

  return M.icons.diagnostic.ok
end

function M.get_diagnostic_by_severity(severity)
  local count = vim.diagnostic.get(0, { severity = severity })

  if #count == 0 then
    return ""
  end

  return string.format(" %s %d", diag_map[severity], #count)
end

function M.get_diagnostic_all()
  local count = vim.diagnostic.count(0)
  if #count == 0 then
    return M.icons.diagnostic.ok
  end

  local res = ""
  for severity_idx, icon in ipairs(diag_map) do
    local severity_diag = count[severity_idx] or 0
    if severity_diag > 0 then
      res = res .. string.format(" %s %d", icon, severity_diag)
    end
  end

  return res
end

-- Colors
local gruvbox = {
  gray = "#928374",
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
  faded_orange = "#af3a03",
  dark = {
    bg = "#282828",
    bg0_h = "#1d2021",
    bg0 = "#282828",
    bg1 = "#3c3836",
    bg2 = "#504945",
    bg3 = "#665c54",
    bg4 = "#7c6f64",
    fg0 = "#fbf1c7",
    fg1 = "#ebdbb2",
    fg2 = "#d5c4a1",
    fg3 = "#bdae93",
    fg4 = "#a89984",
  },
  light = {
    bg = "#fbf1c7",
    bg0_h = "#f9f5d7",
    bg0 = "#fbf1c7",
    bg1 = "#ebdbb2",
    bg2 = "#d5c4a1",
    bg3 = "#bdae93",
    bg4 = "#a89984",
    fg0 = "#282828",
    fg1 = "#3c3836",
    fg2 = "#504945",
    fg3 = "#665c54",
    fg4 = "#7c6f64",
  },
}

local tokyonight = {
  none = "NONE",
  bg_highlight = "#292e42",
  fg_gutter = "#3b4261",
  dark3 = "#545c7e",
  dark5 = "#737aa2",
  comment = "#565f89",
  blue0 = "#3d59a1",
  blue1 = "#2ac3de",
  blue2 = "#0db9d7",
  blue5 = "#89ddff",
  blue6 = "#b4f9f8",
  blue7 = "#394b70",
  cyan = "#7dcfff",
  purple = "#9d7cd8",
  teal = "#1abc9c",
  red = "#f7768e",
  red1 = "#db4b4b",
  dark = {
    blue = "#7aa2f7",
    red = "#db4b4b",
    green = "#9ece6a",
    orange = "#ff9e64",
    yellow = "#e0af68",
    magenta = "#bb9af7",
    fg = "#a9b1d6",
    bg0 = "#1f2335",
    bg = "#414868",
  },
  light = {
    blue = "#2e7de9",
    red = "#db4b4b",
    green = "#41a6b5",
    orange = "#be7f3c",
    yellow = "#965027",
    magenta = "#ba3c97",
    fg = "#a9b1d6",
    bg0 = "#d4d6e4",
    bg = "#a9b1d6",
  },
}

local color_map = {
  gruvbox = {
    dark = {
      n = { gruvbox.dark.fg3, gruvbox.dark.bg2 },
      i = { gruvbox.bright_blue, gruvbox.faded_blue },
      ic = { gruvbox.bright_blue, gruvbox.faded_blue },
      R = { gruvbox.bright_red, gruvbox.faded_red },
      v = { gruvbox.bright_orange, gruvbox.faded_orange },
      V = { gruvbox.bright_orange, gruvbox.faded_orange },
      c = { gruvbox.bright_yellow, gruvbox.faded_yellow },
      s = { gruvbox.bright_orange, gruvbox.faded_orange },
      S = { gruvbox.bright_orange, gruvbox.faded_orange },
      t = { gruvbox.bright_aqua, gruvbox.faded_aqua },
      nt = { gruvbox.dark.fg3, gruvbox.dark.bg2 },
      ["\22"] = { gruvbox.bright_orange, gruvbox.faded_orange },
      ["\19"] = { gruvbox.bright_orange, gruvbox.faded_orange },
      substrate = gruvbox.dark.bg1,
      git_icon = gruvbox.bright_orange,
      git_branch = gruvbox.dark.fg2,
      diff_add = gruvbox.bright_green,
      diff_modified = gruvbox.bright_orange,
      diff_remove = gruvbox.bright_red,
      lsp_icon = gruvbox.bright_purple,
      lsp_name = gruvbox.dark.fg4,
      ok = gruvbox.bright_green,
      error = gruvbox.bright_red,
      warn = gruvbox.bright_yellow,
      info = gruvbox.bright_blue,
      hint = gruvbox.bright_aqua,
    },
    light = {
      n = { gruvbox.light.fg3, gruvbox.light.bg2 },
      i = { gruvbox.bright_blue, gruvbox.neutral_blue },
      ic = { gruvbox.bright_blue, gruvbox.neutral_blue },
      R = { gruvbox.bright_red, gruvbox.neutral_red },
      v = { gruvbox.bright_orange, gruvbox.neutral_orange },
      V = { gruvbox.bright_orange, gruvbox.neutral_orange },
      c = { gruvbox.bright_yellow, gruvbox.neutral_yellow },
      s = { gruvbox.bright_orange, gruvbox.neutral_orange },
      S = { gruvbox.bright_orange, gruvbox.neutral_orange },
      t = { gruvbox.bright_aqua, gruvbox.neutral_aqua },
      nt = { gruvbox.light.fg3, gruvbox.light.bg2 },
      ["\22"] = { gruvbox.bright_orange, gruvbox.neutral_orange },
      ["\19"] = { gruvbox.bright_orange, gruvbox.neutral_orange },
      substrate = gruvbox.light.bg1,
      git_icon = gruvbox.neutral_orange,
      git_branch = gruvbox.light.fg2,
      diff_add = gruvbox.neutral_green,
      diff_modified = gruvbox.neutral_orange,
      diff_remove = gruvbox.neutral_red,
      lsp_icon = gruvbox.neutral_purple,
      lsp_name = gruvbox.light.fg4,
      ok = gruvbox.neutral_green,
      error = gruvbox.neutral_red,
      warn = gruvbox.neutral_yellow,
      info = gruvbox.neutral_blue,
      hint = gruvbox.neutral_aqua,
    },
  },
  tokyonight = {
    dark = {
      n = { tokyonight.dark.blue, tokyonight.dark.bg },
      i = { tokyonight.dark.green, tokyonight.dark.bg },
      ic = { tokyonight.dark.green, tokyonight.dark.bg },
      R = { tokyonight.dark.red, tokyonight.dark.bg },
      v = { tokyonight.dark.orange, tokyonight.dark.bg },
      V = { tokyonight.dark.orange, tokyonight.dark.bg },
      c = { tokyonight.dark.yellow, tokyonight.dark.bg },
      s = { tokyonight.dark.orange, tokyonight.dark.bg },
      S = { tokyonight.dark.orange, tokyonight.dark.bg },
      t = { tokyonight.blue7, tokyonight.dark.bg },
      nt = { tokyonight.dark.blue, tokyonight.dark.bg },
      ["\22"] = { tokyonight.dark.orange, tokyonight.dark.bg },
      ["\19"] = { tokyonight.dark.blue, tokyonight.dark.bg },
      substrate = tokyonight.dark.bg0,
      git_icon = tokyonight.dark.orange,
      git_branch = tokyonight.dark.fg,
      diff_add = tokyonight.dark.green,
      diff_modified = tokyonight.dark.orange,
      diff_remove = tokyonight.dark.red,
      lsp_icon = tokyonight.dark.magenta,
      lsp_name = tokyonight.dark.fg,
      ok = tokyonight.dark.green,
      error = tokyonight.dark.red,
      warn = tokyonight.dark.yellow,
      info = tokyonight.blue2,
      hint = tokyonight.teal,
    },
    light = {
      n = { tokyonight.light.blue, tokyonight.light.bg },
      i = { tokyonight.light.green, tokyonight.light.bg },
      ic = { tokyonight.light.green, tokyonight.light.bg },
      R = { tokyonight.light.red, tokyonight.light.bg },
      v = { tokyonight.light.orange, tokyonight.light.bg },
      V = { tokyonight.light.orange, tokyonight.light.bg },
      c = { tokyonight.light.yellow, tokyonight.light.bg },
      s = { tokyonight.light.orange, tokyonight.light.bg },
      S = { tokyonight.light.orange, tokyonight.light.bg },
      t = { tokyonight.light.blue, tokyonight.light.bg },
      nt = { tokyonight.light.blue, tokyonight.light.bg },
      ["\22"] = { tokyonight.light.orange, tokyonight.light.bg },
      ["\19"] = { tokyonight.light.blue, tokyonight.light.bg },
      substrate = tokyonight.light.bg0,
      git_icon = tokyonight.light.orange,
      git_branch = tokyonight.light.fg,
      diff_add = tokyonight.light.green,
      diff_modified = tokyonight.light.orange,
      diff_remove = tokyonight.light.red,
      lsp_icon = tokyonight.light.magenta,
      lsp_name = tokyonight.light.fg,
      ok = tokyonight.light.green,
      error = tokyonight.light.red,
      warn = tokyonight.light.yellow,
      info = tokyonight.light.blue,
      hint = tokyonight.teal,
    },
  },
}

for _, table in pairs(color_map) do
  for _, subtable in pairs(table) do
    setmetatable(subtable, {
      __index = function()
        return subtable.n
      end,
    })
  end
end

local theme_map = color_map[vim.g.theme] or color_map["gruvbox"]

M.colors = theme_map[vim.opt.background:get()] or theme_map["dark"]

return M
