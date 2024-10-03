local icons = require("appearance").icons
local lspconfig = require "lspconfig"
local on_attach = require "lsp.on_attach"

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- LSP servers custom configs
local servers = {
  bufls = {},
  bashls = {},
  dockerls = {},
  terraformls = {},
  yamlls = {},
  cssls = { on_attach = on_attach.no_format },
  jsonls = { on_attach = on_attach.no_format },
  html = {
    filetypes = { "html", "jinja.html" },
    on_attach = on_attach.no_format,
  },
  pyright = {
    settings = {
      python = {
        python = {
          venvPath = ".venv",
        },
        -- analysis = {
        --   typeCheckingMode = "off",
        -- },
      },
    },
  },
  ruff_lsp = {
    init_options = {
      settings = {
        args = {
          "--line-length",
          "100",
          "--select",
          "I,F,W,E,B,A,C,RET",
          "--ignore",
          "E501,F401,F821",
        },
      },
    },
  },
  gopls = {
    root_dir = lspconfig.util.root_pattern("YAOWNERS", "ya.make", "go.work", "go.mod", ".git"),
  },
  rust_analyzer = {},
  lua_ls = {
    on_init = function(client)
      local path = client.workspace_folders[1].name
      if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
        return
      end

      client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
        runtime = {
          version = "LuaJIT",
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
          },
        },
      })
    end,
    settings = {
      Lua = {},
    },
  },
}

-- Setup LSP servers
for server, config in pairs(servers) do
  lspconfig[server].setup(vim.tbl_deep_extend("force", {
    capabilities = capabilities,
    on_attach = on_attach.default,
    flags = {
      debounce_text_changes = 250,
    },
  }, config))
end

require("lsp.null").setup { on_attach = on_attach.default }

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
