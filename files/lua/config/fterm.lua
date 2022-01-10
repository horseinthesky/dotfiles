local fterm = require "FTerm"
local map = require("utils").map

local opts = {
  blend = 10,
  dimensions = {
    width = 1,
    height = 0.5,
    x = 0,
    y = 1,
  },
}

fterm.setup(opts)

map("n", "<F3>", '<CMD>lua require("FTerm").toggle()<CR>')
map("t", "<F3>", '<CMD>lua require("FTerm").toggle()<CR>')

local ptpython = fterm:new(vim.tbl_extend("force", opts, { cmd = "ptpython" }))

function _PTPYTHON()
  ptpython:toggle()
end

map("n", "<F4>", "<CMD>lua _PTPYTHON()<CR>")
map("t", "<F4>", "<CMD>lua _PTPYTHON()<CR>")
