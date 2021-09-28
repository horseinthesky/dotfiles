local map = require("utils").map

require("lspsaga").init_lsp_saga {
  use_saga_diagnostic_sign = false,
  rename_prompt_prefix = "",
  rename_action_keys = { quit = "<ESC>", exec = "<CR>" },
  code_action_keys = { quit = "<ESC>", exec = "<CR>" },
  code_action_prompt = {
    enable = false
  },
}
map("n", "<leader>ca", "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", { silent = true })
map("n", "<leader>cr", "<cmd>lua require('lspsaga.rename').rename()<CR>", { silent = true })
map("n", "<leader>ch", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", { silent = true })
map("n", "<leader>cs", "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", { silent = true })
-- map("n", "<leader>cD", "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>", { silent = true })
-- map("n", "]d", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", {silent = true})
-- map("n", "[d", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", {silent = true})
vim.api.nvim_exec(
  [[
    highlight link LspSagaHoverBorder Normal
    highlight link LspSagaDiagnosticBorder LspSagaHoverBorder
    highlight link LspSagaDiagnosticTruncateLine LspSagaHoverBorder
    highlight link LspSagaRenameBorder LspSagaHoverBorder
    highlight link LspSagaCodeActionBorder LspSagaHoverBorder
    highlight link LspSagaSignatureHelpBorder LspSagaHoverBorder
  ]],
  false
)
