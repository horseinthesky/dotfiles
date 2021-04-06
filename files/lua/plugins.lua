local packer = require "packer"
local util = require "packer.util"

-- Auto install packer.nvim if not exists
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end
-- vim.cmd [[packadd packer.nvim]]
-- vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

packer.init {
  compile_path = util.join_paths(vim.fn.stdpath("config"), "packer", "packer_compiled.vim")
}

packer.startup(function(use)
  use "wbthomason/packer.nvim"

  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzy-native.nvim'},
      {'nvim-telescope/telescope-symbols.nvim'},
    },
  }

  -- LSP and completion
  use "neovim/nvim-lspconfig"
  use "hrsh7th/nvim-compe"
  use {"tzachar/compe-tabnine", run="./install.sh" }
  -- use "nvim-lua/completion-nvim"
  -- use "steelsojka/completion-buffers"
  -- use {"aca/completion-tabnine", run = "./install.sh"}
  -- lsp addons
  use "glepnir/lspsaga.nvim"
  use "onsails/lspkind-nvim"

  -- Features
  use {
    "junegunn/fzf.vim",
    requires = {
      "junegunn/fzf",
      run = "./install --all"
    }
  }
  use {
    "SirVer/ultisnips",
    requires = {"honza/vim-snippets"}
  }
  use "voldikss/vim-floaterm"
  use "liuchengxu/vim-which-key"
  use "dstein64/vim-startuptime"
  use "phaazon/hop.nvim"
  use {"mg979/vim-visual-multi", branch = "master"}
  use "gennaro-tedesco/nvim-peekup"
  use "tpope/vim-surround"
  use "tpope/vim-commentary"
  use "tpope/vim-repeat"
  use "tpope/vim-fugitive"
  use "majutsushi/tagbar"
  use "simnalamburt/vim-mundo"
  use {"kkoomen/vim-doge", run = ":call doge#install()"}
  use "will133/vim-dirdiff"
  use "AndrewRadev/linediff.vim"

  -- Visuals
  use "mhinz/vim-startify"
  use "morhetz/gruvbox"
  use "lifepillar/vim-solarized8"
  use "chrisbra/Colorizer"
  use {"lukas-reineke/indent-blankline.nvim", branch = "lua"}
  use "ntpeters/vim-better-whitespace"
  use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
  use "nvim-treesitter/playground"

  -- Statusine
  use {
    "glepnir/galaxyline.nvim",
    branch = "main",
    requires = {
      {
        "kyazdani42/nvim-web-devicons"
      },
      {
        "lewis6991/gitsigns.nvim",
        requires = {
          {
            "nvim-lua/plenary.nvim"
          }
        }
      }
    }
  }
  use "romgrk/barbar.nvim"
end)
