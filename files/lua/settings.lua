local utils = require("utils")

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
vim.g.python3_host_prog = "/usr/bin/python3"
vim.g.node_host_prog = "/usr/lib/node_modules/neovim/bin/cli.js"

-- Set options
local settings = {
  -- Search
  incsearch = true,
  hlsearch = false,
  ignorecase = true,
  smartcase = true,
  -- General
  inccommand = "nosplit",                -- Incremental substitution shows substituted text before applying
  laststatus = 2,                        -- Always show statusline
  showmode = false,                      -- No to duplicate statusline
  backup = false,                        -- Don't create annoying backup files
  iskeyword = "@,48-57,_,192-255,-",     -- Treat dash separated words as a word text object
  mouse = "v",                           -- Diable mouse (if enabled temp. disable with holding Shift)
  scrolloff = 10,                        -- Start scrolling 10 lines before edge of viewpoint
  pastetoggle = "<F2>",                  -- Paste mode toggle to paste code properly
  guicursor = "",                        -- Fix for mysterious 'q' letters
  completeopt = "menu,menuone,noselect", -- Set completeopt to have a better completion experience
  shortmess = "filnxtToOFcI",            -- Don't give |ins-completion-menu| messages
  updatetime = 300,                      -- Faster completion (default is 4000)
  timeoutlen = 500,                      -- By default timeoutlen is 1000 ms
  -- cmdheight = 2                          -- More space for messages

  -- Windows
  number = {true, "w"},
  relativenumber = {true, "w"},
  listchars = "tab:\\ ,trail:·,precedes:←,extends:→,space:·,eol:↲,nbsp:␣",
  -- list = {true, 'w'},

  -- Cursor
  cursorline = {true, "w"},                -- Highlight cursorline
  colorcolumn = {"80,120", "w"},           -- Add vertical lines on columns
  linebreak = {true, "w"},                 -- Word wrap
  -- signcolumn = {'yes', 'w'},               -- Always show signcolumns (left row)

  -- Folding
  foldmethod = {"indent", "w"},            -- Fold based on indent
  foldnestmax = {10, "w"},                 -- Deepest fold is 10 levels
  foldenable = {false, "w"},               -- Dont fold by default
  foldlevel = {2, "w"},                    -- This is just what I use
  -- History
  history = 100,
  undolevels = 100,
  undofile = true,
  undodir = vim.fn.stdpath("config") .. "/undo",
  -- Splits
  splitbelow = true,                       -- new horizontal split to appear below
  splitright = true,                       -- new vertical split to appear on the right
  -- Buffers
  showtabline = 1,                         -- Show tabs only when 2 or more open
  swapfile = {false, "b"},                 -- Dont' use swapfile
  shiftwidth = {2, "b"},                   -- Shift lines by 2 spaces
  tabstop = {2, "b"},                      -- 2 whitespaces for tabs visual presentation
  smarttab = true,                         -- Set tabs for a shifttabs logic
  expandtab = {true, "b"},                 -- Expand tabs into spaces
  smartindent = {true, "b"},
  shiftround = true                        -- When shifting lines, round the indentation to the nearest multiple of “shiftwidth.”
}

vim.cmd [[syntax enable]]
for option, value in pairs(settings) do
  if type(value) == "table" then
    value, scope = unpack(value)
  else
    scope = "o"
  end
  utils.opt(option, value, scope)
end

vim.api.nvim_exec(
  [[
  augroup TabSettings
    autocmd!
    " vim-commentary help
    autocmd BufRead,BufNewFile *.conf,*.cfg        setlocal filetype=config
    autocmd FileType config                        setlocal commentstring=#\ %s

    autocmd FileType python,make                   setlocal sw=4 ts=4
    autocmd FileType vim,config,json,yaml,lua      setlocal sw=2 ts=2
    autocmd FileType jinja                         setlocal sw=0
    autocmd FileType go                            setlocal sw=8 ts=8 noet
  augroup END
]],
  false
)

-- Highlight on yank
vim.cmd [[autocmd TextYankPost * lua vim.highlight.on_yank {on_visual = false, timeout = 100}]]
