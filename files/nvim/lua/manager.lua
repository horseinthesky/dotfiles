local nmap = require("config.utils").nmap

-- Bootstrap
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
local lazyrepo = "https://github.com/folke/lazy.nvim.git"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- Setup
require("lazy").setup {
  spec = {
    -- Plugin specs path
    { import = "plugins" },
  },
  defaults = { lazy = true },
  git = {
    -- Kill processes that take more than N seconds
    timeout = 30,
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
