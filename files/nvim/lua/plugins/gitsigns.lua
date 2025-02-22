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
