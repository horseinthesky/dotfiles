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
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/popup.nvim", opt = true },
      { "nvim-lua/plenary.nvim", opt = true },
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make", opt = true },
      { "nvim-telescope/telescope-symbols.nvim", opt = true },
    },
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
        run="./install --all",
        opt = true
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
        "glepnir/lspsaga.nvim",
        after = "nvim-lspconfig",
        config = function()
          require "config.lspsaga"
        end,
      },
      {
        "onsails/lspkind-nvim",
        after = "nvim-lspconfig",
        config = function()
          require("lspkind").init {
            symbol_map = {
              Class = "",
            },
          }
        end,
      },
    },
    event = "BufReadPre",
    config = function()
      require "lsp"
    end,
  }
  use {
    "ray-x/lsp_signature.nvim",
    module = "lsp_signature",
  }
  use {
    "hrsh7th/nvim-compe",
    requires = {
      {
        "tzachar/compe-tabnine",
        run = "./install.sh",
        module = "compe_tabnine",
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
      require "config.compe"
    end,
  }

  -- Features
  use {
    "folke/todo-comments.nvim",
    cmd = "TodoTelescope",
    event = "BufRead",
    config = function()
      require "config.todo"
    end,
  }
  use {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
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
    "mg979/vim-visual-multi",
    branch = "master",
    event = "BufRead",
  }
  use {
    "tpope/vim-surround",
    event = "BufRead",
  }
  use {
    "tpope/vim-commentary",
    event = "BufRead",
  }
  use {
    "tpope/vim-repeat",
    event = "BufRead",
  }
  use {
    "tpope/vim-fugitive",
    cmd = "Gvdiffsplit",
  }
  use {
    "simnalamburt/vim-mundo",
    cmd = "MundoToggle",
  }
  use {
    "kkoomen/vim-doge",
    run = ":call doge#install()",
    keys = "<leader>d",
  }
  use {
    "AndrewRadev/linediff.vim",
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
    "lifepillar/vim-solarized8",
  }
  use {
    "Glench/Vim-Jinja2-Syntax",
    ft = "jinja",
  }
  use {
    "chrisbra/Colorizer",
    event = "BufRead",
  }
  use {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
  }
  -- use {
  --   "sunjon/Shade.nvim",
  --   event = "BufRead",
  -- }
  use {
    "ntpeters/vim-better-whitespace",
    event = "BufRead",
  }

  -- Statusine
  use {
    "glepnir/galaxyline.nvim",
    branch = "main",
    requires = {
      {
        "kyazdani42/nvim-web-devicons",
        module = "nvim-web-devicons",
      },
      {
        "lewis6991/gitsigns.nvim",
        requires = {
          {
            "nvim-lua/plenary.nvim",
            opt = true,
          },
        },
        wants = "plenary.nvim",
        module = "gitsigns",
        config = function()
          require "config.gitsigns"
        end,
      },
    },
    event = "BufRead",
    wants = {
      "nvim-web-devicons",
      "gitsigns.nvim",
    },
    config = function()
      require "statusline"
    end,
  }
  use {
    "romgrk/barbar.nvim",
    requires = {
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
    },
    -- event = "BufReadPre",
    wants = "nvim-web-devicons",
    config = function()
      require "config.barbar"
    end,
  }
end)
