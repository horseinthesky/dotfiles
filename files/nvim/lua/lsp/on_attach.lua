vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LSP on attach", { clear = true }),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    -- Auto-format ("lint") on save
    -- if client:supports_method "textDocument/formatting" then
    --   vim.api.nvim_create_autocmd("BufWritePre", {
    --     buffer = args.buf,
    --     callback = function()
    --       vim.lsp.buf.format { bufnr = args.buf, id = client.id, timeout_ms = 1000 }
    --     end,
    --   })
    -- end

    -- Document highlight
    if client:supports_method "textDocument/documentHighlight" then
      local group = vim.api.nvim_create_augroup("LSPDocumentHighlight", { clear = true })

      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = args.buf,
        callback = vim.lsp.buf.document_highlight,
        group = group,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = args.buf,
        callback = vim.lsp.buf.clear_references,
        group = group,
      })

      vim.api.nvim_set_hl(0, "LspReferenceRead", { link = "Search" })
      vim.api.nvim_set_hl(0, "LspReferenceWrite", { link = "IncSearch" })
    end

    -- Inlay hints
    if client:supports_method "textDocument/inlayHint" then
      vim.lsp.inlay_hint.enable(true)
    end
  end,
})
