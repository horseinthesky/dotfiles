-- ==== Lazy
-- Bootstrap
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
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
    event = "VeryLazy",
    config = function()
      vim.api.nvim_set_hl(0, "FloatTitle", { link = "Normal" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
    },
    build = ":TSUpdate",
    event = "VeryLazy",
    config = function()
      require "plugins.treesitter"
    end,
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
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

  -- LSP
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
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-emoji",
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

  -- Languages addons
  {
    "danymat/neogen",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("neogen").setup()
    end,
  },
  {
    "olexsmir/gopher.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = "go",
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup {
        completion = {
          cmp = {
            enabled = true,
          },
        },
        popup = {
          autofocus = true,
        },
      }
    end,
  },

  -- Features
  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
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
    "smoka7/hop.nvim",
    cmd = "HopChar1",
    config = function()
      require("hop").setup()
      vim.api.nvim_set_hl(0, "HopNextKey", { link = "Type" })
    end,
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
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
    build = ":DevdocsFetch",
    cmd = "DevdocsOpenCurrentFloat",
    config = function()
      require("nvim-devdocs").setup {
        ensure_installed = {
          "python-3.11",
          "go",
          "rust",
        },
        wrap = true,
        after_open = function(bufnr)
          vim.api.nvim_buf_set_keymap(bufnr, "n", "<Esc>", "<CMD>close<CR>", {})
        end,
      }
    end,
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Oil",
    config = function()
      require("oil").setup {
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
      }
    end,
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
    "folke/which-key.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require "plugins.which_key"
    end,
  },
  {
    "Glench/Vim-Jinja2-Syntax",
    ft = "jinja",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
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

  -- Themes
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

  -- Statusline
  {
    "freddiehaddad/feline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require "plugins.feline"
    end,
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
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
      event = "󰌵",
      cmd = "",
      ft = "",
    },
  },
}

-- Setup
require("lazy").setup(plugins, options)
vim.keymap.set("n", "<leader>L", "<CMD>Lazy<CR>")

-- ==== Plugins keymaps
local map = require("utils").map

-- Telescope
local telescope_mappings = {
  -- regular search mappings
  { "n", "<leader>ff", "<CMD>Telescope find_files hidden=true<CR>" },
  -- {"n", "<leader>fB", "<CMD>Telescope builtin previewer=false<CR>"},
  -- {"n", "<leader>fb", "<CMD>Telescope buffers<CR>"},
  -- {"n", "<leader>fe", "<CMD>Telescope current_buffer_fuzzy_find<CR>"},
  -- {"n", "<leader>fh", "<CMD>Telescope help_tags<CR>"},
  -- {"n", "<leader>fg", "<CMD>Telescope live_grep<CR>"},
  -- {"n", "<leader>fw", "<CMD>Telescope grep_string<CR>"},
  { "n", "<leader>fr", "<CMD>Telescope registers<CR>" },
  -- {"n", "<leader>fm", "<CMD>Telescope marks<CR>"},
  { "n", "<leader>fk", "<CMD>Telescope keymaps<CR>" },
  -- {"n", "<leader>fO", "<CMD>Telescope oldfiles<CR>"},
  { "n", "<leader>fc", "<CMD>Telescope commands<CR>" },
  { "n", "<leader>fo", "<CMD>Telescope vim_options<CR>" },
  { "n", "<leader>fa", "<CMD>Telescope autocommands<CR>" },
  { "n", "<leader>fH", "<CMD>Telescope highlights<CR>" },
  { "n", "<leader>fC", "<CMD>Telescope colorscheme<CR>" },
  { "n", "<leader>fS", "<CMD>Telescope symbols<CR>" },

  -- git search mappings
  -- {"n", "<leader>gb", "<CMD>Telescope git_branches<CR>"},
  -- {"n", "<leader>gc", "<CMD>Telescope git_commits<CR>"},
  -- {"n", "<leader>gs", "<CMD>Telescope git_status<CR>"},

  -- lsp search mappings
  -- {"n", "<leader>fld", "<CMD>Telescope diagnostics bufnr=0<CR>"},
  -- {"n", "<leader>flD", "<CMD>Telescope diagnostics<CR>"},
  -- {"n", "<leader>flr", "<CMD>Telescope lsp_references<CR>"},
  -- { "n", "<leader>fli", "<CMD>Telescope lsp_implementations<CR>" },
  -- { "n", "<leader>fls", "<CMD>Telescope lsp_document_symbols<CR>" },
  -- { "n", "<leader>flS", "<CMD>Telescope lsp_workspace_symbols<CR>" },
  -- { "n", "<leader>flci", "<CMD>Telescope lsp_incoming_calls<CR>" },
  -- { "n", "<leader>flco", "<CMD>Telescope lsp_outgoing_calls<CR>" },

  -- extentions
  { "n", "<leader>fp", "<CMD>Telescope project<CR>" },
}

for _, keymap in ipairs(telescope_mappings) do
  local mode, lhs, rhs, opts = unpack(keymap)
  map(mode, lhs, rhs, opts)
end

local hls = {
  TelescopeResultsNormal = "SpecialKey",
  TelescopeSelectionCaret = "WarningMsg",
  TelescopeSelection = "TelescopeNormal",
  TelescopeMultiSelection = "TelescopeResultsNormal",
  TelescopeMatching = "Type",
  TelescopePromptPrefix = "Type",
}

for group, link in pairs(hls) do
  vim.api.nvim_set_hl(0, group, { link = link })
end

-- fzf-lua
local fzf_mappings = {
  { "n", ";",            "<CMD>FzfLua files<CR>" },
  { "n", "<leader>fg",   "<CMD>FzfLua live_grep<CR>" },
  { "n", "<leader>fw",   "<CMD>FzfLua grep_cword<CR>" },
  { "n", "<leader>fh",   "<CMD>FzfLua help_tags<CR>" },
  { "n", "<leader>fb",   "<CMD>FzfLua buffers<CR>" },
  { "n", "<leader>ft",   "<CMD>FzfLua tabs<CR>" },
  { "n", "<leader>fB",   "<CMD>FzfLua builtin<CR>" },
  { "n", "<leader>fe",   "<CMD>FzfLua blines<CR>" },
  { "n", "<leader>fE",   "<CMD>FzfLua lines<CR>" },
  -- {"n", "<leader>fr", "<CMD>FzfLua registers<CR>"},
  { "n", "<leader>fm",   "<CMD>FzfLua marks<CR>" },
  -- { "n", "<leader>fk", "<CMD>FzfLua keymaps<CR>" },
  -- {"n", "<leader>fc", "<CMD>FzfLua commands<CR>"},
  { "n", "<leader>fO",   "<CMD>FzfLua oldfiles<CR>" },

  -- git search mappings
  { "n", "<leader>gb",   "<CMD>FzfLua git_branches<CR>" },
  { "n", "<leader>gc",   "<CMD>FzfLua git_commits<CR>" },
  { "n", "<leader>gs",   "<CMD>FzfLua git_status<CR>" },

  -- lsp search mappings
  { "n", "<leader>fld",  "<CMD>FzfLua lsp_document_diagnostics<CR>" },
  { "n", "<leader>flD",  "<CMD>FzfLua lsp_workspace_diagnostics<CR>" },
  { "n", "<leader>flr",  "<CMD>FzfLua lsp_references<CR>" },
  { "n", "<leader>fli",  "<CMD>FzfLua lsp_implementations<CR>" },
  { "n", "<leader>fls",  "<CMD>FzfLua lsp_document_symbols<CR>" },
  { "n", "<leader>flS",  "<CMD>FzfLua lsp_workspace_symbols<CR>" },
  { "n", "<leader>flci", "<CMD>FzfLua lsp_incoming_calls<CR>" },
  { "n", "<leader>flco", "<CMD>FzfLua lsp_outgoing_calls<CR>" },
}

for _, keymap in ipairs(fzf_mappings) do
  local mode, lhs, rhs, opts = unpack(keymap)
  map(mode, lhs, rhs, opts)
end

-- neogen
map("n", "<leader>af", function()
  require("neogen").generate { type = "func" }
end)
map("n", "<leader>ac", function()
  require("neogen").generate { type = "class" }
end)
map("n", "<leader>at", function()
  require("neogen").generate { type = "type" }
end)

-- hop
map("n", "f", "<CMD>HopChar1<CR>")

-- treesj
map("n", "gj", "<CMD>TSJToggle<CR>")

-- devdocs
map("n", "<leader>fd", "<CMD>DevdocsOpenCurrentFloat<CR>")

-- indentline
map("n", "<leader>I", "<CMD>IBLToggle<CR>")

-- oil
map("n", "-", "<CMD>Oil<CR>")
