local map = require("utils").map

require("todo-comments").setup {
  signs = true,
  keywords = {
    PERF = { color = "perf" },
    HACK = { color = "hack" },
  },
  colors = {
    error = "Statement",
    warning = "Type",
    info = "Identifier",
    hint = "PreProc",
    perf = "Number",
    hack = "Special",
  },
}

map("n", "<leader>ft", [[<cmd>TodoTelescope<CR>]])
