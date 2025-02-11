local a = require "appearance"
local icons = a.icons
local colors = a.colors

local mode_map = {
  n = { "󰋜", "NORMAL" },
  i = { "", "INSERT" },
  ic = { "", "INSERT" },
  R = { "", "REPLACE" },
  v = { "󰆏", "VISUAL" },
  V = { "󰆏", "V-LINE" },
  c = { "󰞷", "COMMAND" },
  s = { "󰆏", "SELECT" },
  S = { "󰆏", "S-LINE" },
  t = { "", "TERMINAL" },
  nt = { "", "TERMINAL" },
  ["\22"] = { "󰆏", "V-BLOCK" },
  ["\19"] = { "󰆏", "S-BLOCK" },
}

setmetatable(mode_map, {
  __index = function()
    return { icons.question, vim.api.nvim_get_mode().mode }
  end,
})

local s_comps = {
  mode = {
    function()
      local icon, label = unpack(mode_map[vim.api.nvim_get_mode().mode])

      local mode = icon

      if a.wide_enough(60) then
        mode = mode .. " " .. label
      end

      return mode
    end,
  },
  file = {
    format = {
      function()
        local icon = icons[vim.bo.fileformat] or ""

        return string.format("%s %s", icon, vim.bo.fileencoding)
      end,
      cond = a.buffer_not_empty,
    },
    position = {
      function()
        return string.format(" %s %s:%s", icons.line_number, unpack(vim.api.nvim_win_get_cursor(0)))
      end,
      padding = 0,
      cond = a.buffer_not_empty,
    },
    percentage = {
      function()
        local curr_line = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_line_count(0)

        return icons.sep.right .. string.format(" %s %d%%%%", icons.page, math.floor(100 * curr_line / lines))
      end,
      cond = a.buffer_not_empty,
    },
  },
  git = {
    branch = {
      "branch",
      icon = {
        icons.git.branch,
        color = { fg = colors.git_icon },
      },
    },
    diff = {
      "diff",
      symbols = {
        added = icons.circle.plus .. " ",
        modified = icons.circle.dot .. " ",
        removed = icons.circle.minus .. " ",
      },
    },
  },
  lsp = {
    icon = {
      function()
        return icons.gears
      end,
      color = {
        fg = colors.lsp_icon,
      },
      cond = a.diagnostic_exists,
    },
    server = {
      a.get_lsp_clients,
      padding = { left = 0, right = 1 },
      cond = a.diagnostic_exists,
    },
    ok = {
      a.if_diagnostic_ok,
      padding = 0,
      color = {
        fg = colors.ok,
      },
      cond = a.diagnostic_exists,
    },
  },
}

local native_sections = {
  lualine_a = {
    s_comps.mode,
  },
  lualine_b = {
    {
      "filetype",
      icon_only = true,
      padding = { left = 1 },
    },
    {
      "filename",
      symbols = {
        modified = icons.file.modified,
        readonly = icons.file.locked,
      },
      padding = { left = 0, right = 1 },
    },
  },
  lualine_c = {
    s_comps.git.branch,
    s_comps.git.diff,
  },
  lualine_x = {
    {
      "diagnostics",
      symbols = {
        error = icons.diagnostic.error .. " ",
        warn = icons.diagnostic.warning .. " ",
        info = icons.diagnostic.info .. " ",
        hint = icons.diagnostic.hint .. " ",
      },
      padding = 0,
    },
    s_comps.lsp.ok,
    s_comps.lsp.icon,
    s_comps.lsp.server,
  },
  lualine_y = {
    s_comps.file.format,
  },
  lualine_z = {
    s_comps.file.position,
    s_comps.file.percentage,
  },
}

require("lualine").setup {
  options = {
    component_separators = {
      left = "",
      right = "",
    },
    section_separators = {
      left = icons.sep.left_filled,
      right = icons.sep.right_filled,
    },
    disabled_filetypes = {
      statusline = {
        "alpha",
        "oil",
      },
    },
  },
  sections = native_sections,
}
