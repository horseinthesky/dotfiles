local map = require("utils").map

map("n", "<leader>bp", "<cmd>BufferLinePick<CR>")

for buffer = 1,9 do
  map("n", "<leader>" .. buffer, "<cmd>BufferLineGoToBuffer " .. buffer .. "<CR>")
end

require("bufferline").setup {
  options = {
    mode = "tabs",
    always_show_bufferline = false,
    show_buffer_icons = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    modified_icon = "",
    show_tab_indicators = false,
    tab_size = 5,
    numbers = function(opts)
      if vim.api.nvim_get_current_tabpage() == opts.id then return "" end
      return opts.ordinal
    end,
  },
  highlights = {
    indicator_selected = {
      fg = {
          attribute = "fg",
          highlight = "Type"
      },
      bg = {
          attribute = "bg",
          highlight = "Type"
      },
    },
    numbers= {
      fg = {
          attribute = "fg",
          highlight = "Type"
      },
    },
    buffer_selected = {
      italic = false,
    },
    pick = {
      italic = false,
    },
    pick_selected = {
      italic = false,
    },
  },
}
