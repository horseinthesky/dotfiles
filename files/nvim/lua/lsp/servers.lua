require "lsp.on_attach"
local lspconfig = require "lspconfig"
local utils = require "config.utils"
local keymaps = require "lsp.keymaps"

local servers = {
  bashls = {},
  yamlls = {},
  jsonls = {
    init_options = {
      provideFormatter = false,
    },
  },
  dockerls = {},
  terraformls = {},
  buf_ls = {},
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
  gopls = utils.ternary(utils.is_yandex, {
    -- Custom gopls clubs/arcadia/29210
    -- Custom gopls index dirs IGNIETFERRO-2091
    -- Need to create a .arcadia.root file in the root go.mod dir
    -- root_dir = lspconfig.util.root_pattern("YAOWNERS", "ya.make", ".arcadia.root", "go.work", "go.mod", ".git"),
    cmd = { os.getenv "HOME" .. "/.ya/tools/v4/gopls-linux/gopls" },
    settings = {
      gopls = {
        arcadiaIndexDirs = {
          os.getenv "HOME" .. "/cloudia/cloud-go/cloud/cloud-go/cloudgate",
          os.getenv "HOME" .. "/cloudia/cloud-go/cloud/cloud-go/healthcheck",
        },
      },
    },
  }, {}),
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

for server, config in pairs(servers) do
  lspconfig[server].setup(vim.tbl_deep_extend("force", {
    on_attach = keymaps.set,
    flags = {
      debounce_text_changes = 250,
    },
  }, config))
end
