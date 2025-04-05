local nmap = require("config.utils").nmap

---- Keymaps
-- neogen
nmap("<leader>af", function()
  require("neogen").generate { type = "func" }
end, { desc = "Type" })
nmap("<leader>ac", function()
  require("neogen").generate { type = "class" }
end, { desc = "Type" })
nmap("<leader>at", function()
  require("neogen").generate { type = "type" }
end, { desc = "Type" })

return {
  {
    "Glench/Vim-Jinja2-Syntax",
    ft = "jinja",
  },
  {
    "OXY2DEV/markview.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    ft = "markdown",
    opts = {
      preview = {
        hybrid_modes = { "n" },
      },
      markdown = {
        list_items = {
          shift_width = 2,
        },
      },
    },
    keys = {
      { "<leader>M", "<CMD>Markview<CR>", desc = "Markview toggle" },
      { "<leader>ms", "<CMD>Markview splitToggle<CR>", desc = "Split" },
    },
  },
  {
    "danymat/neogen",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
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
    opts = {
      completion = {
        cmp = {
          enabled = true,
        },
      },
      popup = {
        autofocus = true,
      },
    },
  },
}
