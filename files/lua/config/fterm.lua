local map = require("utils").map

require("FTerm").setup {
  dimensions = {
    width = 1,
    height = 0.5,
    x = 0,
    y = 1,
  },
}

map("n", "<F3>", '<CMD>lua require("FTerm").toggle()<CR>')
map("t", "<F3>", '<CMD>lua require("FTerm").toggle()<CR>')

local ptpython = require("FTerm.terminal"):new():setup {
  cmd = "ptpython",
  dimensions = {
    width = 1,
    height = 0.5,
    x = 0,
    y = 1,
  },
}

function _G.__fterm_ptpython()
  ptpython:toggle()
end

map("n", "<F4>", "<CMD>lua __fterm_ptpython()<CR>")
map("t", "<F4>", "<CMD>lua __fterm_ptpython()<CR>")
