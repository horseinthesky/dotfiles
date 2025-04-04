return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "nvimtools/none-ls.nvim",
    },
    event = "BufReadPre",
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      {
        "L3MON4D3/LuaSnip",
        config = function()
          require "config.snippets"
        end,
      },
    },
    event = "InsertEnter",
    config = function()
      local cmp = require "cmp"

      local kind_icons = {
        TabNine = "",
        Text = "󰉿",
        Method = "󰊕",
        Function = "󰊕",
        Constructor = "",
        Field = "󰓹",
        Variable = "󰀫",
        Class = "󰆧",
        Interface = "",
        Module = "",
        Property = "󰓹",
        Unit = "",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "󰆼",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "",
        Version = "󰓹",
      }

      setmetatable(kind_icons, {
        __index = function()
          return "?"
        end,
      })

      cmp.setup {
        preselect = cmp.PreselectMode.None,
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          format = function(entry, vim_item)
            -- fancy icons and a name of kind
            vim_item.kind = kind_icons[vim_item.kind] .. " " .. vim_item.kind

            -- set a name for each source
            vim_item.menu = ({
              buffer = "[Buffer]",
              path = "[Path]",
              nvim_lsp = "[LSP]",
              nvim_lua = "[Lua]",
              crates = "[Crates]",
              luasnip = "[LuaSnip]",
              cmp_tabnine = "[TabNine]",
            })[entry.source.name]

            return vim_item
          end,
        },
        mapping = {
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ["<Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end,
          ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end,
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lua" },
          { name = "buffer" },
          { name = "path" },
          { name = "luasnip" },
          { name = "cmp_tabnine" },
          { name = "crates" },
        },
        completion = {
          keyword_length = 2,
        },
      }

      -- Use buffer source for '/'
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':'
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
  {
    "tzachar/cmp-tabnine",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    build = "./install.sh",
    event = "InsertEnter",
    config = function()
      local tabnine = require "cmp_tabnine"
      tabnine:setup {
        max_lines = 100,
        max_num_results = 5,
        sort = true,
      }
    end,
  },
}
