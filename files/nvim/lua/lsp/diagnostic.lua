local icons = require "config.utils".icons

vim.diagnostic.config {
  virtual_text = {
    spacing = 4,
    prefix = icons.duck,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostic.error,
      [vim.diagnostic.severity.WARN] = icons.diagnostic.warning,
      [vim.diagnostic.severity.INFO] = icons.diagnostic.info,
      [vim.diagnostic.severity.HINT] = icons.diagnostic.hint,
    },
  },
}

-- Remove background from diagnostic signs groups
for _, severity in ipairs { "Error", "Warn", "Info", "Hint" } do
  vim.api.nvim_set_hl(0, "DiagnosticSign" .. severity, { link = "Diagnostic" .. severity })
end

-- Fix diagnostic text in floating windows to match diagnostic text anywhere else
vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { link = "Type" })
