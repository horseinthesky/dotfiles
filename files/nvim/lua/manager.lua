local nmap = require("config.utils").nmap

-- Bootstrap
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
local lazyrepo = "https://github.com/folke/lazy.nvim.git"

if not vim.uv.fs_stat(lazypath) then
  local res = vim.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }):wait()

  if res.code ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { res.stderr, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})

    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- Setup
require("lazy").setup {
  defaults = {
    lazy = true,
  },
  spec = {
    { import = "plugins" },
  },
  git = {
    -- Kill processes that take more than N seconds
    timeout = 30,
  },
  rocks = {
    enabled = false,
  },
  change_detection = {
    enabled = false,
  },
  ui = {
    backdrop = 100,
    border = "rounded",
    icons = {
      start = "",
      event = "󰌵",
      cmd = "",
      ft = "",
    },
  },
}

nmap("<leader>L", "<CMD>Lazy<CR>")
