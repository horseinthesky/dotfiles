local M = {}

-- Icons
M.icons = {
  dos = "", -- e70f
  unix = "", -- f17c
  mac = "", -- f179
  code = "", -- e000
  dot = "", -- f111
  duck = "󰇥 ", -- f01e5
  page = "☰", -- 2630
  arrow = "", -- e285
  play_arrow = "", -- e602
  line_number = "", -- e0a1
  connected = "󰌘", -- f0318
  disconnected = "󰌙", -- f0319
  gears = "", -- f085
  poop = "💩", -- 1f4a9
  question = "", -- f128
  bug = "", -- f188
  git = {
    logo = "󰊢", -- f02a2
    branch = "", -- e725
  },
  square = {
    plus = "", -- f0f
    minus = "", --f146
    dot = "", --f264
  },
  circle = {
    plus = "", -- f055
    minus = "", --f056
    dot = "", -- f28d
  },
  file = {
    locked = "", -- f023
    not_modifiable = "", -- f05e
    unsaved = "", -- f0c7
    modified = "", -- f040
  },
  diagnostic = {
    ok = "", -- f058
    error = "", -- f057
    warning = "", -- f06a
    info = "", -- f05a
    -- hint = "󰌵", -- f0335
    hint = "", -- f059
  },
  sep = {
    left_filled = "", -- e0b4
    right_filled = "", -- e0b6
    -- left_filled = "", -- e0b0
    -- right_filled = "", -- e0b2
    -- left_filled = " ", -- e0c0
    -- right_filled = " ", -- e0c2
    -- left_filled = " ", -- e0c8
    -- right_filled = " ", -- e0ca
    -- left = "", -- e0b5
    -- right = "", -- e0b7
    -- left = "", -- e0b1
    -- right = "", -- e0b3
    left = "", -- e621
    right = "", -- e621
  },
}

-- Misc
function M.ternary(condition, trueValue, falseValue)
  if condition() then
    return trueValue
  end

  return falseValue
end

function M.map(mode, key, action, opts)
  opts = vim.tbl_extend("force", opts or {}, { noremap = true, silent = true })
  vim.keymap.set(mode, key, action, opts)
end

function M.nmap(key, action, opts)
  M.map("n", key, action, opts)
end

function M.has_value(table, val)
  for _, value in ipairs(table) do
    if value == val then
      return true
    end
  end

  return false
end

local title_hl_map = {
  [vim.log.levels.ERROR] = "DiagnosticError",
  [vim.log.levels.WARN] = "DiagnosticWarn",
  [vim.log.levels.INFO] = "DiagnosticInfo",
}

local function notify(msg, level, opts)
  opts = opts or {}
  level = level or vim.log.levels.DEBUG
  local title = opts.title or "Neovim"
  local title_hl = title_hl_map[level] or "DiagnosticInfo"
  vim.api.nvim_echo({ { title, title_hl }, { ": " .. msg } }, true, {})
  -- vim.notify(msg, level)
end

function M.error(msg, opts)
  notify(msg, vim.log.levels.ERROR, opts)
end

function M.warn(msg, opts)
  notify(msg, vim.log.levels.WARN, opts)
end

function M.info(msg, opts)
  notify(msg, vim.log.levels.INFO, opts)
end

-- Yandex stuff
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

return M
