local map = require("utils").map

-- ==== Feature plugin settings ====
-- Telescope
local telescope_mappings = {
  -- regular search mappings
  { "n", "<leader>ff", "<cmd>Telescope find_files hidden=true<CR>" },
  -- {"n", "<leader>fB", "<cmd>Telescope builtin previewer=false<CR>"},
  -- {"n", "<leader>fb", "<cmd>Telescope buffers<CR>"},
  -- {"n", "<leader>fe", "<cmd>Telescope current_buffer_fuzzy_find<CR>"},
  -- {"n", "<leader>fh", "<cmd>Telescope help_tags<CR>"},
  -- {"n", "<leader>fg", "<cmd>Telescope live_grep<CR>"},
  -- {"n", "<leader>fw", "<cmd>Telescope grep_string<CR>"},
  { "n", "<leader>fr", "<cmd>Telescope registers<CR>" },
  -- {"n", "<leader>fm", "<cmd>Telescope marks<CR>"},
  {"n", "<leader>fk", "<cmd>Telescope keymaps<CR>"},
  -- {"n", "<leader>fO", "<cmd>Telescope oldfiles<CR>"},
  { "n", "<leader>fc", "<cmd>Telescope commands<CR>" },
  { "n", "<leader>fo", "<cmd>Telescope vim_options<CR>" },
  { "n", "<leader>fa", "<cmd>Telescope autocommands<CR>" },
  { "n", "<leader>fH", "<cmd>Telescope highlights<CR>" },
  { "n", "<leader>fC", "<cmd>Telescope colorscheme<CR>" },
  { "n", "<leader>fS", "<cmd>Telescope symbols<CR>" },

  -- git search mappings
  -- {"n", "<leader>gb", "<cmd>Telescope git_branches<CR>"},
  -- {"n", "<leader>gc", "<cmd>Telescope git_commits<CR>"},
  -- {"n", "<leader>gs", "<cmd>Telescope git_status<CR>"},

  -- lsp search mappings
  -- {"n", "<leader>flr", "<cmd>Telescope lsp_references<CR>"},
  -- {"n", "<leader>fld", "<cmd>Telescope diagnostics bufnr=0<CR>"},
  -- {"n", "<leader>flD", "<cmd>Telescope diagnostics<CR>"},
  { "n", "<leader>fls", "<cmd>Telescope lsp_document_symbols<CR>" },
  { "n", "<leader>flS", "<cmd>Telescope lsp_workspace_symbols<CR>" },

  -- extentions
  { "n", "<leader>fp", "<cmd>Telescope project<CR>" },
  { "n", "<leader>fP", "<cmd>Telescope neoclip<CR>" },
}

for _, keymap in ipairs(telescope_mappings) do
  local mode, lhs, rhs, opts = unpack(keymap)
  map(mode, lhs, rhs, opts)
end

local hls = {
  TelescopeSelection = "Constant",
  TelescopeSelectionCaret = "TelescopeSelection",
  TelescopeMultiSelection = "TelescopeSelection",
  TelescopeMatching = "Type",
  TelescopePromptPrefix = "Type",
}

for group, link in pairs(hls) do
  vim.api.nvim_set_hl(0, group, { link = link })
end

-- fzf-lua
local fzf_mappings = {
  { "n", ";", "<cmd>FzfLua files<CR>" },
  { "n", "<leader>fg", "<cmd>FzfLua live_grep<CR>" },
  { "n", "<leader>fw", "<cmd>FzfLua grep_cword<CR>" },
  { "n", "<leader>fh", "<cmd>FzfLua help_tags<CR>" },
  { "n", "<leader>fb", "<cmd>FzfLua buffers<CR>" },
  { "n", "<leader>ft", "<cmd>FzfLua tabs<CR>" },
  { "n", "<leader>fB", "<cmd>FzfLua builtin<CR>" },
  { "n", "<leader>fe", "<cmd>FzfLua blines<CR>" },
  { "n", "<leader>fE", "<cmd>FzfLua lines<CR>" },
  -- {"n", "<leader>fr", "<cmd>FzfLua registers<CR>"},
  { "n", "<leader>fm", "<cmd>FzfLua marks<CR>" },
  -- { "n", "<leader>fk", "<cmd>FzfLua keymaps<CR>" },
  -- {"n", "<leader>fc", "<cmd>FzfLua commands<CR>"},
  { "n", "<leader>fO", "<cmd>FzfLua oldfiles<CR>" },

  -- git search mappings
  { "n", "<leader>gb", "<cmd>FzfLua git_branches<CR>" },
  { "n", "<leader>gc", "<cmd>FzfLua git_commits<CR>" },
  { "n", "<leader>gs", "<cmd>FzfLua git_status<CR>" },

  -- lsp search mappings
  { "n", "<leader>flr", "<cmd>FzfLua lsp_references<CR>" },
  { "n", "<leader>fld", "<cmd>FzfLua lsp_document_diagnostics<CR>" },
  { "n", "<leader>flD", "<cmd>FzfLua lsp_workspace_diagnostics<CR>" },
  -- {"n", "<leader>fls", "<cmd>FzfLua lsp_document_symbols<CR>"},
  -- {"n", "<leader>flS", "<cmd>FzfLua lsp_workspace_symbols<CR>"},
}

for _, keymap in ipairs(fzf_mappings) do
  local mode, lhs, rhs, opts = unpack(keymap)
  map(mode, lhs, rhs, opts)
end

-- neogen
map("n", "<leader>af", function() require("neogen").generate({ type = "func" }) end)
map("n", "<leader>ac", function() require("neogen").generate({ type = "class" }) end)
map("n", "<leader>at", function() require("neogen").generate({ type = "type" }) end)

-- hop
vim.api.nvim_set_hl(0, "HopNextKey", { link = "Type" })
map("n", "f", "<cmd>HopChar1<CR>")

-- osc52
map("n", "<leader>C", require("osc52").copy_operator, { expr = true })
map("n", "<leader>CC", "<leader>C_", { remap = true })
map("x", "<leader>C", require("osc52").copy_visual)

-- startuptime
vim.g.startuptime_tries = 5
map("n", "<leader>M", "<cmd>StartupTime<CR>")
-- Turning relativenumer on/off when changing window focus
vim.api.nvim_create_autocmd("FileType", {
  pattern = "startuptime",
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
  end,
})

-- ==== Visuals plugin settings ====
-- indentline
vim.g.indent_blankline_filetype_exclude = {
  "help",
  "packer",
  "alpha",
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
