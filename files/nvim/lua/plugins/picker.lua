local nmap = require("config.utils").nmap

local telescope_keymaps = {
  -- regular search mappings
  { "<leader>ff", "<CMD>Telescope find_files hidden=true<CR>" },
  -- {"<leader>fb", "<CMD>Telescope current_buffer_fuzzy_find<CR>"},
  -- {"<leader>fB", "<CMD>Telescope builtin previewer=false<CR>"},
  -- {"<leader>fh", "<CMD>Telescope help_tags<CR>"},
  -- {"<leader>fg", "<CMD>Telescope live_grep<CR>"},
  -- {"<leader>fw", "<CMD>Telescope grep_string<CR>"},
  { "<leader>fk", "<CMD>Telescope keymaps<CR>" },
  { "<leader>fo", "<CMD>Telescope vim_options<CR>" },
  { "<leader>fa", "<CMD>Telescope autocommands<CR>" },
  { "<leader>fH", "<CMD>Telescope highlights<CR>" },
  { "<leader>fc", "<CMD>Telescope colorscheme<CR>" },
  { "<leader>fS", "<CMD>Telescope symbols<CR>" },

  -- git search mappings
  -- {"<leader>gb", "<CMD>Telescope git_branches<CR>"},
  -- {"<leader>gc", "<CMD>Telescope git_commits<CR>"},
  -- {"<leader>gs", "<CMD>Telescope git_status<CR>"},

  -- lsp search mappings
  -- {"<leader>fld", "<CMD>Telescope diagnostics bufnr=0<CR>"},
  -- {"<leader>flD", "<CMD>Telescope diagnostics<CR>"},
  -- {"<leader>flr", "<CMD>Telescope lsp_references<CR>"},
  -- { "<leader>fli", "<CMD>Telescope lsp_implementations<CR>" },
  -- { "<leader>fls", "<CMD>Telescope lsp_document_symbols<CR>" },
  -- { "<leader>flS", "<CMD>Telescope lsp_workspace_symbols<CR>" },
  -- { "<leader>flci", "<CMD>Telescope lsp_incoming_calls<CR>" },
  -- { "<leader>flco", "<CMD>Telescope lsp_outgoing_calls<CR>" },

  -- extentions
  { "<leader>fp", "<CMD>Telescope project<CR>" },
}

for _, keymap in ipairs(telescope_keymaps) do
  local lhs, rhs, opts = unpack(keymap)
  nmap(lhs, rhs, opts)
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

local fzf_keymaps = {
  { ";", "<CMD>FzfLua files<CR>" },
  { "<leader>fg", "<CMD>FzfLua live_grep<CR>" },
  { "<leader>fw", "<CMD>FzfLua grep_cword<CR>" },
  { "<leader>fh", "<CMD>FzfLua help_tags<CR>" },
  { "<leader>fb", "<CMD>FzfLua blines<CR>" },
  { "<leader>fB", "<CMD>FzfLua builtin<CR>" },
  -- { "<leader>fk", "<CMD>FzfLua keymaps<CR>" },

  -- git search mappings
  { "<leader>gb", "<CMD>FzfLua git_branches<CR>" },
  { "<leader>gc", "<CMD>FzfLua git_commits<CR>" },
  { "<leader>gs", "<CMD>FzfLua git_status<CR>" },

  -- lsp search mappings
  { "<leader>fld", "<CMD>FzfLua lsp_document_diagnostics<CR>" },
  { "<leader>flD", "<CMD>FzfLua lsp_workspace_diagnostics<CR>" },
  { "<leader>flr", "<CMD>FzfLua lsp_references<CR>" },
  { "<leader>fli", "<CMD>FzfLua lsp_implementations<CR>" },
  { "<leader>fls", "<CMD>FzfLua lsp_document_symbols<CR>" },
  { "<leader>flS", "<CMD>FzfLua lsp_workspace_symbols<CR>" },
  { "<leader>flci", "<CMD>FzfLua lsp_incoming_calls<CR>" },
  { "<leader>flco", "<CMD>FzfLua lsp_outgoing_calls<CR>" },
}

for _, keymap in ipairs(fzf_keymaps) do
  local lhs, rhs, opts = unpack(keymap)
  nmap(lhs, rhs, opts)
end

local function projects()
  local work = "~/work/*"

  if vim.fn.empty(vim.fn.glob(work)) == 1 then
    return {}
  end

  return vim.split(vim.fn.glob(work), "\n")
end

return {
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
      require("telescope").setup {
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = require("telescope.actions").close,
              ["<C-J>"] = require("telescope.actions").move_selection_next,
              ["<C-K>"] = require("telescope.actions").move_selection_previous,
            },
          },
          sorting_strategy = "ascending",
          scroll_strategy = "cycle",
          prompt_prefix = " ",
          selection_caret = " ",
          layout_config = {
            prompt_position = "top",
            preview_cutoff = 80,
            horizontal = {
              width = 0.9,
              height = 0.9,
              preview_width = 0.6,
            },
          },
          winblend = 10,
        },
        extensions = {
          project = {
            base_dirs = projects(),
          },
        },
      }

      require("telescope").load_extension "fzf"
      require("telescope").load_extension "project"
    end,
  },
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    opts = {
      winopts = {
        height = 0.9,
        width = 0.9,
        backdrop = 100,
        preview = {
          layout = "horizontal",
          horizontal = "right:60%",
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
  },
}
