local map = require "utils".map

require "compe_tabnine"

require("compe").setup {
  preselect = "disable",
  source_timeout = 100,
  source = {
    path = { kind = "" },
    buffer = { kind = "" },
    calc = { kind = "" },
    nvim_lsp = { kind = "" },
    nvim_lua = { kind = "" },
    spell = {
      kind = "",
      priority = 45,
    },
    ultisnips = { kind = "" },
    tabnine = {
      kind = "",
      priority = 50,
      ignore_pattern = "[(|,]",
    },
    emoji = { kind = "ﲃ", filetypes = { "markdown" } },
  },
}

map("i", "<CR>", 'compe#confirm("<CR>")', { expr = true })
--
-- Use <Tab> and <S-Tab> to navigate through popup menu
map("i", "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
map("i", "<S-Tab>", 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})

vim.cmd [[highlight link CompeDocumentation Pmenu]]
