-- Neovim providers
-- vim.g.loaded_clipboard_provider = 0
-- vim.g.clipboard = {
--   name = "void",
--   copy = {
--     ["+"] = true,
--     ["*"] = true
--   },
--   paste = {
--     ["+"] = {},
--     ["*"] = {}
--   }
-- }

vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.python3_host_prog = "~/.python/bin/python"
vim.g.node_host_prog = "~/.local/share/yarn/global/node_modules/neovim/bin/cli.js"

vim.cmd [[syntax enable]]

local settings = {
  -- General
  inccommand = "nosplit", -- Incremental substitution shows substituted text before applying
  laststatus = 2, -- Always show statusline
  showmode = false, -- No to duplicate statusline
  backup = false, -- Don't create annoying backup files
  iskeyword = {"@", "48-57", "_", "192-255", "-"}, -- Treat dash separated words as a word text object
  mouse = "v", -- Diable mouse (if enabled temp. disable with holding Shift)
  winblend = 10, -- Transparency for floating windows
  pumblend = 10, -- Transparency for popup-menu
  scrolloff = 10, -- Start scrolling 10 lines before edge of viewpoint
  pastetoggle = "<F2>", -- Paste mode toggle to paste code properly
  guicursor = "", -- Fix for mysterious 'q' letters
  completeopt = {"menu", "menuone", "noselect"}, -- Set completeopt to have a better completion experience
  shortmess = "filnxtToOFcI", -- Don't give |ins-completion-menu| messages
  guifont = "DejavuSansMono NF:h16", -- Font
  updatetime = 300, -- Faster completion (default is 4000)
  timeoutlen = 500, -- Timeout for a mapped sequence to complete. (1000 ms by default)
  -- cmdheight = 2,     -- More space for messages

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
    trail = "·"
  },
  -- list = true,

  -- Cursor
  cursorline = true, -- Highlight cursorline
  colorcolumn = {"80", "100"}, -- Add vertical lines on columns
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
  undodir = vim.fn.stdpath("config") .. "/undo",
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
  shiftround = true -- When shifting lines, round the indentation to the nearest multiple of “shiftwidth.”
}

for option, value in pairs(settings) do
  vim.opt[option] = value
end

vim.api.nvim_exec(
  [[
  augroup TabSettings
    autocmd!
    " vim-commentary help
    autocmd BufRead,BufNewFile *.conf,*.cfg        setlocal filetype=config
    autocmd FileType config                        setlocal commentstring=#\ %s
    autocmd FileType toml                          setlocal commentstring=#\ %s

    autocmd FileType python                        setlocal sw=4 ts=4
    autocmd FileType make                          setlocal sw=4 ts=4 noet
    autocmd FileType vim,config,json,yaml,lua      setlocal sw=2 ts=2
    autocmd FileType jinja                         setlocal sw=0
    autocmd FileType go                            setlocal sw=8 ts=8 noet
  augroup END
]],
  false
)

-- Highlight on yank
vim.cmd [[autocmd TextYankPost * lua vim.highlight.on_yank {on_visual = false, timeout = 100}]]
