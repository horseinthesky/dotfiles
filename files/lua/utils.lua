local M = {}

function M.map(mode, key, action, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, key, action, options)
end

function M.contains(table, key)
  return table[key] ~= nil
end

function M.get_current_mode()
  return vim.api.nvim_get_mode().mode
end

function M.diagnostic_exists()
  return not vim.tbl_isempty(vim.lsp.buf_get_clients(vim.api.nvim_get_current_buf()))
end

function M.get_lsp_clients()
  local buf_client_names = {}

  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return ""
  end

  for _, client in ipairs(clients) do
    if vim.lsp.buf_is_attached(vim.api.nvim_get_current_buf(), client.id) then
      local client_name = string.match(client.name, "(.-)_.*")
        or string.match(client.name, "(.-)-.*")
        or client.name

      table.insert(buf_client_names, client_name)
    end
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

function M.highlight(group, fg, bg, gui)
  local cmd = string.format("highlight %s guifg=%s guibg=%s", group, fg, bg)
  if gui ~= nil then
    cmd = cmd .. " gui=" .. gui
  end
  vim.cmd(cmd)
end

function M.log(msg, hl, name)
  name = name or "Neovim"
  hl = hl or "Todo"
  vim.api.nvim_echo({ { name .. ": ", hl }, { msg } }, true, {})
end

function M.warn(msg, name)
  M.log(msg, "LspDiagnosticsDefaultWarning", name)
end

function M.error(msg, name)
  M.log(msg, "LspDiagnosticsDefaultError", name)
end

function M.info(msg, name)
  M.log(msg, "LspDiagnosticsDefaultInformation", name)
end

function M.toggle(option, silent)
  local info = vim.api.nvim_get_option_info(option)
  local scopes = { buf = "bo", win = "wo", global = "o" }
  local scope = scopes[info.scope]
  local options = vim[scope]

  options[option] = not options[option]

  if silent ~= true then
    if options[option] then
      M.info("enabled vim." .. scope .. "." .. option, "Toggle")
    else
      M.warn("disabled vim." .. scope .. "." .. option, "Toggle")
    end
  end
end

return M
