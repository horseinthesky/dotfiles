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
    prompt_prefix = " ",
    selection_caret = " ",
    layout_config = {
      prompt_position = "top",
      preview_cutoff = 80,
      horizontal = {
        preview_width = 0.6,
      },
    },
    winblend = 10,
  },
  extensions = {
    project = {
      base_dirs = vim.split(vim.fn.glob("~/work/*"), "\n"),
    },
  },
}

require("telescope").load_extension "fzf"
require("telescope").load_extension "neoclip"
require("telescope").load_extension "project"

vim.cmd [[
  highlight link TelescopeSelection Constant
  highlight link TelescopeSelectionCaret TelescopeSelection
  highlight link TelescopeMultiSelection TelescopeSelection
  highlight link TelescopeMatching Type
  highlight link TelescopePromptPrefix Type
]]
