local map = require("utils").map

-- Packer keymappings
local mappings = {
  { "n", "<leader>pi", "<cmd>PackerInstall<cr>" },
  { "n", "<leader>pc", "<cmd>PackerCompile<cr>" },
  { "n", "<leader>pu", "<cmd>PackerUpdate<cr>" },
  { "n", "<leader>ps", "<cmd>PackerSync<cr>" },
  { "n", "<leader>pt", "<cmd>PackerStatus<cr>" },
}

for _, keymap in ipairs(mappings) do
  local mode, lhs, rhs, opts = unpack(keymap)
  map(mode, lhs, rhs, opts)
end

-- Indicate first time installation
local packer_bootstrap = false

-- Check if packer.nvim is installed
-- Run PackerCompile if there are changes in this file
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
end

vim.cmd [[packadd packer.nvim]]
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "plugins.lua",
  command = "source <afile> | PackerCompile",
})

-- packer.nvim configuration
local config = {
  compile_path = require("packer.util").join_paths(vim.fn.stdpath "config", "packer", "packer_compiled.lua"),
  profile = {
    enable = true,
    threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  },
  display = {
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
  },
}

local function plugins(use)
  use {
    "wbthomason/packer.nvim",
    opt = true,
  }

  -- Helpers
  use {
    "stevearc/dressing.nvim",
    event = "BufRead",
    config = function()
      vim.api.nvim_set_hl(0, "FloatTitle", { link = "Normal" })
    end,
  }
  use {
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup { default = true }
    end,
  }
  use {
    "nvim-lua/plenary.nvim",
    module = "plenary",
    opt = true,
  }
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    requires = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        module = "nvim-treesitter-textobjects",
      },
      {
        "nvim-treesitter/playground",
        after = "nvim-treesitter",
      },
      {
        "nvim-treesitter/nvim-treesitter-context",
        after = "nvim-treesitter",
      },
    },
    event = "BufRead",
    config = function()
      require "config.treesitter"
    end,
  }

  -- Git
  use {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    wants = "plenary.nvim",
    module = "gitsigns",
    config = function()
      require "config.gitsigns"
    end,
  }
  use {
    "akinsho/git-conflict.nvim",
    config = function()
      require("git-conflict").setup {
        disable_diagnostics = true,
      }
    end,
    cond = function()
      return vim.fn.empty(vim.fn.glob "./.git") == 0
    end,
  }

  -- Fuzzy search
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/popup.nvim", opt = true },
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make", opt = true },
      { "nvim-telescope/telescope-symbols.nvim", opt = true },
      { "nvim-telescope/telescope-project.nvim", opt = true },
      {
        "AckslD/nvim-neoclip.lua",
        opt = true,
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
    wants = {
      "popup.nvim",
      "plenary.nvim",
      "telescope-fzf-native.nvim",
      "telescope-symbols.nvim",
      "telescope-project.nvim",
      "nvim-neoclip.lua",
    },
    cmd = { "Telescope" },
    config = function()
      require "config.telescope"
    end,
  }
  use {
    "ibhagwan/fzf-lua",
    cmd = { "FzfLua" },
    wants = "nvim-web-devicons",
    config = function()
      require "config.fzf"
    end,
  }

  -- LSP and completion
  use {
    "neovim/nvim-lspconfig",
    requires = {
      {
        "jose-elias-alvarez/null-ls.nvim",
        module = "null-ls",
      },
    },
    event = "BufReadPre",
    config = function()
      require "lsp"
    end,
  }
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      { "hrsh7th/cmp-buffer", module = "cmp_buffer" },
      { "hrsh7th/cmp-path", module = "cmp_path" },
      { "hrsh7th/cmp-nvim-lsp", module = "cmp_nvim_lsp" },
      { "hrsh7th/cmp-nvim-lua", module = "cmp_nvim_lua" },
      { "hrsh7th/cmp-cmdline", module = "cmp_cmdline" },
      { "hrsh7th/cmp-emoji", module = "cmp_emoji" },
      { "saadparwaiz1/cmp_luasnip", module = "cmp_luasnip" },
      {
        "tzachar/cmp-tabnine",
        run = "./install.sh",
        module = "cmp_tabnine",
      },
      { "rafamadriz/friendly-snippets", module = "friendly-snippets" },
      {
        "L3MON4D3/LuaSnip",
        wants = "friendly-snippets",
        module = "luasnip",
        config = function()
          require "config.snippets"
        end,
      },
    },
    event = "InsertEnter",
    wants = "LuaSnip",
    config = function()
      require "lsp.cmp"
    end,
  }

  -- Features
  use {
    "danymat/neogen",
    wants = "nvim-treesitter",
    module = "neogen",
    config = function()
      require("neogen").setup {
        enabled = true,
      }
    end,
  }
  use {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require "config.todo"
    end,
  }
  use {
    "numToStr/FTerm.nvim",
    keys = { "<F3>", "<F4>" },
    config = function()
      require "config.fterm"
    end,
  }
  use {
    "folke/which-key.nvim",
    event = "BufRead",
    config = function()
      require "config.which_key"
    end,
  }
  use {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  }
  use {
    "phaazon/hop.nvim",
    cmd = "HopChar1",
    config = function()
      require("hop").setup()
    end,
  }
  use {
    "numToStr/Comment.nvim",
    keys = { "gc", "gcc", "gbc" },
    config = function()
      require("Comment").setup()
    end,
  }
  use {
    "kylechui/nvim-surround",
    event = "BufRead",
    config = function()
      require("nvim-surround").setup()
    end,
  }
  use {
    "ojroques/nvim-osc52",
    module = "osc52",
  }

  -- Languages support
  use {
    "olexsmir/gopher.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = "go",
  }

  -- Visuals
  use {
    "goolord/alpha-nvim",
    wants = "nvim-web-devicons",
    config = function()
      require "config.alpha"
    end,
    cond = function()
      return vim.api.nvim_buf_get_name(0) == ""
    end,
  }
  use {
    "ellisonleao/gruvbox.nvim",
    config = function()
      require("gruvbox").setup {
        italic = false,
      }
      require "colorscheme"
    end,
    cond = function()
      return vim.g.theme == "gruvbox"
    end,
  }
  use {
    "folke/tokyonight.nvim",
    config = function()
      vim.g.tokyonight_style = "storm"
      vim.g.tokyonight_italic_comments = false
      vim.g.tokyonight_italic_keywords = false
      require("tokyonight").colorscheme()
      require "colorscheme"
    end,
    cond = function()
      return vim.g.theme == "tokyonight"
    end,
  }
  use {
    "Glench/Vim-Jinja2-Syntax",
    ft = "jinja",
  }
  use {
    "lukas-reineke/indent-blankline.nvim",
    after = "nvim-treesitter",
  }
  use {
    "ntpeters/vim-better-whitespace",
    event = "BufRead",
  }

  -- Statusline
  use {
    "famiu/feline.nvim",
    event = "VimEnter",
    config = function()
      require "config.feline"
    end,
  }
  use {
    "akinsho/bufferline.nvim",
    wants = "nvim-web-devicons",
    event = "BufReadPre",
    config = function()
      require "config.bufferline"
    end,
  }

  if packer_bootstrap then
    require("packer").sync()
  end
end

local packer = require "packer"
packer.init(config)
packer.startup(plugins)
