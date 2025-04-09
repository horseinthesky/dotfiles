local map = require("config.utils").map

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "nvimtools/none-ls.nvim",
    },
    event = "BufReadPre",
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      {
        "L3MON4D3/LuaSnip",
        config = function()
          local ls = require "luasnip"

          ls.config.setup {
            -- This tells LuaSnip to remember to keep around the last snippet.
            -- You can jump back into it even if you move outside of the selection
            history = true,

            -- Updates as you type
            updateevents = "TextChanged,TextChangedI",
          }

          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath "config" .. "/lua/snippets" })

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
        ghost_text = {
          enabled = true,
        },
        menu = {
          border = "none",
          winblend = 10,
          draw = {
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind", gap = 1 },
            },
          },
        },

        list = {
          selection = {
            preselect = false,
          },
        },

        documentation = {
          auto_show = true,
          window = {
            winblend = 10,
          },
        },
      },

      snippets = { preset = "luasnip" },

      cmdline = {
        completion = {
          menu = {
            auto_show = true,
          },
          list = {
            selection = {
              preselect = false,
            },
          },
        },
      },
    },
  },
}
