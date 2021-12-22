local map = require("utils").map

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
map("n", "<leader>fB", [[<cmd>lua require('telescope.builtin').builtin({ previewer = false })<CR>]])
map("n", "<leader>fg", [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])
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
map("n", "<leader>fld", [[<cmd>lua require('telescope.builtin').diagnostics( { bufnr = 0 } )<CR>]])
map("n", "<leader>flD", [[<cmd>lua require('telescope.builtin').diagnostics()<CR>]])
map("n", "<leader>fls", [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]])
map("n", "<leader>flS", [[<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>]])
map("n", "<leader>flr", [[<cmd>lua require('telescope.builtin').lsp_references()<CR>]])

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
