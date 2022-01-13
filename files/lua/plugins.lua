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
local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
end

vim.cmd [[packadd packer.nvim]]
vim.cmd [[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]]

-- packer.nvim configuration
local config = {
  compile_path = require("packer.util").join_paths(vim.fn.stdpath "config", "packer", "packer_compiled.vim"),
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
        "nvim-treesitter/playground",
        after = "nvim-treesitter",
        cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
      },
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        module = "nvim-treesitter-textobjects",
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

  -- Fuzzy search
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/popup.nvim", opt = true },
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make", opt = true },
      { "nvim-telescope/telescope-symbols.nvim", opt = true },
    },
    wants = {
      "popup.nvim",
      "plenary.nvim",
      "telescope-fzf-native.nvim",
      "telescope-symbols.nvim",
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
    config = function ()
      require "config.fzf"
    end,
  }

  -- UI
  use {
    "stevearc/dressing.nvim",
    event = "BufRead",
    config = function()
      vim.cmd [[highlight link FloatTitle Normal]]
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
      { "hrsh7th/cmp-calc", module = "cmp_calc" },
      { "hrsh7th/cmp-emoji", module = "cmp_emoji" },
      { "quangnguyen30192/cmp-nvim-ultisnips", module = "cmp_nvim_ultisnips" },
      {
        "tzachar/cmp-tabnine",
        run = "./install.sh",
        module = "cmp_tabnine",
      },
      { "honza/vim-snippets", opt = true },
      {
        "SirVer/ultisnips",
        opt = true,
        wants = "vim-snippets",
      },
    },
    event = "InsertEnter",
    wants = "ultisnips",
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
    event = "BufRead",
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
    "tpope/vim-surround",
    event = "BufRead",
  }

  -- Visuals
  use {
    "mhinz/vim-startify",
    cond = function()
      return vim.api.nvim_buf_get_name(0) == ""
    end,
  }
  use {
    "morhetz/gruvbox",
  }
  use {
    "folke/tokyonight.nvim",
  }
  use {
    "Glench/Vim-Jinja2-Syntax",
    ft = "jinja",
  }
  use {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
  }
  use {
    "ntpeters/vim-better-whitespace",
    event = "BufRead",
  }

  -- Statusline
  use {
    "famiu/feline.nvim",
    event = "BufRead",
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
