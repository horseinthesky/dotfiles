local M = {}

local nls = require "null-ls"
local b = nls.builtins

local sources = {
  -- Linting
  b.diagnostics.flake8.with {
    extra_args = { "--ignore", "E501,W503,E999" },
  },
  b.diagnostics.mypy.with {
    extra_args = {
      "--show-column-numbers",
      "--ignore-missing-imports",
      "--disable-error-code",
      "name-defined",
      "--cache-dir",
      "/dev/null",
    },
  },

  -- Formatting
  b.formatting.prettierd,
  b.formatting.stylua.with {
    extra_args = { "--config-path", vim.fn.expand "~/.config/stylua/stylua.toml" },
  },
  b.formatting.isort.with {
    extra_args = { "-l", "100" },
  },
  b.formatting.black.with {
    extra_args = { "--fast", "-l", "100" },
  },

  -- Code actions
  b.code_actions.gitsigns,

  -- Hover
  b.hover.dictionary,
}

function M.setup(opts)
  nls.setup {
    on_attach = opts.on_attach,
    diagnostics_format = "[#{s}] #{c}: #{m}",
    sources = sources,
  }
end

return M
