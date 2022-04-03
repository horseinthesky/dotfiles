local utils = require("utils")

-- Neovim providers
-- vim.g.loaded_clipboard_provider = 0
vim.g.clipboard = {
  name = "void",
  copy = {
    ["+"] = true,
    ["*"] = true,
  },
  paste = {
    ["+"] = {},
    ["*"] = {},
  },
}

vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.python3_host_prog = "~/.python/bin/python"

-- Colorscheme
vim.g.theme = "gruvbox"

-- Disable loading builtin plugins
local disabled_built_ins = {
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",

  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",

  "matchit",
  "matchparen",
  "logipat",
  "rrhelper",

  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
}

for _, plugin in ipairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

-- Options
vim.cmd [[syntax enable]]

local settings = {
  -- General
  inccommand = "nosplit", -- Incremental substitution shows substituted text before applying
  laststatus = 2, -- Always show statusline
  showmode = false, -- No to duplicate statusline
  backup = false, -- Don't create annoying backup files
  iskeyword = { "@", "48-57", "_", "192-255", "-" }, -- Treat dash separated words as a word text object
  mouse = "v", -- Diable mouse (if enabled temp. disable with holding Shift)
  winblend = 10, -- Transparency for floating windows
  pumblend = 10, -- Transparency for popup-menu
  scrolloff = 10, -- Start scrolling 10 lines before edge of viewpoint
  pastetoggle = "<F2>", -- Paste mode toggle to paste code properly
  guicursor = "", -- Fix for mysterious 'q' letters
  -- completeopt = { "menu", "menuone", "noselect" }, -- Set completeopt to have a better completion experience
  shortmess = "filnxtToOFcI", -- Don't give |ins-completion-menu| messages
  guifont = "DejavuSansMono NF:h16", -- Font
  updatetime = 300, -- Faster completion (default is 4000)
  timeoutlen = 500, -- Timeout for a mapped sequence to complete. (1000 ms by default)
  -- cmdheight = 2,     -- More space for messages

  -- Clipboard
  -- clipboard = "unnamedplus",

  -- Search
  incsearch = true,
  hlsearch = false,
  ignorecase = true,
  smartcase = true,
  -- Windows
  number = true,
  relativenumber = true,
  listchars = {
    eol = "↲",
    extends = "→",
    nbsp = "␣",
    precedes = "←",
    space = "·",
    tab = "\\",
    trail = "·",
  },
  -- list = true,

  -- Cursor
  cursorline = true, -- Highlight cursorline
  colorcolumn = { "80", "100" }, -- Add vertical lines on columns
  linebreak = true, -- Word wrap
  -- signcolumn = "yes",               -- Always show signcolumns (left row)

  -- Folding
  foldmethod = "indent", -- Fold based on indent
  foldnestmax = 10, -- Deepest fold is 10 levels
  foldenable = false, -- Dont fold by default
  foldlevel = 2, -- This is just what I use
  -- History
  history = 100,
  undolevels = 100,
  undofile = true,
  undodir = vim.fn.stdpath "config" .. "/undo",
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
}

for option, value in pairs(settings) do
  vim.opt[option] = value
end

-- Shiftwidth, tabstop & expandtab settings based on filetype
local tab_group = vim.api.nvim_create_augroup("TabSettings", { clear = true })

local ft_settings = {
  python = {
    shiftwidth = 4,
    tabstop = 4,
  },
  make = {
    shiftwidth = 4,
    tabstop = 4,
    expandtab = false,
  },
  jinja = {
    shiftwidth = 2,
  },
  go = {
    shiftwidth = 8,
    expandtab = false,
  },
}

for ft, opts in pairs(ft_settings) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = ft,
    callback = function()
      for opt, value in pairs(opts) do
        vim.opt_local[opt] = value
      end
    end,
    group = tab_group,
  })
end

-- Windows to close with "q"
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "startuptime", "lspinfo" },
  callback = function()
    utils.map("n", "q", "<cmd>close<CR>", { buffer = true })
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { on_visual = false, timeout = 100 }
  end,
})

-- Return to last edit position when opening files (You want this!)
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local last_pos = vim.fn.line "'\""

    if last_pos >= 1 and last_pos <= vim.fn.line "$" then
      vim.cmd [[normal! g`"]]
    end
  end,
})

-- Turning number/relativenumer off for terminal windows
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.cmd [[startinsert]]
  end,
})

-- Notify if file is changed outside of vim
local checktime_group = vim.api.nvim_create_augroup("auto_checktime", { clear = true })

-- Trigger `checktime` when files changes on disk
-- https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
-- https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  callback = function()
    vim.schedule(function()
      local modes = { "n", "i", "ic" }

      if utils.has_value(modes, vim.api.nvim_get_mode().mode) and vim.fn.getcmdwintype() == '' then
        vim.cmd [[checktime]]
      end
    end)
  end,
  group = checktime_group,
})

-- Notification after file change
-- https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  callback = function()
    vim.schedule(function()
      info "File changed on disk. Buffer reloaded."
    end)
  end,
  group = checktime_group,
})

-- Allow files to be saved as root when forgetting to start Vim using sudo.
-- https://www.youtube.com/watch?v=AcvxrF2MrrI
-- https://www.youtube.com/watch?v=u1HgODpoijc
vim.api.nvim_add_user_command("W", ":execute ':silent w !sudo tee % > /dev/null' | :edit!", {})
