-- require "lsp.servers"
require "lsp.diagnostic"
require "lsp.on_attach"
local keymaps = require "lsp.keymaps"

-- Shared LSP config
vim.lsp.config("*", {
  root_markers = { ".git" },
  on_attach = keymaps.set,
})

-- Auto discover LSP configs
local lsp_configs = {}
for _, filename in pairs(vim.api.nvim_get_runtime_file('lsp/*.lua', true)) do
  local server_name = vim.fn.fnamemodify(filename, ':t:r')
  table.insert(lsp_configs, server_name)
end

vim.lsp.enable(lsp_configs)
