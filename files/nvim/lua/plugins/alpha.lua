local alpha = require "alpha"
local dashboard = require "alpha.themes.dashboard"

-- Header
local header = {
  type = "text",
  val = {
    [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
    [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
    [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
    [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
    [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
    [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
  },
  opts = {
    position = "center",
    hl = "Title",
  },
}

-- Buttons
local function button(key, txt, keybind, keybind_opts)
  local b = dashboard.button(key, txt, keybind, keybind_opts)
  b.opts.hl = "Normal"
  b.opts.hl_shortcut = "Type"
  return b
end

local buttons = {
  type = "group",
  val = {
    button("e", "  New file", ":ene <BAR> startinsert <CR>"),
    button("f", "󰈞 Find file", ":Telescope find_files <CR>"),
    button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
    button("g", "  Live grep", ":Telescope live_grep <CR>"),
    button("p", "  Find project", ":Telescope project <CR>"),
    button("c", "  Configuration", ":e $MYVIMRC<CR>"),
    button("q", "  Quit", ":qa<CR>"),
  },
  opts = {
    position = "center",
    spacing = 1,
  },
}

-- Quote
local fortune = require "alpha.fortune"

local quote = {
  type = "text",
  val = fortune(),
  opts = {
    position = "center",
    hl = "Identifier",
  },
}

-- Footer
local function get_footer()
  local datetime = os.date "%d-%m-%Y %H:%M:%S"
  local plugins_text = ""
    .. "v"
    .. vim.version().major
    .. "."
    .. vim.version().minor
    .. "."
    .. vim.version().patch
    .. "   "
    .. datetime

  return plugins_text
end

local footer = {
  type = "text",
  val = get_footer(),
  opts = {
    hl = "Constant",
    position = "center",
  },
}

-- Layout
-- ┌──────────────────────────────────────────────────────────┐
-- │                    /                                     │
-- │      header_padding                                      │
-- │                    \┌──────────────┐ _                   │
-- │                     │    header    │  \                  │
-- │                    /└──────────────┘   \                 │
-- │  head_quote_padding                     \                │
-- │                    \┌──────────────┐     \               │
-- │                     │    quote     │      \              │
-- │                    /└──────────────┘       \             │
-- │ quote_button_padding                        \            │
-- │                    \                         occu_height │
-- │                  ┌────────────────────┐     /            │
-- │                  │       button       │    /             │
-- │                  │       button       │   /              │
-- │                  │       button       │  /               │
-- │                  └────────────────────┘‾‾                │
-- │                    /                                     │
-- │   foot_butt_padding                                      │
-- │                    \┌──────────────┐                     │
-- │                     │    footer    │                     │
-- │                     └──────────────┘                     │
-- │                                                          │
-- └──────────────────────────────────────────────────────────┘

local head_quote_padding = 2
local quote_button_padding = 4
local occu_height = #header.val + #quote.val + 2 * #buttons.val + head_quote_padding + quote_button_padding
local header_padding = math.max(0, math.ceil((vim.api.nvim_win_get_height(0) - occu_height) * 0.25))
local foot_butt_padding = math.max(0, math.ceil(vim.api.nvim_win_get_height(0) - occu_height - header_padding - 2))

local config = {
  layout = {
    { type = "padding", val = header_padding },
    header,
    { type = "padding", val = head_quote_padding },
    quote,
    { type = "padding", val = quote_button_padding },
    buttons,
    { type = "padding", val = foot_butt_padding },
    footer,
  },
  opts = {
    margin = 3,
  },
}
alpha.setup(config)
