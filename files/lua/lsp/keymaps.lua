local M = {}

local map = require("utils").map

local function keymap()
  local lsp_keymappings = {
    { "n", "<leader>i", "<cmd>LspInfo<CR>" },
    { "n", "]d", "<cmd>lua vim.diagnostic.goto_next({ float = false })<CR>" },
    { "n", "[d", "<cmd>lua vim.diagnostic.goto_prev({ float = false })<CR>" },
    { "n", "<leader>cd", vim.diagnostic.open_float },
    { "n", "<leader>ch", vim.lsp.buf.hover },
    { "n", "<leader>cD", vim.lsp.buf.definition },
    { "n", "<leader>cr", vim.lsp.buf.rename },
    { "n", "<leader>cl", vim.lsp.diagnostic.set_loclist },
    { "n", "<leader>ci", vim.lsp.buf.implementation },
    { "n", "<leader>cs", vim.lsp.buf.signature_help },
    { "n", "<leader>F", vim.lsp.buf.formatting },
    -- { "n", "<leader>td", vim.lsp.buf.type_definition },
    -- { "n", "<leader>rf", vim.lsp.buf.references },
    { "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action({ source = { organizeImports = true } })<CR>" },
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
