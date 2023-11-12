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
    event = "BufRead",
    config = function()
      vim.api.nvim_set_hl(0, "FloatTitle", { link = "Normal" })
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup {}
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
    "simrat39/rust-tools.nvim",
    ft = "rust",
    config = function()
      require("lsp.rt").setup()
    end,
  },

  -- Features
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
          vim.api.nvim_buf_set_keymap(bufnr, "n", "<Esc>", ":close<CR>", {})
        end,
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
    event = "BufRead",
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
      event = "󰌵",
      cmd = "",
      ft = "",
    },
  },
}

-- Setup
require("lazy").setup(plugins, options)
vim.keymap.set("n", "<leader>L", "<cmd>Lazy<CR>")

-- ==== Plugins keymaps
local map = require("utils").map

-- Telescope
local telescope_mappings = {
  -- regular search mappings
  { "n", "<leader>ff", "<cmd>Telescope find_files hidden=true<CR>" },
  -- {"n", "<leader>fB", "<cmd>Telescope builtin previewer=false<CR>"},
  -- {"n", "<leader>fb", "<cmd>Telescope buffers<CR>"},
  -- {"n", "<leader>fe", "<cmd>Telescope current_buffer_fuzzy_find<CR>"},
  -- {"n", "<leader>fh", "<cmd>Telescope help_tags<CR>"},
  -- {"n", "<leader>fg", "<cmd>Telescope live_grep<CR>"},
  -- {"n", "<leader>fw", "<cmd>Telescope grep_string<CR>"},
  { "n", "<leader>fr", "<cmd>Telescope registers<CR>" },
  -- {"n", "<leader>fm", "<cmd>Telescope marks<CR>"},
  { "n", "<leader>fk", "<cmd>Telescope keymaps<CR>" },
  -- {"n", "<leader>fO", "<cmd>Telescope oldfiles<CR>"},
  { "n", "<leader>fc", "<cmd>Telescope commands<CR>" },
  { "n", "<leader>fo", "<cmd>Telescope vim_options<CR>" },
  { "n", "<leader>fa", "<cmd>Telescope autocommands<CR>" },
  { "n", "<leader>fH", "<cmd>Telescope highlights<CR>" },
  { "n", "<leader>fC", "<cmd>Telescope colorscheme<CR>" },
  { "n", "<leader>fS", "<cmd>Telescope symbols<CR>" },

  -- git search mappings
  -- {"n", "<leader>gb", "<cmd>Telescope git_branches<CR>"},
  -- {"n", "<leader>gc", "<cmd>Telescope git_commits<CR>"},
  -- {"n", "<leader>gs", "<cmd>Telescope git_status<CR>"},

  -- lsp search mappings
  -- {"n", "<leader>fld", "<cmd>Telescope diagnostics bufnr=0<CR>"},
  -- {"n", "<leader>flD", "<cmd>Telescope diagnostics<CR>"},
  -- {"n", "<leader>flr", "<cmd>Telescope lsp_references<CR>"},
  -- { "n", "<leader>fli", "<cmd>Telescope lsp_implementations<CR>" },
  -- { "n", "<leader>fls", "<cmd>Telescope lsp_document_symbols<CR>" },
  -- { "n", "<leader>flS", "<cmd>Telescope lsp_workspace_symbols<CR>" },
  -- { "n", "<leader>flci", "<cmd>Telescope lsp_incoming_calls<CR>" },
  -- { "n", "<leader>flco", "<cmd>Telescope lsp_outgoing_calls<CR>" },

  -- extentions
  { "n", "<leader>fp", "<cmd>Telescope project<CR>" },
  { "n", "<leader>fP", "<cmd>Telescope neoclip<CR>" },
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
  { "n", ";", "<cmd>FzfLua files<CR>" },
  { "n", "<leader>fg", "<cmd>FzfLua live_grep<CR>" },
  { "n", "<leader>fw", "<cmd>FzfLua grep_cword<CR>" },
  { "n", "<leader>fh", "<cmd>FzfLua help_tags<CR>" },
  { "n", "<leader>fb", "<cmd>FzfLua buffers<CR>" },
  { "n", "<leader>ft", "<cmd>FzfLua tabs<CR>" },
  { "n", "<leader>fB", "<cmd>FzfLua builtin<CR>" },
  { "n", "<leader>fe", "<cmd>FzfLua blines<CR>" },
  { "n", "<leader>fE", "<cmd>FzfLua lines<CR>" },
  -- {"n", "<leader>fr", "<cmd>FzfLua registers<CR>"},
  { "n", "<leader>fm", "<cmd>FzfLua marks<CR>" },
  -- { "n", "<leader>fk", "<cmd>FzfLua keymaps<CR>" },
  -- {"n", "<leader>fc", "<cmd>FzfLua commands<CR>"},
  { "n", "<leader>fO", "<cmd>FzfLua oldfiles<CR>" },

  -- git search mappings
  { "n", "<leader>gb", "<cmd>FzfLua git_branches<CR>" },
  { "n", "<leader>gc", "<cmd>FzfLua git_commits<CR>" },
  { "n", "<leader>gs", "<cmd>FzfLua git_status<CR>" },

  -- lsp search mappings
  { "n", "<leader>fld", "<cmd>FzfLua lsp_document_diagnostics<CR>" },
  { "n", "<leader>flD", "<cmd>FzfLua lsp_workspace_diagnostics<CR>" },
  { "n", "<leader>flr", "<cmd>FzfLua lsp_references<CR>" },
  { "n", "<leader>fli", "<cmd>FzfLua lsp_implementations<CR>" },
  { "n", "<leader>fls", "<cmd>FzfLua lsp_document_symbols<CR>" },
  { "n", "<leader>flS", "<cmd>FzfLua lsp_workspace_symbols<CR>" },
  { "n", "<leader>flci", "<cmd>FzfLua lsp_incoming_calls<CR>" },
  { "n", "<leader>flco", "<cmd>FzfLua lsp_outgoing_calls<CR>" },
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
map("n", "f", "<cmd>HopChar1<CR>")

-- osc52
map("n", "<leader>C", require("osc52").copy_operator, { expr = true })
map("n", "<leader>CC", "<leader>C_", { remap = true })
map("x", "<leader>C", require("osc52").copy_visual)

-- treesj
map("n", "gj", "<cmd>TSJToggle<CR>")

-- devdocs
map("n", "<leader>fd", "<cmd>DevdocsOpenCurrentFloat<CR>")

-- indentline
map("n", "<leader>I", "<cmd>IBLToggle<CR>")
