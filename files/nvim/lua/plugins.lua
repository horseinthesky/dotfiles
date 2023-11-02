local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- Lazy bootstrap
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

-- Plugins
local plugins = {
  -- Appearance
  {
    "stevearc/dressing.nvim",
    event = "BufRead",
    config = function()
      vim.api.nvim_set_hl(0, "FloatTitle", { link = "Normal" })
    end,
  },
  {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup { default = true }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
    },
    build = ":TSUpdate",
    event = "BufRead",
    config = function()
      require "plugins.treesitter"
    end,
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = function()
      require "plugins.gitsigns"
    end,
  },
  {
    "akinsho/git-conflict.nvim",
    lazy = false,
    config = function()
      vim.api.nvim_set_hl(0, "GitConflictCurrent", { bg = "#427b58" })
      vim.api.nvim_set_hl(0, "GitConflictIncoming", { bg = "#076678" })

      require("git-conflict").setup {
        disable_diagnostics = true,
        highlights = {
          current = "GitConflictCurrent",
          incoming = "GitConflictIncoming",
        },
      }
    end,
    cond = function()
      return vim.fn.empty(vim.fn.glob "./.git") == 0
    end,
  },

  -- Fuzzy search
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-telescope/telescope-project.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      {
        "AckslD/nvim-neoclip.lua",
        config = function()
          require("neoclip").setup {
            keys = {
              telescope = {
                i = {
                  paste = "<cr>",
                },
              },
            },
          }
        end,
      },
    },
    cmd = "Telescope",
    config = function()
      require "plugins.telescope"
    end,
  },
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    config = function()
      require "plugins.fzf"
    end,
  },

  -- LSP and completion
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "nvimtools/none-ls.nvim",
    },
    event = "BufReadPre",
    config = function()
      require "lsp"
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    config = function()
      require("lsp.rt").setup()
    end,
    ft = "rust",
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      {
        "L3MON4D3/LuaSnip",
        config = function()
          require "plugins.snippets"
        end,
      },
    },
    event = "InsertEnter",
    config = function()
      require "lsp.cmp"
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

  -- Features
  {
    "danymat/neogen",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("neogen").setup {
        enabled = true,
      }
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "BufRead",
    config = function()
      require "plugins.todo"
    end,
  },
  {
    "numToStr/FTerm.nvim",
    keys = { "<F3>", "<F4>" },
    config = function()
      require "plugins.fterm"
    end,
  },
  {
    "folke/which-key.nvim",
    event = "BufRead",
    config = function()
      require "plugins.which_key"
    end,
  },
  {
    "smoka7/hop.nvim",
    cmd = "HopChar1",
    config = function()
      require("hop").setup()
      vim.api.nvim_set_hl(0, "HopNextKey", { link = "Type" })
    end,
  },
  {
    "numToStr/Comment.nvim",
    keys = { "gc", "gcc", "gbc" },
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "kylechui/nvim-surround",
    event = "BufRead",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "ojroques/nvim-osc52",
  },
  {
    "Wansmer/treesj",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = "TSJToggle",
    config = function()
      require("treesj").setup()
    end,
  },
  {
    "luckasRanarison/nvim-devdocs",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = {
      "DevdocsFetch",
      "DevdocsInstall",
      "DevdocsUninstall",
      "DevdocsOpen",
      "DevdocsOpenFloat",
      "DevdocsOpenCurrent",
      "DevdocsOpenCurrentFloat",
      "DevdocsUpdate",
      "DevdocsUpdateAll",
    },
    config = function()
      require("nvim-devdocs").setup {
        ensure_installed = {
          "python-3.11",
          "go",
          "rust",
        },
        wrap = true,
        after_open = function(bufnr)
          vim.api.nvim_buf_set_keymap(bufnr, "n", "<Esc>", ":close<CR>", {})
        end,
      }
    end,
  },

  -- Languages support
  {
    "olexsmir/gopher.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = "go",
  },

  -- Visuals
  {
    "goolord/alpha-nvim",
    lazy = false,
    config = function()
      require "plugins.alpha"
    end,
    cond = function()
      return vim.api.nvim_buf_get_name(0) == ""
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 999,
    config = function()
      require("gruvbox").setup {
        italic = {
          strings = false,
          comments = false,
          operators = false,
          folds = false,
        },
      }
      require "highlights"
    end,
    cond = function()
      return vim.g.theme == "gruvbox"
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 999,
    config = function()
      vim.g.tokyonight_style = "storm"
      vim.g.tokyonight_italic_comments = false
      vim.g.tokyonight_italic_keywords = false
      require("tokyonight").colorscheme()
      require "highlights"
    end,
    cond = function()
      return vim.g.theme == "tokyonight"
    end,
  },
  {
    "Glench/Vim-Jinja2-Syntax",
    ft = "jinja",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require("ibl").setup {
        scope = {
          -- enabled = false,
          show_start = false,
          show_end = false,
        },
        indent = {
          char = { "", "¦", "┆", "┊" },
        },
      }
    end,
  },

  -- Statusline
  {
    "famiu/feline.nvim",
    event = "VimEnter",
    config = function()
      require "plugins.feline"
    end,
  },
  {
    "akinsho/bufferline.nvim",
    event = "BufReadPre",
    config = function()
      require "plugins.bufferline"
    end,
  },
}

-- Options
local options = {
  defaults = { lazy = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    border = "rounded",
    icons = {
      start = "",
      event = "",
      cmd = "",
      ft = "",
    },
  },
}

-- Setup
require("lazy").setup(plugins, options)
vim.keymap.set("n", "<leader>L", "<cmd>Lazy<CR>")
