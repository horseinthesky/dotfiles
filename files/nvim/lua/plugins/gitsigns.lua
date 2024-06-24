local map = require("utils").map

require("gitsigns").setup {
  signs = {
    add = { text = " " },
    change = { text = " " },
    delete = { text = " " },
    topdelete = { text = " " },
    changedelete = { text = " " },
    untracked = { text = " " },
  },
  on_attach = function(_)
    local gs = require "gitsigns"

    -- Navigation
    map("n", "]h", function()
      if vim.wo.diff then
        vim.cmd.normal { "]h", bang = true }
      else
        gs.nav_hunk "next"
      end
    end)

    map("n", "[h", function()
      if vim.wo.diff then
        vim.cmd.normal { "[h", bang = true }
      else
        gs.nav_hunk "prev"
      end
    end)

    -- Actions
    map("n", "<leader>gh", gs.preview_hunk)
    map("n", "<leader>gw", gs.blame_line)
  end,
}

-- Base colors
vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#b8bb26" })
vim.api.nvim_set_hl(0, "DiffChange", { link = "IncSearch" })
vim.api.nvim_set_hl(0, "DiffDelete", { link = "Error" })

-- GitSigns colors
vim.api.nvim_set_hl(0, "GitSignsAdd", { link = "DiffAdd" })
vim.api.nvim_set_hl(0, "GitSignsChange", { link = "DiffChange" })
vim.api.nvim_set_hl(0, "GitSignsChangedelete", { link = "DiffChange" })
vim.api.nvim_set_hl(0, "GitSignsDelete", { link = "DiffDelete" })
vim.api.nvim_set_hl(0, "GitSignsChangeDelete", { link = "DiffDelete" })
vim.api.nvim_set_hl(0, "GitSignsTopDelete", { link = "DiffDelete" })
