local M = {}

local rt = require "rust-tools"
local on_attach = require "lsp.on_attach"

function M.setup()
  rt.setup {
    server = {
      cmd = { "rustup", "run", "stable", "rust-analyzer" },
      on_attach = on_attach.default,
      tools = {
        inlay_hints = {
          show_parameter_hints = false,
          parameter_hints_prefix = "",
          other_hints_prefix = "",
        },
      },
    },
  }
end

return M
