local utils = {}

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

function utils.opt(key, value, scope)
  scope = scope or 'o'
  scopes[scope][key] = value
  if scope == 'b' then scopes['o'][key] = value end
end

function utils.map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

return utils
