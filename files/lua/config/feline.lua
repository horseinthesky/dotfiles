local utils = require "utils"
local appearance = require "appearance"
local icons = appearance.icons
local theme_map = appearance.color_map[vim.g.colors_name] or appearance.color_map["gruvbox"]
local colors = theme_map[vim.opt.background:get()] or theme_map["dark"]

local force_inactive = {
  filetypes = {
    "packer",
    "Outline",
    "Mundo",
    "MundoDiff",
    "startify",
    "startuptime",
  },
  buftypes = {},
  bufnames = {},
}

local mode_map = {
  n = { "", "NORMAL" },
  i = { "", "INSERT" },
  ic = { "", "INSERT" },
  R = { "", "REPLACE" },
  v = { "", "VISUAL" },
  V = { "", "V-LINE" },
  c = { "ﲵ", "COMMAND" },
  s = { "", "SELECT" },
  S = { "", "S-LINE" },
  t = { "", "TERMINAL" },
  nt = { "", "TERMINAL" },
  ["\22"] = { "", "V-BLOCK" },
  ["\19"] = { "", "S-BLOCK" },
}

setmetatable(mode_map, {
  __index = function()
    return { icons.question, utils.get_current_mode() }
  end,
})

local function get_highlight(position)
  local fg, bg = unpack(colors[utils.get_current_mode()])

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
      local icon, label = unpack(mode_map[utils.get_current_mode()])

      local mode = " " .. icon .. " "

      if utils.wide_enough(60) then
        mode = mode .. label .. " "
      end

      if vim.o.paste then
        mode = mode .. icons.sep.left .. " " .. icons.paste .. " "

        if utils.wide_enough(65) then
          mode = mode .. "Paste "
        end
      end

      return mode
    end,
    hl = function()
      return get_highlight "primary"
    end,
  },
  whitespace = {
    provider = " ",
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
      provider = icons.sep.right_filled,
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
        return icons.gears .. " "
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
        local w = vim.lsp.diagnostic.get_count(0, "Warning")
        local e = vim.lsp.diagnostic.get_count(0, "Error")
        local i = vim.lsp.diagnostic.get_count(0, "Information")
        local h = vim.lsp.diagnostic.get_count(0, "Hint")
        if w ~= 0 or e ~= 0 or i ~= 0 or h ~= 0 then
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
    errors = {
      provider = "diagnostic_errors",
      icon = " " .. icons.diagnostic.error .. " ",
      hl = {
        fg = colors.error,
        bg = colors.substrate,
      },
      truncate_hide = true,
      priority = 25,
    },
    warnings = {
      provider = "diagnostic_warnings",
      icon = " " .. icons.diagnostic.warning .. " ",
      hl = {
        fg = colors.warn,
        bg = colors.substrate,
      },
      truncate_hide = true,
      priority = 25,
    },
    hints = {
      provider = "diagnostic_hints",
      icon = " " .. icons.diagnostic.hint .. " ",
      hl = {
        fg = colors.hint,
        bg = colors.substrate,
      },
      truncate_hide = true,
      priority = 24,
    },
    info = {
      provider = "diagnostic_info",
      icon = " " .. icons.diagnostic.info .. " ",
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
      comps.lsp.icon,
      comps.lsp.server,
      comps.lsp.ok,
      comps.lsp.errors,
      comps.lsp.warnings,
      comps.lsp.hints,
      comps.lsp.info,
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
