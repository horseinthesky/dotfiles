local M = {}

function M.map(mode, key, action, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, key, action, options)
end

function M.has_value(table, val)
  for _, value in ipairs(table) do
    if value == val then
      return true
    end
  end

  return false
end

function M.diagnostic_exists()
  return not vim.tbl_isempty(vim.lsp.buf_get_clients(vim.api.nvim_get_current_buf()))
end

function M.get_lsp_clients()
  local buf_client_names = {}

  for _, client in pairs(vim.lsp.buf_get_clients(0)) do
    local client_name = string.match(client.name, "(.-)_.*") or string.match(client.name, "(.-)-.*") or client.name

    table.insert(buf_client_names, client_name)
  end

  return table.concat(buf_client_names, ", ")
end

function M.wide_enough(width)
  if vim.fn.winwidth(0) > width then
    return true
  end
  return false
end

function M.buffer_not_empty()
  if vim.fn.empty(vim.fn.expand "%:t") ~= 1 then
    return true
  end
  return false
end

function M.has_filetype()
  local f_type = vim.bo.filetype
  if not f_type or f_type == "" then
    return false
  end
  return true
end

local function log(msg, name, hl)
  name = name or "Neovim"
  hl = hl or "Comment"
  vim.api.nvim_echo({ { name .. ": ", hl }, { msg } }, true, {})
end

function M.warn(msg, name)
  log(msg, name, "DiagnosticWarn")
end

function M.error(msg, name)
  log(msg, name, "DiagnosticError")
end

function M.info(msg, name)
  log(msg, name, "DiagnosticInfo")
end

return M
