local map = require("utils").map

-- ==== Feature plugin settings ====
-- Telescope
-- regular search mappings
map("n", "<leader>ff", "<cmd>Telescope find_files hidden=true<CR>")
-- map("n", "<leader>fB", "<cmd>Telescope builtin previewer=false<CR>")
-- map("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
-- map("n", "<leader>fe", "<cmd>Telescope current_buffer_fuzzy_find<CR>")
-- map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")
-- map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
-- map("n", "<leader>fw", "<cmd>Telescope grep_string<CR>")
-- map("n", "<leader>fr", "<cmd>Telescope register<CR>")
-- map("n", "<leader>fm", "<cmd>Telescope marks<CR>")
-- map("n", "<leader>fM", "<cmd>Telescope keymaps<CR>")
-- map("n", "<leader>fO", "<cmd>Telescope oldfiles<CR>")
-- map("n", "<leader>fc", "<cmd>Telescope commands<CR>")
map("n", "<leader>fo", "<cmd>Telescope vim_options<CR>")
map("n", "<leader>fa", "<cmd>Telescope autocommands<CR>")
map("n", "<leader>fH", "<cmd>Telescope highlights<CR>")
map("n", "<leader>fC", "<cmd>Telescope colorscheme<CR>")
map("n", "<leader>fS", "<cmd>Telescope symbols<CR>")

-- git search mappings
-- map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>")
-- map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>")
-- map("n", "<leader>gs", "<cmd>Telescope git_status<CR>")

-- lsp search mappings
-- map("n", "<leader>fld", "<cmd>Telescope diagnostics bufnr=0<CR>")
-- map("n", "<leader>flD", "<cmd>Telescope diagnostics<CR>")
-- map("n", "<leader>fls", "<cmd>Telescope lsp_document_symbols<CR>")
-- map("n", "<leader>flS", "<cmd>Telescope lsp_workspace_symbols<CR>")
-- map("n", "<leader>flr", "<cmd>Telescope lsp_references<CR>")

-- fzf-lua
map("n", ";", "<cmd>FzfLua files<CR>")
map("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>")
map("n", "<leader>fw", "<cmd>FzfLua grep_cword<CR>")
map("n", "<leader>fh", "<cmd>FzfLua help_tags<CR>")
map("n", "<leader>fb", "<cmd>FzfLua buffers<CR>")
map("n", "<leader>fB", "<cmd>FzfLua builtin<CR>")
map("n", "<leader>fe", "<cmd>FzfLua blines<CR>")
map("n", "<leader>fE", "<cmd>FzfLua lines<CR>")
map("n", "<leader>fr", "<cmd>FzfLua registers<CR>")
map("n", "<leader>fm", "<cmd>FzfLua marks<CR>")
map("n", "<leader>fM", "<cmd>FzfLua keymaps<CR>")
map("n", "<leader>fc", "<cmd>FzfLua commands<CR>")
map("n", "<leader>fO", "<cmd>FzfLua oldfiles<CR>")

-- git search mappings
map("n", "<leader>gb", "<cmd>FzfLua git_branches<CR>")
map("n", "<leader>gc", "<cmd>FzfLua git_commits<CR>")
map("n", "<leader>gs", "<cmd>FzfLua git_status<CR>")

-- lsp search mappings
map("n", "<leader>flr", "<cmd>FzfLua lsp_references<CR>")

map("n", "<leader>fld", "<cmd>FzfLua lsp_document_diagnostics<CR>")
map("n", "<leader>flD", "<cmd>FzfLua lsp_workspace_diagnostics<CR>")
map("n", "<leader>fls", "<cmd>FzfLua lsp_document_symbols<CR>")
map("n", "<leader>flS", "<cmd>FzfLua lsp_workspace_symbols<CR>")

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
