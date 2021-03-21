local fn = vim.fn
local execute = vim.api.nvim_command

-- Auto install packer.nvim if not exists
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end
vim.cmd [[packadd packer.nvim]]
-- vim.cmd [[packadd nvim-lspconfig]]
-- vim.cmd [[packadd completion-nvim]]
-- vim.cmd [[packadd galaxyline.nvim]]
vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

-- Install plugins
require('plugins')

-- Sensible defaults
require('settings')

-- Set colorscheme
require('colorscheme')

-- Setup Lua language server using submodule
require('lsp')

-- Key mappings
require('keymappings')
