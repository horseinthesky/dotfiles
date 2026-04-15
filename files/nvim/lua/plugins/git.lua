local utils = require "config.utils"

return {
  {
    "lewis6991/gitsigns.nvim",
    dir = utils.ternary(
      utils.is_yandex,
      "~/arcadia/contrib/tier1/gitsigns.arc.nvim",
      vim.fn.stdpath "data" .. "/lazy/gitsigns.nvim"
    ),
    lazy = false,
    opts = {
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
        utils.nmap("]h", function()
          if vim.wo.diff then
            vim.cmd.normal { "]h", bang = true }
          else
            gs.nav_hunk "next"
          end
        end)

        utils.nmap("[h", function()
          if vim.wo.diff then
            vim.cmd.normal { "[h", bang = true }
          else
            gs.nav_hunk "prev"
          end
        end)

        -- Actions
        utils.nmap("<leader>gh", gs.preview_hunk, { desc = "Preview hunk" })
        utils.nmap("<leader>gw", gs.blame_line, { desc = "Blame (who)" })
      end,
    },
    cond = function()
      return vim.fs.root(0, ".git") ~= nil
    end,
  },
  {
    "spacedentist/resolve.nvim",
    lazy = false,
    cond = function()
      return vim.fs.root(0, ".git") ~= nil
    end,
    config = function()
      require("resolve").setup {}
    end,
  },
}
