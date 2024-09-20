require("fzf-lua").setup {
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
}
