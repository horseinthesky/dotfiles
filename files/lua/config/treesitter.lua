local swap_next, swap_prev = (function()
  local swap_objects = {
    c = "@class.outer",
    f = "@function.outer",
    b = "@block.outer",
    s = "@statement.outer",
    p = "@parameter.inner",
    m = "@call.outer",
  }

  local n, p = {}, {}
  for key, obj in pairs(swap_objects) do
    n[string.format("<leader>s%s", key)] = obj
    p[string.format("<leader>S%s", key)] = obj
  end

  return n, p
end)()

require "nvim-treesitter-textobjects"

require("nvim-treesitter.configs").setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = { "yaml" },
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
      -- Automatically jump forward to textobj, similar to targets.vim
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
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25,
    persist_queries = false,
  },
}
