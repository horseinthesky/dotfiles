require("fzf-lua").setup {
  winopts = {
    -- row = 100,
    -- col = 0,
    -- height = 0.5,
    -- width = 1,
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
  files = {
    prompt = "Files> ",
  },
  fzf_opts = {
    ["--info"] = "default",
  },
}
