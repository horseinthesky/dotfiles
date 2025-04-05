local M = {}

local utils = require "config.utils"

local function set_keymaps()
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
    { "n", "<leader>cR", "<cmd>LspRestart<CR>", { desc = "Restart LSP clients" } },
    { "n", "<leader>ci", "<cmd>checkhealth lsp<CR>", { desc = "LSP healthcheck" } },
    { "n", "<leader>F", vim.lsp.buf.format, { desc = "Format" } },

    -- LSP
    { "n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Actions" } },
    { "n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" } },
    { "n", "<leader>cd", vim.lsp.buf.definition, { desc = "Go to definition" } },
    {
      "n",
      "<leader>ch",
      function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())

        local msg = vim.lsp.inlay_hint.is_enabled() and "enabled" or "disabled"
        utils.info("inlay hints " .. msg, "LSP")
      end,
      { desc = "Hints toggle" },
    },

    -- Diagnostic
    { "n", "<leader>cD", vim.diagnostic.open_float, { desc = "Diagnostic" } },
  }

  for _, binds in ipairs(keymaps) do
    local mode, lhs, rhs, opts = unpack(binds)
    utils.map(mode, lhs, rhs, opts)
  end
end

function M.setup()
  set_keymaps()
end

return M
