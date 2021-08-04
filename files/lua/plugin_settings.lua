local map = require("utils").map

-- ==== LSP and completion plugin settings ====
-- lspsaga
require("lspsaga").init_lsp_saga {
  rename_prompt_prefix = "",
  rename_action_keys = { quit = "<ESC>", exec = "<CR>" },
  code_action_keys = { quit = "<ESC>", exec = "<CR>" },
}
map("n", "<leader>ca", "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", { silent = true })
map("n", "<leader>cr", "<cmd>lua require('lspsaga.rename').rename()<CR>", { silent = true })
map("n", "<leader>ch", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", { silent = true })
map("n", "<leader>cs", "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", { silent = true })
map("n", "<leader>cD", "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>", { silent = true })
-- map("n", "]d", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", {silent = true})
-- map("n", "[d", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", {silent = true})
vim.api.nvim_exec(
  [[
    highlight link LspSagaHoverBorder Normal
    highlight link LspSagaDiagnosticBorder LspSagaHoverBorder
    highlight link LspSagaDiagnosticTruncateLine LspSagaHoverBorder
    highlight link LspSagaRenameBorder LspSagaHoverBorder
    highlight link LspSagaCodeActionBorder LspSagaHoverBorder
    highlight link LspSagaSignatureHelpBorder LspSagaHoverBorder
  ]],
  false
)

-- lspkind
require("lspkind").init {
  symbol_map = {
    Class = "",
  },
}

-- ==== Feature plugin settings ====
-- telescope
local actions = require "telescope.actions"

require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-J>"] = actions.move_selection_next,
        ["<C-K>"] = actions.move_selection_previous,
      },
    },
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
    -- layout_strategy = 'vertical',
    prompt_prefix = " ",
    selection_caret = " ",
    layout_config = {
      prompt_position = "top",
      preview_cutoff = 80,
      horizontal = {
        -- width_padding = 10,
        -- height_padding = 7,
        preview_width = 0.6,
      },
    },
    winblend = 10,
  },
}

require("telescope").load_extension "fzf"

-- regular search mappings
map("n", "<leader>ff", [[<cmd>lua require('telescope.builtin').find_files { hidden = true}<CR>]])
map("n", "<leader>fh", [[<cmd>lua require('telescope.builtin').help_tags()<CR>]])
map("n", "<leader>fb", [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
map("n", "<leader>fL", [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]])
map("n", "<leader>fB", [[<cmd>lua require('telescope.builtin').builtin()<CR>]])
map("n", "<leader>fG", [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])
map("n", "<leader>fw", [[<cmd>lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>]])
map(
  "n",
  "<leader>fs",
  [[<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>]]
)
map("n", "<leader>fr", [[<cmd>lua require('telescope.builtin').registers()<CR>]])
map("n", "<leader>fm", [[<cmd>lua require('telescope.builtin').marks()<CR>]])
map("n", "<leader>fM", [[<cmd>lua require('telescope.builtin').keymaps()<CR>]])
map("n", "<leader>fo", [[<cmd>lua require('telescope.builtin').vim_options()<CR>]])
map("n", "<leader>fO", [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])
map("n", "<leader>fc", [[<cmd>lua require('telescope.builtin').commands()<CR>]])
map("n", "<leader>fa", [[<cmd>lua require('telescope.builtin').autocommands()<CR>]])
map("n", "<leader>fH", [[<cmd>lua require('telescope.builtin').highlights()<CR>]])
map("n", "<leader>fC", [[<cmd>lua require('telescope.builtin').colorscheme()<CR>]])
map("n", "<leader>fS", [[<cmd>lua require('telescope.builtin').symbols()<CR>]])

-- git search mappings
map("n", "<leader>gb", [[<cmd>lua require('telescope.builtin').git_branches()<CR>]])
map("n", "<leader>gc", [[<cmd>lua require('telescope.builtin').git_commits()<CR>]])
map("n", "<leader>gs", [[<cmd>lua require('telescope.builtin').git_status()<CR>]])

-- lsp search mappings
map("n", "<leader>fld", [[<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<CR>]])
map("n", "<leader>flD", [[<cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<CR>]])
map("n", "<leader>fls", [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]])
map("n", "<leader>flS", [[<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>]])

vim.api.nvim_exec(
  [[
    highlight link TelescopeSelection Constant
    highlight link TelescopeSelectionCaret TelescopeSelection
    highlight link TelescopeMultiSelection TelescopeSelection
    highlight link TelescopeMatching Type
    highlight link TelescopePromptPrefix Type
  ]],
  false
)

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

-- todo-comments
require("todo-comments").setup {
  signs = true,
  keywords = {
    PERF = { color = "perf" },
    HACK = { color = "hack" },
  },
  colors = {
    perf = "Number",
    hack = "Special",
  },
}

map("n", "<leader>ft", [[<cmd>TodoTelescope<CR>]])

-- UltiSnips
vim.g.UltiSnipsExpandTrigger = "<C-s>"
vim.g.UltiSnipsJumpForwardTrigger = "<Tab>"
vim.g.UltiSnipsJumpBackwardTrigger = "<S-Tab>"

-- If you want :UltiSnipsEdit to split your window.
vim.g.UltiSnipsEditSplit = "vertical"

-- symbols-outline
map("n", "<F5>", "<cmd>SymbolsOutline<CR>")

vim.cmd [[highlight link FocusedSymbol Search]]

-- FTerm
require("FTerm").setup {
  dimensions = {
    width = 1,
    height = 0.5,
    x = 0,
    y = 1,
  },
}

map("n", "<F3>", '<CMD>lua require("FTerm").toggle()<CR>')
map("t", "<F3>", '<CMD>lua require("FTerm").toggle()<CR>')

local ptpython = require("FTerm.terminal"):new():setup {
  cmd = "ptpython",
  dimensions = {
    width = 1,
    height = 0.5,
    x = 0,
    y = 1,
  },
}

function _G.__fterm_ptpython()
  ptpython:toggle()
end

map("n", "<F4>", "<CMD>lua __fterm_ptpython()<CR>")
map("t", "<F4>", "<CMD>lua __fterm_ptpython()<CR>")

-- StartupTime
vim.g.startuptime_tries = 5

-- hop.nvim
vim.cmd [[highlight link HopNextKey Type]]
map("n", "f", "<cmd>HopChar1<CR>")

require("hop").setup()

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
  { z = "~/.zshrc" },
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

-- shade
-- require "shade".setup {
--   overlay_opacity = 50,
--   opacity_step = 1,
--   keys = {
--     toggle = "<leader>D"
--   }
-- }

-- vim-better-whitespace
vim.g.better_whitespace_guicolor = "#fb4934"
vim.g.better_whitespace_filetypes_blacklist = { "dashboard", "packer" }

map("n", "]w", "<cmd>NextTrailingWhitespace<CR>")
map("n", "[w", "<cmd>PrevTrailingWhitespace<CR>")

-- nvim-treesitter
local swap_next, swap_prev = (function()
  local swap_objects = {
    c = "@class.outer",
    f = "@function.outer",
    b = "@block.outer",
    s = "@statement.outer",
    p = "@parameter.inner",
    m = "@call.outer",
  }

  local n, p = {}, {}
  for key, obj in pairs(swap_objects) do
    n[string.format("<leader>s%s", key)] = obj
    p[string.format("<leader>S%s", key)] = obj
  end

  return n, p
end)()

require("nvim-treesitter.configs").setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = { "yaml" },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<enter>",
      node_incremental = "<enter>",
      node_decremental = "<bs>",
    },
  },
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["oc"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["of"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ob"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["ol"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["os"] = "@statement.outer",
        ["is"] = "@statement.inner",
        ["oC"] = "@comment.outer",
        ["iC"] = "@comment.inner",
        ["om"] = "@call.outer",
        ["im"] = "@call.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = swap_next,
      swap_previous = swap_prev,
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25,
    persist_queries = false,
  },
}

-- gitsigns.nvim
require("gitsigns").setup {
  signs = {
    add = { hl = "DiffAdd", text = " " },
    change = { hl = "DiffChange", text = " " },
    delete = { hl = "DiffDelete", text = " " },
    topdelete = { hl = "DiffDelete", text = " " },
    changedelete = { hl = "DiffChange", text = " " },
  },
  keymaps = {
    ["n ]h"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'" },
    ["n [h"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'" },
    ["n <leader>gh"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
  },
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

if vim.g.colors_name == "gruvbox" then
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
      highlight BufferTabpageFill guifg=#bdae93 guibg=None
    ]],
    false
  )
end
