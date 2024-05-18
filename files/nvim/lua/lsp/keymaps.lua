local M = {}

local map = require("utils").map

local function set_keymaps()
  local keymaps = {
    -- General
    { "n", "<leader>ci", "<cmd>LspInfo<CR>" },
    { "n", "<leader>cR", "<cmd>LspRestart<CR>" },
    { "n", "<leader>F", function() vim.lsp.buf.format { async = true } end },
    { "n", "<leader>ca", function() vim.lsp.buf.code_action { source = { organizeImports = true } } end },
    { "n", "<leader>ch", vim.lsp.buf.hover },
    { "n", "<leader>cr", vim.lsp.buf.rename },
    { "n", "<leader>cd", vim.lsp.buf.definition },

    -- Diagnostic
    -- NVIM 0.10 has floating diagnostics on <C-W>d by default
    { "n", "<leader>cD", vim.diagnostic.open_float },
    -- These keybinds are now on by default
    -- { "n", "]d", function() vim.diagnostic.goto_next { float = false } end },
    -- { "n", "[d", function() vim.diagnostic.goto_prev { float = false } end},
  }

  for _, binds in ipairs(keymaps) do
    local mode, lhs, rhs, opts = unpack(binds)
    map(mode, lhs, rhs, opts)
  end
end

function M.setup()
  set_keymaps()
end

return M
