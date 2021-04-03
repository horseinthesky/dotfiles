local map = require "utils".map

-- ==== LSP and completion plugin settings ====
-- lspsaga
require "lspsaga".init_lsp_saga {
  rename_prompt_prefix = "",
  rename_action_keys = {quit = "<ESC>", exec = "<CR>"},
  code_action_keys = {quit = "<ESC>", exec = "<CR>"}
}
map("n", "<leader>ca", "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", {silent = true})
map("n", "<leader>gr", "<cmd>lua require('lspsaga.rename').rename()<CR>", {silent = true})
map("n", "gh", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", {silent = true})
map("n", "<leader>ld", "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>", {silent = true})
map("n", "]d", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", {silent = true})
map("n", "[d", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", {silent = true})
vim.api.nvim_exec(
  [[
    highlight LspSagaHoverBorder guifg=#fe8019
    highlight link LspSagaDiagnosticBorder LspSagaHoverBorder
    highlight link LspSagaDiagnosticTruncateLine LspSagaHoverBorder
    highlight link LspSagaRenameBorder LspSagaHoverBorder
    highlight link LspSagaCodeActionBorder LspSagaHoverBorder
  ]],
  false
)

-- lspkind
require"lspkind".init()

-- ==== Feature plugin settings ====
-- telescope
local actions = require('telescope.actions')

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-J>"] = actions.move_selection_next,
        ["<C-K>"] = actions.move_selection_previous,
      },
    },
    prompt_position = "top",
    sorting_strategy = "ascending",
    scroll_strategy = 'cycle',
    -- layout_strategy = 'vertical',
    prompt_prefix = " ",
    selection_caret = " ",
    preview_cutoff = 80,
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    }
  }
}

require('telescope').load_extension('fzy_native')

map("n", "<leader>fb", [[<cmd>lua require('telescope.builtin').builtin()<CR>]])
map("n", "<leader>ff", [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
map("n", "<leader>fg", [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])
map("n", "<leader>fw", [[<cmd>lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>]])
map("n", "<leader>fs", [[<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>]])
map("n", "<leader>fl", [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]])
map("n", "<leader>fm", [[<cmd>lua require('telescope.builtin').keymaps()<CR>]])
map("n", "<leader>fo", [[<cmd>lua require('telescope.builtin').vim_options()<CR>]])
map("n", "<leader>fO", [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])
map("n", "<leader>fc", [[<cmd>lua require('telescope.builtin').commands()<CR>]])
map("n", "<leader>fa", [[<cmd>lua require('telescope.builtin').autocommands()<CR>]])
map("n", "<leader>ft", [[<cmd>lua require('telescope.builtin').treesitter()<CR>]])
map("n", "<leader>fh", [[<cmd>lua require('telescope.builtin').help_tags()<CR>]])
map("n", "<leader>fB", [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
map("n", "<leader>fH", [[<cmd>lua require('telescope.builtin').highlights()<CR>]])
map("n", "<leader>fC", [[<cmd>lua require('telescope.builtin').colorscheme()<CR>]])
map("n", "<leader>fS", [[<cmd>lua require('telescope.builtin').symbols()<CR>]])

vim.api.nvim_exec(
  [[
    highlight TelescopeSelection guifg=#d3869b gui=bold
    highlight link TelescopeSelectionCaret TelescopeSelection
    highlight link TelescopeMultiSelection TelescopeSelection
    highlight TelescopeMatching guifg=#fabd2f
    highlight TelescopePromptPrefix guifg=#fabd2f
  ]],
  false
)

-- fzf
vim.g.fzf_colors = {
  ["hl"] = {"fg", "Search"},
  ["hl+"] = {"fg", "Search"},
  ["info"] = {"fg", "PreProc"},
  ["pointer"] = {"fg", "Exception"},
  ["bg+"] = {"bg", "CursorLine", "CursorColumn"},
  ["marker"] = {"fg", "Tag"}
}
vim.g.fzf_action = {
  ["ctrl-t"] = "tab split",
  ["ctrl-s"] = "split",
  ["ctrl-v"] = "vsplit"
}
vim.g.fzf_layout = {
  ["window"] = {
    ["width"] = 1,
    ["height"] = 0.5,
    ["yoffset"] = 1
  }
}
vim.g.fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

map("n", ";", "<cmd>Files<CR>")
map("n", "<C-p>", "<cmd>Rg<CR>")
map("n", "<leader>bl", "<cmd>BLines<CR>")
map("n", "<leader>m", "<cmd>Maps<CR>")
map("n", "<leader>co", "<cmd>Commands<CR>")

-- UltiSnips
vim.g.UltiSnipsExpandTrigger = "<C-s>"
vim.g.UltiSnipsJumpForwardTrigger = "<C-j>"
vim.g.UltiSnipsJumpBackwardTrigger = "<C-k>"

-- If you want :UltiSnipsEdit to split your window.
vim.g.UltiSnipsEditSplit = "vertical"

-- floaterm
vim.g.floaterm_keymap_toggle = "<F3>"
vim.g.floaterm_keymap_new = "<F4>"
vim.g.floaterm_keymap_prev = "<F5>"
vim.g.floaterm_keymap_next = "<F6>"
vim.g.floaterm_position = "bottom"
vim.g.floaterm_width = 1.001
vim.g.floaterm_height = 0.3

-- map("n", "<F3>", "<cmd>FloatermToggle<CR>")
-- map("t", "<F3>", "<cmd>FloatermToggle<CR>")
-- map("n", "<F4>", "<cmd>FloatermNew python<CR>")
-- map("t", "<F4>", "<cmd>FloatermNew python<CR>")
-- map("n", "<F5>", "<cmd>FloatermPrev<CR>")
-- map("t", "<F5>", "<cmd>FloatermPrev<CR>")
-- map("n", "<F6>", "<cmd>FloatermNext<CR>")
-- map("t", "<F6>", "<cmd>FloatermNext<CR>")

-- which-key
map("n", "<leader>", ":WhichKey '<leader>'<CR>")
map("v", "<leader>", ":<c-u>WhichKeyVisual '<leader>'<CR>")

vim.api.nvim_exec(
	[[
		autocmd! FileType which_key
		autocmd FileType which_key set laststatus=0 | autocmd BufLeave <buffer> set laststatus=2
	]]
	, false
)

vim.g.which_key_use_floating_win = 0
vim.g.which_key_max_size = 30
vim.g.which_key_timeout = 100
vim.g.which_key_display_names = {["<CR>"] = "↵", ["<TAB>"] = "⇆"}

vim.g.which_key_map =  {}
vim.g.which_key_map["'"] = {"<C-W>s", "split below"}
vim.g.which_key_map.s = {
  name = '+sessions',
  c = { 'SClose!' , 'close session' },
  d = { 'SDelete!', 'delete session' },
  l = { 'SLoad!', 'load session' },
  s = { 'SSave!', 'save session' },
}

vim.g.which_key_map.c = {
  name = '+lsp',
  o = { '<cmd>Command' , 'commands' },
  s = { '<cmd>ColorSwapFgBg', 'color swap fg bf' },
  t = { '<cmd>ColorToggle', 'color toggle' },
}

vim.cmd [[call which_key#register('<leader>', 'g:which_key_map')]]

-- hop.nvim
map("n", "f", "<cmd>HopChar1<CR>")
vim.cmd [[highlight HopNextKey guifg=#fabd2f]]

-- visual-multi
map("n", "<S-Up>", ":<C-U>call vm#commands#add_cursor_up(0, v:count1)<CR>")
map("n", "<S-Down>", ":<C-U>call vm#commands#add_cursor_down(0, v:count1)<CR>")

-- peekup
require('nvim-peekup.config').on_keystroke["delay"] = ""

-- vim-fugitive
map("n", "<leader>gd", "<cmd>Gvdiffsplit!<CR>")
map("n", "gdh", "<cmd>diffget //2<CR>")
map("n", "gdl", "<cmd>diffget //3<CR>")

-- tagbar
map("n", "<F8>", "<cmd>TagbarToggle<CR>")
vim.g.tagbar_autofocus = 1
vim.g.tagbar_autoclose = 1
vim.g.tagbar_sort = 1

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
  {["v"] = "~/.config/nvim/init.vim"},
  {["z"] = "~/.zshrc"}
}
vim.g.startify_lists = {
  {["type"] = "bookmarks", ["header"] = {"   Bookmarks"}},
  {["type"] = "dir", ["header"] = {"   Recent files"}},
  {["type"] = "sessions", ["header"] = {"   Saved sessions"}}
}

map("n", "<leader>ss", "<cmd>SSave!<CR>")
map("n", "<leader>sl", "<cmd>SLoad!<CR>")
map("n", "<leader>sc", "<cmd>SClose!<CR>")
map("n", "<leader>sd", "<cmd>SDelete!<CR>")

-- Colorizer
map("n", "<leader>ct", "<cmd>ColorToggle<CR>")
map("n", "<leader>cs", "<cmd>ColorSwapFgBg<CR>")

-- indentline
vim.g.indent_blankline_filetype_exclude = {
  "help",
  "tagbar",
  "markdown",
  "startify",
  "json",
  "peek"
}
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_first_indent_level = false
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_char_list = {"|", "¦", "┆", "┊"}
vim.g.indent_blankline_space_char = ' '
vim.api.nvim_exec(
  [[
    highlight IndentBlanklineChar guifg=#504945 gui=nocombine
    highlight link IndentBlanklineSpaceChar IndentBlanklineChar
    highlight link IndentBlanklineSpaceCharBlankline IndentBlanklineChar
  ]],
  false
)

map("n", "<leader>i", "<cmd>IndentBlanklineToggle<CR>")

-- vim-better-whitespace
vim.g.better_whitespace_ctermcolor = 167

map("n", "]w", "<cmd>NextTrailingWhitespace<CR>")
map("n", "[w", "<cmd>PrevTrailingWhitespace<CR>")

-- nvim-treesitter
require "nvim-treesitter.configs".setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true
  }
}

-- gitsigns.nvim
require "gitsigns".setup {
  signs = {
    add = {hl = "DiffAdd", text = " "},
    change = {hl = "DiffChange", text = " "},
    delete = {hl = "DiffDelete", text = " "},
    topdelete = {hl = "DiffDelete", text = " "},
    changedelete = {hl = "DiffChange", text = " "}
  }
}

-- barbar
vim.g.bufferline = {
  icons = "numbers",
  auto_hide = true,
  clickable = false,
  closable = false,
  tabpages = false,
  maximum_padding = 1,
  icon_separator_active = "",
  icon_separator_inactive = "▎",
}

map("n", "<leader>bp", "<cmd>BufferPick<CR>")

vim.api.nvim_exec(
  [[
    highlight BufferCurrent guifg=#504945 guibg=#bdae93
    highlight BufferCurrentIndex guifg=#fe8019 guibg=#bdae93
    highlight BufferCurrentTarget guifg=#fb4934 guibg=#bdae93
    highlight BufferInactive guifg=#bdae93 guibg=#504945
    highlight BufferInactiveIndex guifg=#fe8019 guibg=#504945
    highlight BufferInactiveTarget guifg=#fb4934 guibg=#504945
    highlight link BufferCurrentSign BufferCurrent
    highlight link BufferCurrentMod BufferCurrent
    highlight link BufferInactiveSign BufferInactive
    highlight link BufferInactiveMod BufferInactive
    highlight BufferTabpageFill guibg=None
  ]],
  false
)
