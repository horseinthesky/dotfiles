local M = {}

function M.default(client, bufnr)
  vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc"

  -- Setup LSP keymaps
  require("lsp.keymaps").setup()

  -- Format on save
  -- if client.server_capabilities.documentFormattingProvider then
  --   vim.api.nvim_create_autocmd("BufWritePre", {
  --     callback = function()
  --       vim.lsp.buf.format { async = true }
  --     end,
  --   })
  -- end

  -- Document highlight
  if client.server_capabilities.documentHighlightProvider then
    local group = vim.api.nvim_create_augroup("LSPDpcumentHighlight", { clear = true })

    vim.api.nvim_create_autocmd("CursorHold", {
      pattern = "<buffer>",
      callback = vim.lsp.buf.document_highlight,
      group = group,
    })

    vim.api.nvim_create_autocmd("CursorMoved", {
      pattern = "<buffer>",
      callback = vim.lsp.buf.clear_references,
      group = group,
    })

    vim.api.nvim_set_hl(0, "LspReferenceRead", { link = "Search" })
    vim.api.nvim_set_hl(0, "LspReferenceWrite", { link = "IncSearch" })
  end

  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
end

function M.no_format(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  M.default(client, bufnr)
end

return M
