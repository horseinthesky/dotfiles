local utils = require "utils"

-- For debugging purposes
_G.dump = function(...)
  print(vim.inspect(...))
end

_G.warn = function(msg, name)
  utils.log(msg, name, "DiagnosticWarn")
end

_G.error = function(msg, name)
  utils.log(msg, name, "DiagnosticError")
end

_G.info = function(msg, name)
  utils.log(msg, name, "DiagnosticInfo")
end

utils.map("n", "gn", "<cmd>lua info(vim.api.nvim_buf_get_name(0), 'Filename')<CR>")
