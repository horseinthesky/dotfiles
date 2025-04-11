local M = {}

local utils = require "config.utils"

local function lsp_restart()
  vim.lsp.stop_client(vim.lsp.get_clients())
  vim.cmd "sleep 500m"
  vim.cmd "edit"
end

---- NVIM 0.10 new default keymaps
-- <C-W>d (CTRL-W and d) - floating diagnostic
-- K - hover
-- ]d - goto next diagnostic
-- [d - goto prev diagnostic

---- NVIM 0.11 new default keymaps
-- gra - code actions
-- grn - rename
-- grr - references
-- gri - implementation
-- gO - document symbol
-- CTRL-S Insert/Select mode - signature help
local keymaps = {
  { "<leader>cR", lsp_restart, { desc = "Restart LSP clients" } },
  { "<leader>ci", "<cmd>checkhealth lsp<CR>", { desc = "LSP healthcheck" } },
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
