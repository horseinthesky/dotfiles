local utils = require "utils"
local appearance = require "appearance"
local icons = appearance.icons
local colors = appearance.colors

local force_inactive = {
  filetypes = {
    "alpha",
  },
  buftypes = {},
  bufnames = {},
}

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

local function diag(severity)
  local count = vim.diagnostic.get(0, { severity = severity })

  if #count == 0 then
    return ""
  end

  local diag_mapping = {
    [vim.diagnostic.severity.WARN] = icons.diagnostic.warning,
    [vim.diagnostic.severity.ERROR] = icons.diagnostic.error,
    [vim.diagnostic.severity.INFO] = icons.diagnostic.info,
    [vim.diagnostic.severity.HINT] = icons.diagnostic.hint,
  }

  return string.format(" %s %d", diag_mapping[severity], #count)
end

local function get_highlight(position)
  local fg, bg = unpack(colors[vim.api.nvim_get_mode().mode])

  local position_highlight_map = {
    primary = { fg = bg, bg = fg },
    primary_inv = { fg = fg, bg = bg },
    nested = { fg = fg, bg = bg },
    nested_inv = { fg = bg, bg = colors.substrate },
  }

  return position_highlight_map[position]
end

local comps = {
  vi_mode = {
    provider = function()
      local icon, label = unpack(mode_map[vim.api.nvim_get_mode().mode])

      local mode = " " .. icon .. " "

      if utils.wide_enough(60) then
        mode = mode .. label .. " "
      end

      return mode
    end,
    hl = function()
      return get_highlight "primary"
    end,
  },
  whitespace = {
    provider = function()
      if vim.api.nvim_buf_get_name(0) == "" then
        return ""
      end

      return " "
    end,
    hl = function()
      return get_highlight "primary"
    end,
  },
  sep = {
    left = {
      provider = icons.sep.left_filled,
      hl = function()
        return get_highlight "primary_inv"
      end,
    },
    left_nested = {
      provider = icons.sep.left_filled,
      hl = function()
        return get_highlight "nested_inv"
      end,
    },
    right = {
      provider = icons.sep.right_filled,
      hl = function()
        return get_highlight "primary_inv"
      end,
    },
    right_nested = {
      provider = " " .. icons.sep.right_filled,
      hl = function()
        return get_highlight "nested_inv"
      end,
    },
  },
  file = {
    name = {
      provider = function()
        if vim.bo.buftype == "terminal" then
          return ""
        end

        local fname

        if utils.wide_enough(140) then
          fname = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.")
          if #fname > 35 then
            fname = vim.fn.expand "%:t"
          end
        else
          fname = vim.fn.expand "%:t"
        end

        if #fname == 0 then
          return ""
        end

        if vim.bo.readonly then
          fname = fname .. " " .. icons.file.locked
        end
        if not vim.bo.modifiable then
          fname = fname .. " " .. icons.file.not_modifiable
        end
        if vim.bo.modified then
          fname = fname .. " " .. icons.file.modified
        end

        local extension = vim.fn.expand "%:e"

        local icon, iconhl = require("nvim-web-devicons").get_icon_color(fname, extension, { default = true })

        return " " .. fname .. " ", { str = " " .. icon, hl = { fg = iconhl } }
      end,
      hl = function()
        return get_highlight "nested"
      end,
      truncate_hide = true,
      priority = 30,
      enabled = utils.buffer_not_empty,
    },
    info = {
      provider = {
        name = "file_info",
        opts = {
          file_modified_icon = icons.file.modified,
          file_readonly_icon = icons.file.locked .. " ",
        },
      },
      hl = function()
        return get_highlight "primary"
      end,
      enabled = utils.buffer_not_empty,
    },
    format = {
      provider = function()
        local icon = icons[vim.bo.fileformat] or ""

        return string.format(" %s %s ", icon, vim.bo.fileencoding)
      end,
      hl = function()
        return get_highlight "nested"
      end,
      truncate_hide = true,
      priority = 10,
      enabled = utils.buffer_not_empty,
    },
    position = {
      provider = function()
        return string.format(" %s %s:%s ", icons.line_number, unpack(vim.api.nvim_win_get_cursor(0)))
      end,
      hl = function()
        return get_highlight "primary"
      end,
      truncate_hide = true,
      priority = 15,
      enabled = utils.buffer_not_empty,
    },
    percentage = {
      provider = function()
        local curr_line = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_line_count(0)

        return string.format(" %s %d%%%% ", icons.page, math.floor(100 * curr_line / lines))
      end,
      hl = function()
        return get_highlight "primary"
      end,
      left_sep = {
        str = icons.sep.right,
        hl = function()
          return get_highlight "primary"
        end,
      },
      truncate_hide = true,
      priority = 15,
      enabled = utils.buffer_not_empty,
    },
  },
  git = {
    icon = {
      provider = function()
        return " " .. icons.git.branch .. " "
      end,
      hl = {
        fg = colors.git_icon,
        bg = colors.substrate,
      },
      truncate_hide = true,
      priority = 5,
      enabled = require("feline.providers.git").git_info_exists,
    },
    branch = {
      provider = "git_branch",
      icon = "",
      hl = {
        fg = colors.git_branch,
        bg = colors.substrate,
      },
      truncate_hide = true,
      priority = 6,
    },
    add = {
      provider = "git_diff_added",
      icon = " " .. icons.circle.plus .. " ",
      hl = {
        fg = colors.diff_add,
        bg = colors.substrate,
      },
      truncate_hide = true,
      priority = 4,
    },
    change = {
      provider = "git_diff_changed",
      icon = " " .. icons.circle.dot .. " ",
      hl = {
        fg = colors.diff_modified,
        bg = colors.substrate,
      },
      truncate_hide = true,
      priority = 4,
    },
    remove = {
      provider = "git_diff_removed",
      icon = " " .. icons.circle.minus .. " ",
      hl = {
        fg = colors.diff_remove,
        bg = colors.substrate,
      },
      truncate_hide = true,
      priority = 4,
    },
  },
  lsp = {
    icon = {
      provider = function()
        return " " .. icons.gears .. " "
      end,
      hl = {
        fg = colors.lsp_icon,
        bg = colors.substrate,
      },
      enabled = function()
        return utils.diagnostic_exists()
      end,
      truncate_hide = true,
      priority = 20,
    },
    server = {
      provider = function()
        local clients = utils.get_lsp_clients()
        return clients
      end,
      hl = {
        fg = colors.lsp_name,
        bg = colors.substrate,
      },
      truncate_hide = true,
      priority = 20,
      enabled = utils.diagnostic_exists,
    },
    ok = {
      provider = function()
        local e = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        local w = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        local i = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
        local h = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        if #w ~= 0 or #e ~= 0 or #i ~= 0 or #h ~= 0 then
          return ""
        end
        return " " .. icons.diagnostic.ok .. " "
      end,
      hl = {
        fg = colors.ok,
        bg = colors.substrate,
      },
      truncate_hide = true,
      priority = 24,
      enabled = utils.diagnostic_exists,
    },
    error = {
      provider = function()
        return diag(vim.diagnostic.severity.ERROR)
      end,
      hl = {
        fg = colors.error,
        bg = colors.substrate,
      },
      truncate_hide = true,
      priority = 25,
    },
    warning = {
      provider = function()
        return diag(vim.diagnostic.severity.WARN)
      end,
      hl = {
        fg = colors.warn,
        bg = colors.substrate,
      },
      truncate_hide = true,
      priority = 25,
    },
    hint = {
      provider = function()
        return diag(vim.diagnostic.severity.HINT)
      end,
      hl = {
        fg = colors.hint,
        bg = colors.substrate,
      },
      truncate_hide = true,
      priority = 24,
    },
    info = {
      provider = function()
        return diag(vim.diagnostic.severity.INFO)
      end,
      hl = {
        fg = colors.info,
        bg = colors.substrate,
      },
      truncate_hide = true,
      priority = 24,
    },
  },
}

-- Initialize the components table
local components = {
  active = {
    {
      comps.vi_mode,
      comps.sep.left,
      comps.file.name,
      comps.sep.left_nested,
      comps.git.icon,
      comps.git.branch,
      comps.git.add,
      comps.git.change,
      comps.git.remove,
    },
    {
      comps.lsp.ok,
      comps.lsp.error,
      comps.lsp.warning,
      comps.lsp.hint,
      comps.lsp.info,
      comps.lsp.icon,
      comps.lsp.server,
      comps.sep.right_nested,
      comps.file.format,
      comps.sep.right,
      comps.file.position,
      comps.file.percentage,
    },
  },
  inactive = {
    {
      comps.whitespace,
      comps.file.info,
      comps.whitespace,
      comps.sep.left,
      comps.sep.left_nested,
    },
    {
      comps.sep.right_nested,
      comps.sep.right,
    },
  },
}

require("feline").setup {
  components = components,
  force_inactive = force_inactive,
}
