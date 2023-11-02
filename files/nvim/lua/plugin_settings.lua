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
  { "n", "<leader>fk", "<cmd>Telescope keymaps<CR>" },
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
map("n", "f", "<cmd>HopChar1<CR>")

-- osc52
map("n", "<leader>C", require("osc52").copy_operator, { expr = true })
map("n", "<leader>CC", "<leader>C_", { remap = true })
map("x", "<leader>C", require("osc52").copy_visual)

-- gopher
map("n", "<leader>ctaj", "<cmd>GoTagAdd json<CR>")
map("n", "<leader>ctrj", "<cmd>GoTagRm json<CR>")
map("n", "<leader>ctay", "<cmd>GoTagAdd yaml<CR>")
map("n", "<leader>ctry", "<cmd>GoTagRm yaml<CR>")
map("n", "<leader>ctax", "<cmd>GoTagAdd xml<CR>")
map("n", "<leader>ctrx", "<cmd>GoTagRm xml<CR>")

map("n", "<leader>cgta", "<cmd>GoTestAdd<CR>")
map("n", "<leader>cgte", "<cmd>GoTestExp<CR>")
map("n", "<leader>cgtA", "<cmd>GoTestAll<CR>")

-- treesj
map("n", "gj", "<cmd>TSJToggle<CR>")

-- devdocs
map("n", "<leader>fd", "<cmd>DevdocsOpenCurrentFloat<CR>")

-- ==== Visuals plugin settings ====
-- indentline
map("n", "<leader>I", "<cmd>IBLToggle<CR>")
