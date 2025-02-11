local M = {}

-- Yandex hacks
function M.is_yandex()
  -- mkdir -p cloudia-store cloud-go
  -- arc init -r cloudia --object-store cloudia-store/ --path-filter cloud/cloud-go cloud-go
  local file_path = vim.api.nvim_buf_get_name(0)

  local yandex_projects = {
    "arcadia",
    "cloudia",
  }

  for _, path in ipairs(yandex_projects) do
    if string.find(file_path, "/" .. path .. "/") then
      return true
    end
  end

  return false
end

function M.ternary(condition, trueValue, falseValue)
  if condition() then
    return trueValue
  end

  return falseValue
end

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
