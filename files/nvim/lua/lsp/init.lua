local lspconfig = require "lspconfig"
local on_attach = require "lsp.on_attach"
local utils = require "utils"
local icons = utils.icons

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local function get_gopls_config()
  if utils.is_yandex() then
    -- Custom gopls clubs/arcadia/29210
    -- Custom gopls index dirs IGNIETFERRO-2091
    -- Need to create a .arcadia.root file in the root go.mod dir
    return {
      -- cmd = { "ya", "tool", "gopls" },
      cmd = { os.getenv "HOME" .. "/.ya/tools/v4/gopls-linux/gopls" },
      -- root_dir = lspconfig.util.root_pattern("YAOWNERS", "ya.make", ".arcadia.root", "go.work", "go.mod", ".git"),
      settings = {
        gopls = {
          arcadiaIndexDirs = {
            os.getenv "HOME" .. "/cloudia/cloud-go/cloud/cloud-go/cloudgate",
            os.getenv "HOME" .. "/cloudia/cloud-go/cloud/cloud-go/healthcheck",
          },
        },
      },
    }
  end

  return {}
end

-- LSP servers custom configs
local servers = {
  buf_ls = {},
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
  ruff = {
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
  gopls = get_gopls_config(),
  rust_analyzer = {
    capabilities = {
      experimental = {
        snippetTextEdit = true,
      },
    },
  },
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
