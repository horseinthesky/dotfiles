local map = require("utils").map
local icons = require("appearance").icons

require("notify").setup {
  -- Animation style (see below for details)
  stages = "fade",

  -- Default timeout for notifications
  timeout = 500,

  -- For stages that change opacity this is treated as the highlight behind the window
  -- Set this to either a highlight group or an RGB hex value e.g. "#000000"
  background_colour = "Normal",

  -- Icons for the different levels
  icons = {
    ERROR = icons.diagnostic.error,
    WARN = icons.diagnostic.warning,
    INFO = icons.diagnostic.info,
    DEBUG = icons.bug,
    TRACE = icons.file.modified,
  },
}

map(
  "n",
  "gn",
  "<cmd>lua require('notify')(vim.api.nvim_buf_get_name(0), 'info', { title = 'Filename' })<CR>"
)
