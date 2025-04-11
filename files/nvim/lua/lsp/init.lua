-- require "lsp.servers"
require "lsp.diagnostic"
require "lsp.on_attach"
local keymaps = require "lsp.keymaps"

vim.lsp.config("*", {
  root_markers = { ".git" },
  on_attach = keymaps.set,
})

vim.lsp.enable {
  "bashls",
  "yamlls",
  "jsonls",
  "dockerls",
  "terraformls",
  "buf_ls",
  "lua_ls",
  "pyright",
  "ruff",
  "gopls",
  "rust_analyzer",
}
