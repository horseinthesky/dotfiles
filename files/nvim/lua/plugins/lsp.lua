local map = require("config.utils").map

return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    config = function()
      local nls = require "null-ls"
      local b = nls.builtins

      local sources = {
        -- Lint
        b.diagnostics.hadolint,
        b.diagnostics.buf,
        -- b.diagnostics.mypy.with {
        --   extra_args = {
        --     "--show-column-numbers",
        --     "--ignore-missing-imports",
        --     "--disable-error-code",
        --     "name-defined",
        --     "--cache-dir",
        --     "/dev/null",
        --   },
        -- },

        -- Format
        b.formatting.shellharden,
        b.formatting.prettierd,
        b.formatting.buf,
        b.formatting.stylua.with {
          extra_args = { "--config-path", vim.fs.normalize "~/.config/stylua/stylua.toml" },
        },
      }

      nls.setup {
        diagnostics_format = "[#{s}] #{c}: #{m}",
        sources = sources,
      }
    end,
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        config = function()
          local ls = require "luasnip"

          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_lua").load { paths = vim.fn.stdpath "config" .. "/snippets" }

          -- Expand or jump to next item
          map({ "i", "s" }, "<C-j>", function()
            if ls.expand_or_jumpable() then
              ls.expand_or_jump()
            end
          end)

          -- Jump to previous item
          map({ "i", "s" }, "<C-k>", function()
            if ls.jumpable(-1) then
              ls.jump(-1)
            end
          end)

          -- Selecting within a list of options.
          map("i", "<c-l>", function()
            if ls.choice_active() then
              ls.change_choice(1)
            end
          end)
        end,
      },
    },
    version = "1.*",
    event = "InsertEnter",
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      },
      completion = {
        list = {
          selection = {
            preselect = false,
            -- auto_insert = false,
          },
        },
        menu = {
          border = "none",
          winblend = 10,
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind", gap = 1 },
            },
          },
        },
        documentation = {
          auto_show = true,
          window = {
            winblend = 10,
          },
        },
      },
      signature = {
        enabled = true,
      },
      snippets = { preset = "luasnip" },
      cmdline = {
        -- C-y: accept the current item
        -- C-e: cancel completion
        completion = {
          menu = {
            auto_show = true,
          },
        },
      },
    },
  },
}
