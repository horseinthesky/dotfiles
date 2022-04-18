local map = require("utils").map

map("n", "<leader>bp", "<cmd>BufferLinePick<CR>")

for buffer = 1,9 do
  map("n", "<leader>" .. buffer, "<cmd>BufferLineGoToBuffer " .. buffer .. "<CR>")
end

require("bufferline").setup {
  options = {
    always_show_bufferline = false,
    show_buffer_icons = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    modified_icon = "",
    show_tab_indicators = false,
    tab_size = 5,
    numbers = function(opts)
      if vim.api.nvim_get_current_buf() == opts.id then return "" end
      return opts.ordinal
    end,
  },
  highlights = {
    indicator_selected = {
      guifg = {
          attribute = "fg",
          highlight = "Type"
      },
      guibg = {
          attribute = "bg",
          highlight = "Type"
      },
    },
    numbers= {
      guifg = {
          attribute = "fg",
          highlight = "Type"
      },
    },
    buffer_selected = {
      gui = "NONE",
    },
    pick = {
      gui = "NONE",
    },
    pick_selected = {
      gui = "NONE",
    },
  },
}
