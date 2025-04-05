local utils = require "config.utils"

return {
  {
    "lewis6991/gitsigns.nvim",
    dir = utils.ternary(
      utils.is_yandex,
      "~/arcadia/contrib/tier1/gitsigns.arc.nvim",
      vim.fn.stdpath "data" .. "/lazy/gitsigns.nvim"
    ),
    event = "VeryLazy",
    opts = {
      signs = {
        add = { text = " " },
        change = { text = " " },
        delete = { text = " " },
        topdelete = { text = " " },
        changedelete = { text = " " },
        untracked = { text = " " },
      },
      preview_config = {
        border = "rounded",
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
}
