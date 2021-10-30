local map = require("utils").map

-- ==== Feature plugin settings ====
-- fzf
vim.g.fzf_colors = {
  ["hl"] = { "fg", "Search" },
  ["hl+"] = { "fg", "Search" },
  ["info"] = { "fg", "PreProc" },
  ["pointer"] = { "fg", "Statement" },
  ["marker"] = { "fg", "Special" },
}
vim.g.fzf_action = {
  ["ctrl-t"] = "tab split",
  ["ctrl-s"] = "split",
  ["ctrl-v"] = "vsplit",
}
vim.g.fzf_layout = {
  ["window"] = {
    ["width"] = 1,
    ["height"] = 0.5,
    ["yoffset"] = 1,
  },
}
vim.g.fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

vim.api.nvim_exec(
  [[
    function! RipgrepFzf(query, fullscreen)
      let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
      let initial_command = printf(command_fmt, shellescape(a:query))
      let reload_command = printf(command_fmt, '{q}')
      let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
      call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    endfunction

    command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
  ]],
  false
)

map("n", ";", "<cmd>Files<CR>")
map("n", "<C-p>", "<cmd>Rg<CR>")

-- ultisnips
vim.g.UltiSnipsExpandTrigger = "<C-s>"
vim.g.UltiSnipsJumpForwardTrigger = "<Tab>"
vim.g.UltiSnipsJumpBackwardTrigger = "<S-Tab>"

-- If you want :UltiSnipsEdit to split your window.
vim.g.UltiSnipsEditSplit = "vertical"

-- symbols-outline
map("n", "<F5>", "<cmd>SymbolsOutline<CR>")

vim.cmd [[highlight link FocusedSymbol Search]]
vim.g.symbols_outline = {
  preview_bg_highlight = "NormalFloat",
}

-- startuptime
vim.g.startuptime_tries = 5
map("n", "<leader>M", "<cmd>StartupTime<CR>")

-- visual-multi
map("n", "<S-Up>", ":<C-U>call vm#commands#add_cursor_up(0, v:count1)<CR>")
map("n", "<S-Down>", ":<C-U>call vm#commands#add_cursor_down(0, v:count1)<CR>")

-- vim-fugitive
map("n", "<leader>gd", "<cmd>Gvdiffsplit!<CR>")
map("n", "gdh", "<cmd>diffget //2<CR>")
map("n", "gdl", "<cmd>diffget //3<CR>")

-- vim-mundo
map("n", "<F7>", "<cmd>MundoToggle<CR>")
vim.g.mundo_prefer_python3 = 1
vim.g.mundo_width = 25
vim.g.mundo_preview_bottom = 1
vim.g.mundo_close_on_revert = 1
-- vim.g.mundo_preview_height = 1
-- vim.g.mundo_right = 1

-- vim-doge
-- Runs on <leader>d and TAB/S-TAB for jumping TODOs
vim.g.doge_doc_standard_python = "google"

-- linediff
-- map("n", "<leader>ld", ":Linediff<CR>")
map("x", "<leader>ld", ":Linediff<CR>")
map("n", "<leader>lr", "<cmd>LinediffReset<CR>")

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

-- Colorizer
map("n", "<leader>ct", "<cmd>ColorToggle<CR>")
map("n", "<leader>cs", "<cmd>ColorSwapFgBg<CR>")

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
