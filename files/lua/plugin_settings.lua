local map = require("utils").map

-- ==== Feature plugin settings ====
-- fzf-lua
map("n", ";", "<cmd>FzfLua files<CR>")
map("n", "<C-p>", "<cmd>FzfLua live_grep<CR>")
map("n", "<C-b>", "<cmd>FzfLua buffers<CR>")
map("n", "<C-l>", "<cmd>FzfLua blines<CR>")
map("n", "<C-L>", "<cmd>FzfLua lines<CR>")

-- neogen
map("n", "<leader>af", "<cmd>lua require('neogen').generate({ type = 'func' })<CR>")
map("n", "<leader>ac", "<cmd>lua require('neogen').generate({ type = 'class' })<CR>")
map("n", "<leader>at", "<cmd>lua require('neogen').generate({ type = 'type' })<CR>")

-- hop
vim.cmd [[highlight link HopNextKey Type]]
map("n", "f", "<cmd>HopChar1<CR>")

-- ultisnips
vim.g.UltiSnipsExpandTrigger = "<C-s>"
vim.g.UltiSnipsJumpForwardTrigger = "<Tab>"
vim.g.UltiSnipsJumpBackwardTrigger = "<S-Tab>"

-- If you want :UltiSnipsEdit to split your window.
vim.g.UltiSnipsEditSplit = "vertical"

-- startuptime
vim.g.startuptime_tries = 5
map("n", "<leader>M", "<cmd>StartupTime<CR>")

-- ==== Visuals plugin settings ====
-- vim-startify
vim.g.startify_files_number = 10
vim.g.startify_session_persistence = 1
vim.g.startify_bookmarks = {
  { v = "~/.config/nvim/init.vim" },
  { z = "~/dotfiles/files/zsh/.zshrc" },
  { a = "~/dotfiles/files/zsh/aliases.zsh" },
}
vim.g.startify_lists = {
  { type = "bookmarks", header = { "   Bookmarks" } },
  { type = "dir", header = { "   Recent files" } },
  { type = "sessions", header = { "   Saved sessions" } },
}

map("n", "gss", "<cmd>SSave!<CR>")
map("n", "gsl", "<cmd>SLoad!<CR>")
map("n", "gsc", "<cmd>SClose!<CR>")
map("n", "gsd", "<cmd>SDelete!<CR>")

-- indentline
vim.g.indent_blankline_filetype_exclude = {
  "help",
  "markdown",
  "startify",
  "json",
  "peek",
  "packer",
  "dashboard",
}
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_first_indent_level = false
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_char_list = { "|", "¦", "┆", "┊" }
vim.g.indent_blankline_space_char = " "

map("n", "<leader>I", "<cmd>IndentBlanklineToggle<CR>")

-- vim-better-whitespace
vim.g.better_whitespace_guicolor = "#fb4934"
vim.g.better_whitespace_filetypes_blacklist = { "dashboard", "packer" }

map("n", "]w", "<cmd>NextTrailingWhitespace<CR>")
map("n", "[w", "<cmd>PrevTrailingWhitespace<CR>")
