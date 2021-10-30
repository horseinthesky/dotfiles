local log = require "utils".log

-- For debugging purposes
_G.dump = function(...)
  print(vim.inspect(...))
end

_G.warn= function(msg, name)
  log(msg, name, "DiagnosticWarn")
end

_G.error = function(msg, name)
  log(msg, name, "DiagnosticError")
end

_G.info = function(msg, name)
  log(msg, name, "DiagnosticInfo")
end

