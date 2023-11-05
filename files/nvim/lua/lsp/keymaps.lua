local M = {}

local map = require("utils").map

local function keymap()
  local lsp_keymappings = {
    { "n", "<leader>i", "<cmd>LspInfo<CR>" },
    { "n", "<leader>F", function() vim.lsp.buf.format { async = true } end },
    { "n", "]d", function() vim.diagnostic.goto_next { float = false } end },
    { "n", "[d", function() vim.diagnostic.goto_prev { float = false } end},
    { "n", "<leader>cd", vim.diagnostic.open_float },
    { "n", "<leader>ch", vim.lsp.buf.hover },
    { "n", "<leader>cD", vim.lsp.buf.definition },
    { "n", "<leader>cr", vim.lsp.buf.rename },
    { "n", "<leader>ci", vim.lsp.buf.implementation },
    { "n", "<leader>cs", vim.lsp.buf.signature_help },
    { "n", "<leader>td", vim.lsp.buf.type_definition },
    { "n", "<leader>cf", vim.lsp.buf.references },
    { "n", "<leader>ca", function() vim.lsp.buf.code_action { source = { organizeImports = true } } end },
  }

  for _, binds in ipairs(lsp_keymappings) do
    local mode, lhs, rhs, opts = unpack(binds)
    map(mode, lhs, rhs, opts)
  end
end

function M.setup()
  keymap()
end

return M
