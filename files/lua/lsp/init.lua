local icons = require("appearance").icons
local lspconfig = require "lspconfig"

-- Servers setup
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}

local on_attach = function(client, _)
  vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc"

  -- Setup LSP keymaps
  require("lsp.keymaps").setup()

  -- Format on save
  -- if client.resolved_capabilities.document_formatting then
  --   vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting()]]
  -- end

  -- Document highlight
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
        hi LspReferenceRead cterm=bold ctermbg=239 guibg=#504945
        hi LspReferenceText cterm=bold ctermbg=239 guibg=#504945
        hi LspReferenceWrite cterm=bold ctermbg=243 guibg=#7c6f64
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]],
      false
    )
  end
end

local no_format_on_attach = function(client, _)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
  require("lsp.keymaps").setup()
end

local servers = {
  gopls = {},
  jedi_language_server = {},
  yamlls = {
    settings = {
      yaml = {
        schemas = {
          kubernetes = "/*.yaml",
        },
      },
    },
  },
  html = {
    filetypes = { "html", "jinja.html" },
    on_attach = no_format_on_attach,
  },
  cssls = { on_attach = no_format_on_attach },
  jsonls = { on_attach = no_format_on_attach },
  terraformls = {},
  dockerls = {},
  sumneko_lua = require("lsp.sumneko").config,
  -- efm = require "lsp.efm".config,
}

for server, config in pairs(servers) do
  lspconfig[server].setup(vim.tbl_deep_extend("force", {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 250,
    },
  }, config))
end

require("lsp.null").setup { on_attach = on_attach }

-- Diagnostic
vim.diagnostic.config {
  virtual_text = {
    spacing = 4,
    prefix = icons.duck,
  },
  signs = false,
  float = {
    border = "single",
  },
  update_in_insert = false,
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "single",
})

-- Diagnostic highligths & signs
local hl_cmds = [[
  highlight! link DiagnosticInfo Identifier
  highlight! link DiagnosticHint PreProc
  highlight! link DiagnosticWarn Type
  highlight! link DiagnosticError Statement
]]

vim.api.nvim_exec(hl_cmds, false)

local signs = {
  Error = icons.diagnostic.error,
  Warn = icons.diagnostic.warning,
  Hint = icons.diagnostic.hint,
  Info = icons.diagnostic.info,
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type

  vim.fn.sign_define(hl, {
    text = icon,
    texthl = hl,
    numhl = "",
  })
end
