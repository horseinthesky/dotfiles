local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end
-- vim.cmd [[packadd packer.nvim]]
-- vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

local packer = require "packer"
local util = require "packer.util"

packer.init {
  compile_path = util.join_paths(vim.fn.stdpath "config", "packer", "packer_compiled.vim"),
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

packer.startup(function(use)
  use "wbthomason/packer.nvim"

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
  use {
    "nvim-lua/plenary.nvim",
    module = "plenary",
    opt = true,
  }
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/popup.nvim", opt = true },
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make", opt = true },
      { "nvim-telescope/telescope-symbols.nvim", opt = true },
    },
    module = "telescope",
    cmd = "Telescope",
    keys = { "<leader>f", "<leader>g" },
    wants = {
      "popup.nvim",
      "plenary.nvim",
      "telescope-fzf-native.nvim",
      "telescope-symbols.nvim",
    },
    config = function()
      require "config.telescope"
    end,
  }
  use {
    "junegunn/fzf.vim",
    requires = {
      {
        "junegunn/fzf",
        run = "./install --all --no-update-rc",
        opt = true,
      },
    },
    wants = "fzf",
    event = "BufRead",
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
    "rcarriga/nvim-notify",
    event = "BufRead",
    module = "notify",
    config = function()
      require "config.notify"
    end,
  }
  use {
    "folke/todo-comments.nvim",
    cmd = "TodoTelescope",
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
    event = "BufRead",
    config = function()
      require "config.hop"
    end,
  }
  use {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
    event = "BufRead",
  }
  use {
    "tpope/vim-surround",
    event = "BufRead",
  }

  -- Visuals
  use {
    "mhinz/vim-startify",
    event = "BufEnter",
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
  -- use {
  --   "sunjon/Shade.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require "config.shade"
  --   end,
  -- }
  use {
    "ntpeters/vim-better-whitespace",
    event = "BufRead",
  }

  -- Statusline
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
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons",
  }
  use {
    "famiu/feline.nvim",
    event = "BufRead",
    config = function()
      require "config.feline"
    end,
  }
  use {
    "romgrk/barbar.nvim",
    -- event = "BufReadPre",
    config = function()
      require "config.barbar"
    end,
  }
end)
