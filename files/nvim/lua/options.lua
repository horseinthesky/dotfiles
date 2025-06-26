-- Colorscheme
vim.g.theme = "gruvbox"
-- vim.g.theme = "tokyonight-storm"

-- Options
local settings = {
  -- General
  inccommand = "nosplit", -- Do not show substitutions in split below, show them in main window instead
  laststatus = 2, -- Always show statusline
  showmode = false, -- No to duplicate statusline
  backup = false, -- Don't create annoying backup files
  iskeyword = { "@", "48-57", "_", "192-255", "-" }, -- Treat dash separated words as a word text object
  mouse = "v", -- Diable mouse (Enable is "a". If enabled temp. disable with holding Shift)
  winblend = 10, -- Transparency for floating windows
  winborder = "rounded",
  pumblend = 10, -- Transparency for popup-menu
  scrolloff = 10, -- Start scrolling 10 lines before edge of viewpoint
  completeopt = vim.opt.completeopt + "noselect", -- Set completeopt to have a better completion experience
  shortmess = vim.opt.shortmess + "c", -- Don't give |ins-completion-menu| messages
  updatetime = 300, -- Faster completion (default is 4000)
  timeoutlen = 500, -- Timeout for a mapped sequence to complete (default 1000)

  -- Search
  incsearch = true,
  hlsearch = false,
  ignorecase = true,
  smartcase = true,

  -- Windows
  number = true,
  relativenumber = true,
  fillchars = {
    eob = " ",
  },
  listchars = {
    eol = "↲",
    extends = "→",
    nbsp = "␣",
    precedes = "←",
    space = "·",
    tab = " ",
    trail = "·",
  },
  -- list = true,

  -- Cursor
  cursorline = true, -- Highlight cursorline
  colorcolumn = { "80", "100" }, -- Add vertical lines on columns
  linebreak = true, -- Word wrap
  -- signcolumn = "yes",               -- Always show signcolumns (left row)

  -- History & undo
  history = 100,
  undolevels = 100,
  undofile = true,

  -- Splits
  splitbelow = true, -- new horizontal split to appear below
  splitright = true, -- new vertical split to appear on the right

  -- Buffers
  showtabline = 1, -- Show tabs only when 2 or more open
  swapfile = false, -- Dont' use swapfile
  shiftwidth = 2, -- Shift lines by 2 spaces
  tabstop = 2, -- 2 whitespaces for tabs visual presentation
  smarttab = true, -- Set tabs for a shifttabs logic
  expandtab = true, -- Expand tabs into spaces
  smartindent = true,
  shiftround = true, -- When shifting lines, round the indentation to the nearest multiple of “shiftwidth.”
  statusline = [[%!v:lua.require("config.statusline").render()]],
}

for option, value in pairs(settings) do
  vim.opt[option] = value
end

-- Diable default providers
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy "+",
    ["*"] = require("vim.ui.clipboard.osc52").copy "*",
  },
  paste = {
    ["+"] = function()
      return {}
    end,
    ["*"] = function()
      return {}
    end,
  },
}

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Disable loading builtin plugins
local builtin_plugins = {
  -- File manager
  "netrwPlugin",

  -- Pair elems matcher
  "matchit",
  "matchparen",

  -- Archive
  "gzip",
  "zipPlugin",
  "tarPlugin",

  -- HTML exporter
  "tohtml",

  -- Tutor
  "tutor",
}

for _, plugin in ipairs(builtin_plugins) do
  vim.g["loaded_" .. plugin] = 1
end
