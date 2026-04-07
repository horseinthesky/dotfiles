local M = {}

local utils = require "config.utils"

---- NVIM 0.10 new default keymaps
-- <C-W>d (CTRL-W and d) map to vim.diagnostic.open_float()
-- K maps to vim.lsp.buf.hover(),
-- ]d maps to vim.diagnostic.goto_next()
-- [d maps to vim.diagnostic.goto_prev()

---- NVIM 0.11 new default keymaps
-- gra maps to vim.lsp.buf.code_action()
-- grn maps to vim.lsp.buf.rename()
-- grr maps to vim.lsp.buf.references()
-- gri maps to vim.lsp.buf.implementation()
-- gO maps to vim.lsp.buf.document_symbol()
-- CTRL-S Insert/Select mode maps to vim.lsp.buf.signature_help()

---- NVIM 0.12 new default keymaps
-- grt maps to vim.lsp.buf.type_definition()
-- grx maps to vim.lsp.codelens.run()
local keymaps = {
  { "<leader>ci", "<CMD>checkhealth lsp<CR>", { desc = "LSP healthcheck" } },
  { "<leader>cR", "<CMD>lsp restart<CR>", { desc = "LSP Restart" } },
  { "<leader>F", vim.lsp.buf.format, { desc = "Format" } },
  { "<leader>ca", vim.lsp.buf.code_action, { desc = "Actions" } },
  { "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" } },
  { "<leader>cd", vim.lsp.buf.definition, { desc = "Definition" } },
  {
    "<leader>ch",
    function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())

      local msg = vim.lsp.inlay_hint.is_enabled() and "enabled" or "disabled"
      utils.info("inlay hints " .. msg, { title = "LSP" })
    end,
    { desc = "Inlay hints toggle" },
  },
}

function M.set(client, bufnr)
  for _, keymap in ipairs(keymaps) do
    local lhs, rhs, opts = unpack(keymap)
    opts = vim.tbl_extend("force", opts, {
      buffer = bufnr,
    })
    utils.nmap(lhs, rhs, opts)
  end
end

return M
