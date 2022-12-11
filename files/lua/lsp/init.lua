local icons = require("appearance").icons
local lspconfig = require "lspconfig"

-- On attach
local on_attach = function(client, _)
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
    local lsp_highlight_group = vim.api.nvim_create_augroup("LSPHighlight", { clear = true })

    vim.api.nvim_create_autocmd("CursorHold", {
      pattern = "<buffer>",
      callback = vim.lsp.buf.document_highlight,
      group = lsp_highlight_group,
    })

    vim.api.nvim_create_autocmd("CursorMoved", {
      pattern = "<buffer>",
      callback = vim.lsp.buf.clear_references,
      group = lsp_highlight_group,
    })
  end
end

local no_format_on_attach = function(client, _)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
  require("lsp.keymaps").setup()
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Servers setup
local servers = {
  rust_analyzer = {},
  -- gopls = {},
  gopls = {
    root_dir = lspconfig.util.root_pattern("YAOWNERS", "ya.make", "go.work", "go.mod", ".git"),
    settings = {
      gopls = {
        expandWorkspaceToModule = false,
      },
    },
  },
  pylsp = {
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = {
            -- enabled = false,
            maxLineLength = 100,
            ignore = {
              "E501",
            },
          },
          -- mccabe = {
          --   enabled = false,
          -- },
          -- pyflakes = {
          --   enabled = false,
          -- },
        },
      },
    },
  },
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

-- Signs
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

-- Colors
vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { link = "Type" })
