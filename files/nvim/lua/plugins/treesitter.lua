local nmap = require("config.utils").nmap

local swap_next, swap_prev = (function()
  local swap_objects = {
    b = "@block.outer",
    c = "@class.outer",
    f = "@function.outer",
    m = "@call.outer",
    p = "@parameter.inner",
    s = "@statement.outer",
  }

  local n, p = {}, {}
  for key, obj in pairs(swap_objects) do
    n[string.format("<leader>s%s", key)] = obj
    p[string.format("<leader>S%s", key)] = obj
  end

  return n, p
end)()

local parsers = {
  "bash",
  "dockerfile",
  "go",
  "gomod",
  "gosum",
  "hcl",
  "json",
  "just",
  "lua",
  "make",
  "markdown",
  "python",
  "rust",
  "toml",
  "yaml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
    },
    build = ":TSUpdate",
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = parsers,
        highlight = {
          enable = true,
          disable = function(lang, buf)
            -- Do not use treesitter for files larger than 1 MB
            local max_filesize = 1000 * 1024
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<enter>",
            node_incremental = "<enter>",
            node_decremental = "<bs>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["oc"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["of"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ob"] = "@block.outer",
              ["ib"] = "@block.inner",
              ["ol"] = "@loop.outer",
              ["il"] = "@loop.inner",
              ["os"] = "@statement.outer",
              ["is"] = "@statement.inner",
              ["oC"] = "@comment.outer",
              ["iC"] = "@comment.inner",
              ["om"] = "@call.outer",
              ["im"] = "@call.inner",
            },
          },
          swap = {
            enable = true,
            swap_next = swap_next,
            swap_previous = swap_prev,
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]C"] = "@class.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[C"] = "@class.outer",
            },
          },
        },
      }

      require("treesitter-context").setup()
      nmap("<leader>O", require("treesitter-context").toggle, { desc = "Treesitter context toggle" })
    end,
  },
}
