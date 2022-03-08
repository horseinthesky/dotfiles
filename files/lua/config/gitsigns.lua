require("gitsigns").setup {
  signs = {
    add = { hl = "DiffAdd", text = " " },
    change = { hl = "DiffChange", text = " " },
    delete = { hl = "DiffDelete", text = " " },
    topdelete = { hl = "DiffDelete", text = " " },
    changedelete = { hl = "DiffChange", text = " " },
  },
  keymaps = {
    ["n ]h"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'" },
    ["n [h"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'" },
    ["n <leader>gh"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ["n <leader>gw"] = '<cmd>lua require"gitsigns".blame_line()<CR>',
  },
}

vim.cmd [[
  highlight! link DiffChange IncSearch
  highlight! link DiffDelete ErrorMsg
]]
