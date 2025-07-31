local nmap = require("config.utils").nmap

---- Keymaps
-- bufferline
for buffer = 1, 9 do
  nmap("<leader>" .. buffer, "<cmd>BufferLineGoToBuffer " .. buffer .. "<CR>")
end

return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    opts = {
      winopts = {
        fullscreen = true,
        preview = {
          layout = "horizontal",
          horizontal = "right:70%",
        },
      },
      keymap = {
        builtin = {
          ["<C-p>"] = "toggle-preview",
          ["<C-f>"] = "toggle-fullscreen",
          ["<C-d>"] = "preview-page-down",
          ["<C-u>"] = "preview-page-up",
        },
      },
      fzf_opts = {
        ["--info"] = "default",
      },
    },
    keys = {
      { ";", "<CMD>FzfLua files<CR>", desc = "Find files" },
    },
  },
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    opts = {
      signs = true,
      keywords = {
        PERF = { color = "perf" },
        HACK = { color = "hack" },
      },
      colors = {
        error = "Statement",
        warning = "Type",
        info = "Identifier",
        hint = "PreProc",
        perf = "Number",
        hack = "Special",
      },
    },
  },
  {
    "smoka7/hop.nvim",
    cmd = "HopChar1",
    config = function()
      require("hop").setup()
      vim.api.nvim_set_hl(0, "HopNextKey", { link = "Type" })
    end,
    keys = {
      { "f", "<CMD>HopChar1<CR>", desc = "Hop" },
    },
  },
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    opts = {
      use_default_keymaps = false,
      keymaps = {
        ["q"] = "actions.close",
        ["?"] = "actions.show_help",
        ["_"] = "actions.open_cwd",
        ["."] = "actions.toggle_hidden",
        ["<CR>"] = "actions.select",
        ["<BS>"] = "actions.parent",
        ["<C-h>"] = "actions.select_split",
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-r>"] = "actions.refresh",
      },
    },
    keys = {
      { "-", "<CMD>Oil<CR>", desc = "Oil" },
    },
  },
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      require("mini.surround").setup {}
      require("mini.splitjoin").setup {
        mappings = {
          toggle = "gs",
        },
      }
    end,
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        mode = "tabs",
        always_show_bufferline = false,
        show_buffer_icons = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        modified_icon = "",
        show_tab_indicators = false,
        tab_size = 5,
        numbers = function(opts)
          if vim.api.nvim_get_current_tabpage() == opts.id then
            return ""
          end

          return opts.ordinal
        end,
      },
      highlights = {
        indicator_selected = {
          fg = {
            attribute = "fg",
            highlight = "Type",
          },
        },
        numbers = {
          fg = {
            attribute = "fg",
            highlight = "Type",
          },
        },
        buffer_selected = {
          italic = false,
        },
        pick = {
          italic = false,
        },
        pick_selected = {
          italic = false,
        },
        duplicate = {
          italic = false,
        },
        duplicate_selected = {
          italic = false,
        },
      },
    },
    keys = {
      { "<leader>bp", "<cmd>BufferLinePick<CR>", desc = "Pick" },
    },
  },
  {
    "OXY2DEV/markview.nvim",
    ft = "markdown",
    opts = {
      preview = {
        hybrid_modes = { "n" },
      },
      markdown = {
        list_items = {
          shift_width = 2,
        },
      },
    },
    keys = {
      { "<leader>M", "<CMD>Markview<CR>", desc = "Markview toggle" },
      { "<leader>ms", "<CMD>Markview splitToggle<CR>", desc = "Split" },
    },
  },
  {
    "danymat/neogen",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
    keys = {
      {
        "<leader>af",
        function()
          require("neogen").generate { type = "func" }
        end,
        desc = "Fuction",
      },
      {
        "<leader>ac",
        function()
          require("neogen").generate { type = "class" }
        end,
        desc = "Class",
      },
      {
        "<leader>at",
        function()
          require("neogen").generate { type = "type" }
        end,
        desc = "Type",
      },
    },
  },
}
