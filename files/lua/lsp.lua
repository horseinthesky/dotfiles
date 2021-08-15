local map = require "utils".map
-- local icons = appearance.icons
local lspconfig = require "lspconfig"

-- Servers setup
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(client, _)
  vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc"

  require("lsp_signature").on_attach()

  local lsp_keymappings = {
    { "n", "<leader>i", "<cmd>LspInfo<CR>" },
    { "n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next({enable_popup = false})<CR>" },
    { "n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev({enable_popup = false})<CR>" },
    { "n", "<leader>cd", "<cmd>lua vim.lsp.buf.definition()<CR>" },
    -- {"n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>"},
    { "n", "<leader>ci", "<cmd>lua vim.lsp.buf.implementation()<CR>" },
    -- {"n", "<leader>ch", "<cmd>lua vim.lsp.buf.hover()<CR>"},
    -- {"n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>"},
    { "n", "<leader>F", "<cmd>lua vim.lsp.buf.formatting()<CR>" },
    -- {"n", "<leader>td", "<cmd>lua vim.lsp.buf.type_definition()<CR>"},
    -- {"n", "<leader>rf", "<cmd>lua vim.lsp.buf.references()<CR>"},
    -- {"n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action({ source = { organizeImports = true } })<CR>"},
    -- {"n", "<leader>cD", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>"},
    { "n", "<leader>cl", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>" },
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
  "gopls",
  "jedi_language_server",
  "yamlls",
  "vimls",
}

for _, server in ipairs(servers) do
  lspconfig[server].setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

lspconfig.jsonls.setup {
  cmd = { "vscode-json-languageserver", "--stdio" },
  filetypes = { "json", "jsonc" },
  capabilities = capabilities,
  init_options = {
    provideFormatter = true,
  },
  on_attach = on_attach,
}

local sumneko_root_path = vim.fn.expand "~" .. "/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"
lspconfig.sumneko_lua.setup {
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        library = {
          -- Make the server aware of Neovim runtime files
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
      },
    },
  },
  on_attach = on_attach,
}

local efm = require "efm"
local flake8 = efm.flake8
local isort = efm.isort
local black = efm.black
local mypy = efm.mypy
local stylua = efm.stylua
local prettier = efm.prettier

local languages = {
  python = { isort, flake8, black, mypy },
  lua = { stylua },
  yaml = { prettier },
  json = { prettier },
  html = { prettier },
  css = { prettier },
  markdown = { prettier },
}

lspconfig.efm.setup {
  root_dir = lspconfig.util.root_pattern(".git", "."),
  filetypes = vim.tbl_keys(languages),
  init_options = { documentFormatting = true, codeAction = true },
  settings = { languages = languages, log_level = 1, log_file = "~/efm.log" },
  on_attach = on_attach,
}

-- Diagnostic
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  -- Enable/diable virtual text
  virtual_text = {
    spacing = 4,
    prefix = " ",
  },
  -- Enable/diable diagnistic in Insert mode
  update_in_insert = true,
})

-- Diagnostic highligths & signs
local hl_cmds = [[
  highlight! link LspDiagnosticsDefaultInformation Identifier
  highlight! link LspDiagnosticsDefaultHint PreProc
  highlight! link LspDiagnosticsDefaultWarning Type
  highlight! link LspDiagnosticsDefaultError Statement
]]

vim.api.nvim_exec(hl_cmds, false)

local lsp_signs = {
  LspDiagnosticsSignHint = {
    -- text = icons.diagnostic.hint,
    text = "",
    texthl = "LspDiagnosticsSignHint",
  },
  LspDiagnosticsSignInformation = {
    -- text = icons.diagnostic.info,
    text = "",
    texthl = "LspDiagnosticsSignInformation",
  },
  LspDiagnosticsSignWarning = {
    -- text = icons.diagnostic.warning,
    text = "",
    texthl = "LspDiagnosticsSignWarning",
  },
  LspDiagnosticsSignError = {
    -- text = icons.diagnostic.error,
    text = "",
    texthl = "LspDiagnosticsSignError",
  },
}
for hl_group, config in pairs(lsp_signs) do
  vim.fn.sign_define(hl_group, config)
end
