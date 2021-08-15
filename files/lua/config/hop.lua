local map = require("utils").map

vim.cmd [[highlight link HopNextKey Type]]
map("n", "f", "<cmd>HopChar1<CR>")

require("hop").setup()
