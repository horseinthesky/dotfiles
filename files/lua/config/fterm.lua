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

map("n", "<F3>", require("FTerm").toggle)
map("t", "<F3>", require("FTerm").toggle)

local ptpython = fterm:new(vim.tbl_extend("force", opts, { cmd = "ptpython" }))

function _PTPYTHON()
  ptpython:toggle()
end

map("n", "<F4>", _PTPYTHON)
map("t", "<F4>", _PTPYTHON)
