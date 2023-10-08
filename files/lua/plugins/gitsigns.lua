local map = require("utils").map

require("gitsigns").setup {
  signs = {
    add = { hl = "DiffAdd", text = " " },
    change = { hl = "DiffChange", text = " " },
    delete = { hl = "DiffDelete", text = " " },
    topdelete = { hl = "DiffDelete", text = " " },
    changedelete = { hl = "DiffChange", text = " " },
    untracked = { hl = "DiffAdd", text = " " },
  },
  on_attach = function(_)
    local gs = package.loaded.gitsigns

    -- Navigation
    map("n", "]h", function()
      if vim.wo.diff then
        return "]h"
      end
      gs.next_hunk()
    end)

    map("n", "[h", function()
      if vim.wo.diff then
        return "[h"
      end
      gs.prev_hunk()
    end)

    -- Actions
    map("n", "<leader>gh", gs.preview_hunk)
    map("n", "<leader>gw", gs.blame_line)
  end,
}

vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#b8bb26" })
vim.api.nvim_set_hl(0, "DiffChange", { link = "IncSearch" })
vim.api.nvim_set_hl(0, "DiffDelete", { link = "Error" })
