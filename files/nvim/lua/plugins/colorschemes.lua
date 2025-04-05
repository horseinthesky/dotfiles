return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 999,
    opts = {
      italic = {
        strings = false,
        comments = false,
        operators = false,
        folds = false,
      },
    },
    cond = function()
      return vim.g.theme == "gruvbox"
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 999,
    opts = {
      style = "storm",
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
      },
    },
    cond = function()
      return vim.g.theme == "tokyonight-storm"
    end,
  },
}
