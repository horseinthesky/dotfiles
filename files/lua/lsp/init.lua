local map = require("utils").map
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

  local lsp_keymappings = {
    { "n", "<leader>i", "<cmd>LspInfo<CR>" },
    { "n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next({enable_popup = false})<CR>" },
    { "n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev({enable_popup = false})<CR>" },
    { "n", "<leader>cd", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>" },
    { "n", "<leader>ch", "<cmd>lua vim.lsp.buf.hover()<CR>" },
    { "n", "<leader>cD", "<cmd>lua vim.lsp.buf.definition()<CR>" },
    { "n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>" },
    { "n", "<leader>cl", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>" },
    { "n", "<leader>ci", "<cmd>lua vim.lsp.buf.implementation()<CR>" },
    { "n", "<leader>cs", "<cmd>lua vim.lsp.buf.signature_help()<CR>" },
    { "n", "<leader>F", "<cmd>lua vim.lsp.buf.formatting()<CR>" },
    -- { "n", "<leader>td", "<cmd>lua vim.lsp.buf.type_definition()<CR>" },
    -- { "n", "<leader>rf", "<cmd>lua vim.lsp.buf.references()<CR>" },
    -- { "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action({ source = { organizeImports = true } })<CR>" },
  }

  for _, binds in ipairs(lsp_keymappings) do
    local mode, lhs, rhs, opts = unpack(binds)
    map(mode, lhs, rhs, opts)
  end

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

local servers = {
  gopls = {},
  jedi_language_server = {},
  yamlls = {},
  jsonls = { cmd = { "vscode-json-languageserver", "--stdio" } },
  vimls = {},
  terraformls = {},
  dockerls = {},
  sumneko_lua = require("lsp.sumneko").config,
  ["null-ls"] = require "lsp.null",
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

-- Diagnostic
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  -- Enable/diable virtual text
  virtual_text = {
    spacing = 4,
    -- prefix = icons.circle .. " ",
    prefix = icons.duck,
  },
  -- Enable/diable diagnistic in Insert mode
  update_in_insert = true,
})

-- Diagnostic highligths & signs
local hl_cmds = [[
  highlight! link DiagnosticInfo Identifier
  highlight! link DiagnosticHint PreProc
  highlight! link DiagnosticWarn Type
  highlight! link DiagnosticError Statement
]]

vim.api.nvim_exec(hl_cmds, false)

local lsp_signs = {
  DiagnosticSignHint = {
    -- text = icons.diagnostic.hint,
    text = "",
    texthl = "DiagnosticSignHint",
  },
  DiagnosticSignInfo = {
    -- text = icons.diagnostic.info,
    text = "",
    texthl = "DiagnosticSignInfo",
  },
  DiagnosticSignWarn = {
    -- text = icons.diagnostic.warning,
    text = "",
    texthl = "DiagnosticSignWarn",
  },
  DiagnosticSignError = {
    -- text = icons.diagnostic.error,
    text = "",
    texthl = "DiagnosticSignError",
  },
}

for hl_group, config in pairs(lsp_signs) do
  vim.fn.sign_define(hl_group, config)
end
