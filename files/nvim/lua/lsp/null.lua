local M = {}

local nls = require "null-ls"
local b = nls.builtins

local sources = {
  -- Linting
  b.diagnostics.hadolint,
  b.diagnostics.buf,
  -- b.diagnostics.mypy.with {
  --   extra_args = {
  --     "--show-column-numbers",
  --     "--ignore-missing-imports",
  --     "--disable-error-code",
  --     "name-defined",
  --     "--cache-dir",
  --     "/dev/null",
  --   },
  -- },

  -- Formatting
  b.formatting.shellharden,
  b.formatting.prettierd,
  b.formatting.buf,
  b.formatting.stylua.with {
    extra_args = { "--config-path", vim.fn.expand "~/.config/stylua/stylua.toml" },
  },
}

function M.setup(opts)
  nls.setup {
    on_attach = opts.on_attach,
    diagnostics_format = "[#{s}] #{c}: #{m}",
    sources = sources,
  }
end

return M
