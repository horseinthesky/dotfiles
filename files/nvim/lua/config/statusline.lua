local icons = require "config.utils".icons

local M = {}

-- Highlights
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
    },
  },
  ["tokyonight-storm"] = {
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
    },
  },
}

-- Return gruvbox colors if colorscheme not found
setmetatable(color_map, {
  __index = function()
    return color_map.gruvbox
  end,
})

-- Return dark colors if background not found
for _, table in pairs(color_map) do
  setmetatable(table, {
    __index = function()
      return table.dark
    end,
  })

  -- Return normal mode colors if mode not found
  for _, subtable in pairs(table) do
    setmetatable(subtable, {
      __index = function()
        return subtable.n
      end,
    })
  end
end

local last_colorscheme = ""

-- Define independent statusline colors
local function update_colorscheme_highlights()
  local current_colorscheme = vim.g.colors_name
  if current_colorscheme == last_colorscheme then
    return
  end

  vim.api.nvim_set_hl(0, "SignColumn", {})
  vim.api.nvim_set_hl(0, "NormalFloat", {})
  vim.api.nvim_set_hl(0, "FloatTitle", { link = "Normal" })

  vim.api.nvim_set_hl(0, "GitSignsAdd", {
    fg = nil,
    bg = vim.api.nvim_get_hl(0, { name = "DiagnosticOk", link = false }).fg,
  })
  vim.api.nvim_set_hl(0, "GitSignsChange", {
    fg = nil,
    bg = vim.api.nvim_get_hl(0, { name = "DiagnosticWarn", link = false }).fg,
  })
  vim.api.nvim_set_hl(0, "GitSignsDelete", {
    fg = nil,
    bg = vim.api.nvim_get_hl(0, { name = "DiagnosticError", link = false }).fg,
  })

  local bottom_bg = vim.api.nvim_get_hl(0, { name = "ColorColumn", link = false }).bg

  vim.api.nvim_set_hl(0, "StatusLineBottom", {
    fg = vim.api.nvim_get_hl(0, { name = "WinBar", link = false }).fg,
    bg = bottom_bg,
  })
  vim.api.nvim_set_hl(0, "StatusLineGitIcon", {
    fg = vim.api.nvim_get_hl(0, { name = "Operator", link = false }).fg,
    bg = bottom_bg,
  })
  vim.api.nvim_set_hl(0, "StatusLineGitDiffAdd", {
    fg = vim.api.nvim_get_hl(0, { name = "DiagnosticOk", link = false }).fg,
    bg = bottom_bg,
  })
  vim.api.nvim_set_hl(0, "StatusLineGitDiffChange", {
    fg = vim.api.nvim_get_hl(0, { name = "DiagnosticWarn", link = false }).fg,
    bg = bottom_bg,
  })
  vim.api.nvim_set_hl(0, "StatusLineGitDiffDelete", {
    fg = vim.api.nvim_get_hl(0, { name = "DiagnosticError", link = false }).fg,
    bg = bottom_bg,
  })
  vim.api.nvim_set_hl(0, "StatusLineLspIcon", {
    fg = vim.api.nvim_get_hl(0, { name = "Constant", link = false }).fg,
    bg = bottom_bg,
  })
  vim.api.nvim_set_hl(0, "StatusLineDiagnosticOk", {
    fg = vim.api.nvim_get_hl(0, { name = "DiagnosticOk", link = false }).fg,
    bg = bottom_bg,
  })
  vim.api.nvim_set_hl(0, "StatusLineDiagnosticError", {
    fg = vim.api.nvim_get_hl(0, { name = "DiagnosticError", link = false }).fg,
    bg = bottom_bg,
  })
  vim.api.nvim_set_hl(0, "StatusLineDiagnosticWarn", {
    fg = vim.api.nvim_get_hl(0, { name = "DiagnosticWarn", link = false }).fg,
    bg = bottom_bg,
  })
  vim.api.nvim_set_hl(0, "StatusLineDiagnosticInfo", {
    fg = vim.api.nvim_get_hl(0, { name = "DiagnosticInfo", link = false }).fg,
    bg = bottom_bg,
  })
  vim.api.nvim_set_hl(0, "StatusLineDiagnosticHint", {
    fg = vim.api.nvim_get_hl(0, { name = "DiagnosticHint", link = false }).fg,
    bg = bottom_bg,
  })

  last_colorscheme = current_colorscheme
end

local function get_colors()
  return color_map[vim.g.colors_name][vim.opt.background:get()]
end

local last_mode = ""

local function update_mode_highlights()
  local current_mode = vim.api.nvim_get_mode().mode
  if current_mode == last_mode then
    return
  end

  local fg, bg = unpack(get_colors()[current_mode])

  vim.api.nvim_set_hl(0, "StatusLineTop", { fg = bg, bg = fg })
  vim.api.nvim_set_hl(0, "StatusLineTopSep", { fg = fg, bg = bg })
  vim.api.nvim_set_hl(0, "StatusLineMiddle", { fg = fg, bg = bg })
  vim.api.nvim_set_hl(0, "StatusLineMiddleSep", {
    fg = bg,
    bg = vim.api.nvim_get_hl(0, { name = "ColorColumn", link = false }).bg,
  })

  last_mode = current_mode
end

---Output the content colored by the supplied highlight group.
---@param hl_group string
---@param content string
---@return string
local function colorize(hl_group, content)
  -- Use %* (%%* escaped) suffix to reset highlight group.
  return string.format("%%#%s#%s", hl_group, content)
end

-- Conditions
local function buffer_not_empty()
  if vim.fn.empty(vim.fn.expand "%:t") ~= 1 then
    return true
  end

  return false
end

local function wide_enough(width)
  if vim.fn.winwidth(0) > width then
    return true
  end

  return false
end

local function git_info_exists()
  return vim.b.gitsigns_head or vim.b.gitsigns_status_dict
end

local function diagnostic_exists()
  return not vim.tbl_isempty(vim.lsp.get_clients { bufnr = vim.api.nvim_get_current_buf() })
end

-- Mode
local mode_map = {
  n = { "󰋜", "NORMAL" },
  i = { "", "INSERT" },
  ic = { "", "INSERT" },
  R = { "", "REPLACE" },
  v = { "󰆏", "VISUAL" },
  V = { "󰆏", "V-LINE" },
  c = { "󰞷", "COMMAND" },
  s = { "󰆏", "SELECT" },
  S = { "󰆏", "S-LINE" },
  t = { "", "TERMINAL" },
  nt = { "", "TERMINAL" },
  ["\22"] = { "󰆏", "V-BLOCK" },
  ["\19"] = { "󰆏", "S-BLOCK" },
}

setmetatable(mode_map, {
  __index = function()
    return { icons.question, vim.api.nvim_get_mode().mode }
  end,
})

local function get_mode()
  local icon, label = unpack(mode_map[vim.api.nvim_get_mode().mode])
  local mode = icon

  if wide_enough(75) then
    mode = mode .. " " .. label
  end

  return " " .. mode .. " "
end

-- Git
local git_diff_params = {
  { "added",   icons.circle.plus,  "StatusLineGitDiffAdd" },
  { "changed", icons.circle.dot,   "StatusLineGitDiffChange" },
  { "removed", icons.circle.minus, "StatusLineGitDiffDelete" },
}

local function git_diff()
  local gsd = vim.b.gitsigns_status_dict

  local res = ""
  for _, group in ipairs(git_diff_params) do
    local type, icon, hl = unpack(group)
    local val = gsd[type] or 0

    if val > 0 then
      res = res .. colorize(hl, string.format(" " .. icon .. " " .. val))
    end
  end

  return res
end

-- LSP
local function get_lsp_clients()
  local buf_client_names = {}

  for _, client in pairs(vim.lsp.get_clients { bufnr = vim.api.nvim_get_current_buf() }) do
    local client_name = string.match(client.name, "(.-)_.*")
        or string.match(client.name, "(.-)-.*")
        or client.name

    table.insert(buf_client_names, client_name)
  end

  return table.concat(buf_client_names, ", ")
end

-- Diagnostic
local function diagnostic_ok()
  local count = vim.diagnostic.count(0)
  if #count ~= 0 then
    return ""
  end

  return icons.diagnostic.ok
end

local diag_severity_to_icon_map = {
  [vim.diagnostic.severity.ERROR] = icons.diagnostic.error,
  [vim.diagnostic.severity.WARN] = icons.diagnostic.warning,
  [vim.diagnostic.severity.INFO] = icons.diagnostic.info,
  [vim.diagnostic.severity.HINT] = icons.diagnostic.hint,
}

local diag_params = {
  { vim.diagnostic.severity.ERROR, icons.diagnostic.error,   "StatusLineDiagnosticError" },
  { vim.diagnostic.severity.WARN,  icons.diagnostic.warning, "StatusLineDiagnosticWarn" },
  { vim.diagnostic.severity.INFO,  icons.diagnostic.info,    "StatusLineDiagnosticInfo" },
  { vim.diagnostic.severity.HINT,  icons.diagnostic.hint,    "StatusLineDiagnosticHint" },
}

local function get_diagnostic_by_severity(severity)
  local count = vim.diagnostic.get(0, { severity = severity })

  if #count == 0 then
    return ""
  end

  return string.format(" %s %d", diag_severity_to_icon_map[severity], #count)
end

local function get_diagnostic_all()
  local count = vim.diagnostic.count(0)
  if vim.tbl_count(count) == 0 then
    return colorize("StatusLineDiagnosticOk", icons.diagnostic.ok .. " ")
  end

  local res = ""
  for _, group in ipairs(diag_params) do
    local severity, icon, hl = unpack(group)
    local severity_diag = count[severity] or 0

    if severity_diag > 0 then
      res = res .. colorize(hl, string.format(" %s %d", icon, severity_diag))
    end
  end

  return res
end

-- Statusline
local function build(sections)
  local built = {}

  for _, section in ipairs(sections) do
    if section.cond and not section.cond() then
      goto continue
    end

    -- Handle string components
    if type(section) == "string" then
      table.insert(built, section)
      goto continue
    end

    -- Handle table components
    local provider = section[1]
    local element = type(provider) == "string" and provider or provider()

    if type(section.hl) == "string" then
      element = colorize(section.hl, element)
    end

    table.insert(built, element)

    ::continue::
  end

  return built
end

local comps = {
  mode = {
    get_mode,
    hl = "StatusLineTop",
    cond = buffer_not_empty,
  },
  file = {
    icon = {
      function()
        local fname = vim.fn.expand "%:t"
        local extension = vim.fn.expand "%:e"
        local icon, _ = require("nvim-web-devicons").get_icon_color(fname, extension, { default = true })

        return " " .. icon
      end,
      cond = buffer_not_empty,
      hl = "StatusLineMiddle",
    },
    name = {
      function()
        if vim.bo.buftype == "terminal" then
          return ""
        end

        local fname = vim.fn.expand "%:t"
        if #fname == 0 then
          return ""
        end

        if wide_enough(140) then
          local full_fname = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.")
          if #full_fname < 35 then
            fname = full_fname
          end
        end

        if vim.bo.readonly then
          fname = fname .. " " .. icons.file.locked
        end
        if not vim.bo.modifiable then
          fname = fname .. " " .. icons.file.not_modifiable
        end
        if vim.bo.modified then
          fname = fname .. " " .. icons.file.modified
        end

        return " " .. fname .. " "
      end,
      cond = buffer_not_empty,
      hl = "StatusLineMiddle",
    },
    format = {
      function()
        local icon = icons[vim.bo.fileformat] or ""

        return string.format(" %s %s ", icon, vim.bo.fileencoding)
      end,
      hl = "StatusLineMiddle",
      cond = function()
        return buffer_not_empty() and wide_enough(100)
      end,
    },
    position = {
      function()
        return string.format(" %s %s:%s ", icons.line_number, unpack(vim.api.nvim_win_get_cursor(0)))
      end,
      hl = "StatusLineTop",
      cond = function()
        return buffer_not_empty() and wide_enough(80)
      end,
    },
    percentage = {
      function()
        local curr_line = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_line_count(0)

        return icons.sep.right .. string.format(" %s %d%%%% ", icons.page, math.floor(100 * curr_line / lines))
      end,
      hl = "StatusLineTop",
      cond = function()
        return buffer_not_empty() and wide_enough(90)
      end,
    },
  },
  sep = {
    left = {
      icons.sep.left_filled,
      hl = "StatusLineTopSep",
    },
    left_nested = {
      icons.sep.left_filled,
      hl = "StatusLineMiddleSep",
    },
    middle = {
      "%=",
      hl = "StatusLineBottom",
    },
    right = {
      icons.sep.right_filled,
      hl = "StatusLineTopSep",
    },
    right_nested = {
      " " .. icons.sep.right_filled,
      hl = "StatusLineMiddleSep",
    },
  },
  git = {
    icon = {
      " " .. icons.git.branch,
      hl = "StatusLineGitIcon",
      cond = function()
        return git_info_exists() and wide_enough(60)
      end,
    },
    branch = {
      function()
        return " " .. vim.b.gitsigns_head
      end,
      hl = "StatusLineBottom",
      cond = function()
        return git_info_exists() and wide_enough(70)
      end,
    },
    diff = {
      git_diff,
      cond = function()
        return git_info_exists() and wide_enough(60)
      end,
    },
  },
  lsp = {
    icon = {
      " " .. icons.gears .. " ",
      hl = "StatusLineLspIcon",
      cond = diagnostic_exists,
    },
    server = {
      get_lsp_clients,
      hl = "StatusLineBottom",
      cond = function()
        return diagnostic_exists() and wide_enough(55)
      end,
    },
    ok = {
      diagnostic_ok,
      hl = "DiagnosticSignOk",
      cond = diagnostic_exists,
    },
    diag = {
      get_diagnostic_all,
      cond = diagnostic_exists,
    },
  },
}

local sections = {
  -- Left side
  comps.mode,
  comps.sep.left,
  comps.file.icon,
  comps.file.name,
  comps.sep.left_nested,
  comps.git.icon,
  comps.git.branch,
  comps.git.diff,
  comps.sep.middle,

  -- Right side
  comps.lsp.diag,
  comps.lsp.icon,
  comps.lsp.server,
  comps.sep.right_nested,
  comps.file.format,
  comps.sep.right,
  comps.file.position,
  comps.file.percentage,
}

function M.render()
  update_colorscheme_highlights()
  update_mode_highlights()

  -- Filter out elements that are nil or false.
  return table.concat(
    vim.tbl_filter(function(section)
      return section
    end, build(sections)),
    ""
  )
end

return M
