local gl = require "galaxyline"
local vcs = require "galaxyline.provider_vcs"
local condition = require "galaxyline.condition"
local devicons = require "nvim-web-devicons"

local utils = require "utils"
local appearance = require "appearance"
local icons = appearance.icons
local theme_map = appearance.color_map[vim.g.colors_name] or appearance.color_map["gruvbox"]
local colors = theme_map[vim.opt.background:get()] or theme_map["dark"]

gl.short_line_list = {
  "vim-plug",
  "tagbar",
  "Mundo",
  "MundoDiff",
  "coc-explorer",
  "startify",
  "packer",
  "Outline",
}

local mode_map = {
  n = { "", "NORMAL" },
  i = { "", "INSERT" },
  ic = { "", "INSERT" },  -- Insert completion
  R = { "", "REPLACE" },
  v = { "", "VISUAL" },
  V = { "", "V-LINE" },
  c = { "ﲵ", "COMMAND" },
  s = { "", "SELECT" },
  S = { "", "S-LINE" },
  t = { "", "TERMINAL" },
  ["\22"] = { "", "V-BLOCK" },
  ["\19"] = { "", "S-BLOCK" },
}

local function diag(severity)
  local n = vim.lsp.diagnostic.get_count(0, severity)

  if n == 0 then
    return ""
  end

  local diag_mapping = {
    Warning = icons.diagnostic.warning,
    Error = icons.diagnostic.error,
    Information = icons.diagnostic.info,
    Hint = icons.diagnostic.hint,
  }

  return string.format(" %s %d ", diag_mapping[severity], n)
end

local gls = gl.section

gls.left[1] = {
  ViMode = {
    provider = function()
      local icon, label = unpack(mode_map[utils.get_current_mode()])
      local fg, nested_fg = unpack(colors[utils.get_current_mode()])
      utils.highlight("GalaxyViMode", nested_fg, fg)
      utils.highlight("GalaxyViModeInv", fg, nested_fg)
      utils.highlight("GalaxyViModeNested", fg, nested_fg)
      utils.highlight("GalaxyViModeInvNested", nested_fg, colors.substrate)
      local mode = "  " .. icon .. " " ..  label .. " "
      if vim.o.paste then
        mode = mode .. icons.sep.left .. " " .. icons.paste .. " Paste "
      end
      return mode
    end,
    separator = icons.sep.left_filled,
    separator_highlight = "GalaxyViModeInv",
  },
}
gls.left[2] = {
  FileIcon = {
    provider = function()
      local extention = vim.fn.expand "%:e"
      local icon, iconhl = devicons.get_icon(extention)
      if icon == nil then
        return ""
      end

      local fg = vim.fn.synIDattr(vim.api.nvim_get_hl_id_by_name(iconhl), "fg")
      local _, bg = unpack(colors[utils.get_current_mode()])
      utils.highlight("GalaxyFileIcon", fg, bg)

      return " " .. icon .. " "
    end,
    condition = utils.buffer_not_empty,
  },
}
gls.left[3] = {
  FileName = {
    provider = function()
      if vim.bo.buftype == "terminal" then
        return ""
      end
      if not utils.buffer_not_empty() then
        return ""
      end

      local fname
      if utils.wide_enough(120) then
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

      return " " .. fname .. " "
    end,
    highlight = "GalaxyViModeNested",
    condition = utils.buffer_not_empty,
  },
}
gls.left[4] = {
  LeftSep = {
    provider = function()
      return icons.sep.left_filled
    end,
    highlight = "GalaxyViModeInvNested",
  },
}
gls.left[5] = {
  GitIcon = {
    provider = function()
      local branch = vcs.get_git_branch()

      if utils.wide_enough(85) and branch ~= nil then
        return "  " .. icons.git.logo .. " "
      end

      return ""
    end,
    highlight = { colors.git_icon, colors.substrate },
  },
}
gls.left[6] = {
  GitBranch = {
    provider = function()
      local branch = vcs.get_git_branch()

      if utils.wide_enough(85) and branch ~= nil then
        return branch .. " "
      end

      return ""
    end,
    highlight = { colors.git_branch, colors.substrate },
  },
}
gls.left[7] = {
  DiffAdd = {
    provider = function()
      if condition.check_git_workspace() and utils.wide_enough(100) then
        return vcs.diff_add()
      end
      return ""
    end,
    icon = icons.git.added .. " ",
    highlight = { colors.diff_add, colors.substrate },
  },
}
gls.left[8] = {
  DiffModified = {
    provider = function()
      if condition.check_git_workspace() and utils.wide_enough(100) then
        return vcs.diff_modified()
      end
      return ""
    end,
    icon = icons.git.modified .. " ",
    highlight = { colors.diff_modified, colors.substrate },
  },
}
gls.left[9] = {
  DiffRemove = {
    provider = function()
      if condition.check_git_workspace() and utils.wide_enough(100) then
        return vcs.diff_remove()
      end
      return ""
    end,
    icon = icons.git.removed .. " ",
    highlight = { colors.diff_remove, colors.substrate },
  },
}

gls.right[1] = {
  LspIcon = {
    provider = function()
      if utils.diagnostic_exists() then
        return icons.gears .. " "
      end
    end,
    highlight = { colors.lsp_icon, colors.substrate },
  },
}
gls.right[2] = {
  LspServer = {
    provider = function()
      if utils.diagnostic_exists() then
        local clients = utils.get_lsp_clients()
        return clients .. " "
      end
    end,
    highlight = { colors.lsp_name, colors.substrate },
  },
}
gls.right[3] = {
  DiagnosticOk = {
    provider = function()
      if not utils.diagnostic_exists() then
        return ""
      end
      local w = vim.lsp.diagnostic.get_count(0, "Warning")
      local e = vim.lsp.diagnostic.get_count(0, "Error")
      local i = vim.lsp.diagnostic.get_count(0, "Information")
      local h = vim.lsp.diagnostic.get_count(0, "Hint")
      if w ~= 0 or e ~= 0 or i ~= 0 or h ~= 0 then
        return ""
      end
      return icons.diagnostic.ok .. " "
    end,
    highlight = { colors.ok, colors.substrate },
  },
}
gls.right[4] = {
  DiagnosticError = {
    provider = function()
      return diag "Error"
    end,
    highlight = { colors.error, colors.substrate },
  },
}
gls.right[5] = {
  DiagnosticWarn = {
    provider = function()
      return diag "Warning"
    end,
    highlight = { colors.warn, colors.substrate },
  },
}
gls.right[6] = {
  DiagnosticInfo = {
    provider = function()
      return diag "Information"
    end,
    highlight = { colors.info, colors.substrate },
  },
}
gls.right[7] = {
  DiagnosticHint = {
    provider = function()
      return diag "Hint"
    end,
    highlight = { colors.hint, colors.substrate },
  },
}
gls.right[8] = {
  RightSepNested = {
    provider = function()
      return icons.sep.right_filled
    end,
    highlight = "GalaxyViModeInvNested",
  },
}
gls.right[9] = {
  FileFormat = {
    provider = function()
      if not utils.buffer_not_empty() or not utils.wide_enough(70) then
        return ""
      end
      local icon = icons[vim.bo.fileformat] or ""
      return string.format("  %s %s ", icon, vim.bo.fileencoding)
    end,
    highlight = "GalaxyViModeNested",
  },
}
gls.right[10] = {
  RightSep = {
    provider = function()
      return icons.sep.right_filled
    end,
    highlight = "GalaxyViModeInv",
  },
}
gls.right[11] = {
  PositionInfo = {
    provider = function()
      if not utils.buffer_not_empty() or not utils.wide_enough(60) then
        return ""
      end
      return string.format("  %s %s:%s ", icons.line_number, vim.fn.line ".", vim.fn.col ".")
    end,
    highlight = "GalaxyViMode",
  },
}
gls.right[12] = {
  PercentInfo = {
    provider = function()
      if not utils.buffer_not_empty() or not utils.wide_enough(65) then
        return ""
      end
      local percent = math.floor(100 * vim.fn.line "." / vim.fn.line "$")
      return string.format(" %s %s%s", icons.page, percent, "% ")
    end,
    highlight = "GalaxyViMode",
    separator = icons.sep.right,
    separator_highlight = "GalaxyViMode",
  },
}

local short_map = {
  ["vim-plug"] = "Plugins",
  ["coc-explorer"] = "Explorer",
  ["startify"] = "Starfity",
  ["tagbar"] = "Tagbar",
  ["packer"] = "Packer",
  ["Outline"] = "Outline",
  ["Mundo"] = "History",
  ["MundoDiff"] = "Diff",
}

local function has_file_type()
  local f_type = vim.bo.filetype
  if not f_type or f_type == "" then
    return false
  end
  return true
end

gls.short_line_left[1] = {
  BufferType = {
    provider = function()
      local fg, nested_fg = unpack(colors[utils.get_current_mode()])
      utils.highlight("GalaxyViMode", nested_fg, fg)
      utils.highlight("GalaxyViModeInv", fg, nested_fg)
      utils.highlight("GalaxyViModeInvNested", nested_fg, colors.substrate)

      local name = short_map[vim.bo.filetype]
      if name == nil then return "" end

      return string.format("  %s ", name)
    end,
    highlight = "GalaxyViMode",
    condition = has_file_type,
    separator = icons.sep.left_filled,
    separator_highlight = "GalaxyViModeInv",
  },
}
gls.short_line_left[2] = {
  ShortLeftSepNested = {
    provider = function()
      return icons.sep.left_filled
    end,
    highlight = "GalaxyViModeInvNested",
  },
}
gls.short_line_right[1] = {
  ShortRightSepNested = {
    provider = function()
      return icons.sep.right_filled
    end,
    highlight = "GalaxyViModeInvNested",
  },
}
gls.short_line_right[2] = {
  ShortRightSep = {
    provider = function()
      return icons.sep.right_filled
    end,
    highlight = "GalaxyViModeInv",
  },
}
