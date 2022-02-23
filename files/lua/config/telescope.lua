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
require("telescope").load_extension "neoclip"

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
