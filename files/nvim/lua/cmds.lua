local utils = require "config.utils"

-- Shiftwidth, tabstop & expandtab settings based on filetype
local ft_settings = {
  help = {
    colorcolumn = {},
  },
  python = {
    shiftwidth = 4,
    tabstop = 4,
  },
  make = {
    shiftwidth = 4,
    tabstop = 4,
    expandtab = false,
  },
  jinja = {
    shiftwidth = 2,
  },
  go = {
    shiftwidth = 4,
    tabstop = 4,
    expandtab = false,
  },
  terraform = {
    commentstring = "# %s",
  },
}

local tab_group = vim.api.nvim_create_augroup("TabSettings", { clear = true })

for ft, opts in pairs(ft_settings) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = ft,
    callback = function()
      for opt, value in pairs(opts) do
        vim.opt_local[opt] = value
      end
    end,
    group = tab_group,
  })
end

-- Highlight trailing whitespaces
local tw_config = {
  highlight = "Error",
  ignored_filetypes = {
    "help",
    "lazy",
  },
  ignore_terminal = true,
}

local function highlight_trailing_whitespaces()
  if tw_config.ignore_terminal and vim.bo.buftype == "terminal" then
    return
  end

  if vim.tbl_contains(tw_config.ignored_filetypes, vim.bo.filetype) then
    return
  end

  local hl = vim.api.nvim_get_hl(0, { name = tw_config.highlight, create = false })
  if next(hl) == nil then
    utils.error(string.format("trailing whitespaces highlight group '%s' does not exist", tw_config.highlight))
    return
  end

  local command = string.format([[match %s /\s\+$/]], tw_config.highlight)
  vim.cmd(command)
end

vim.api.nvim_create_autocmd("FileType", {
  desc = "Highlight trailing whitespaces",
  callback = function()
    vim.schedule(highlight_trailing_whitespaces)
  end,
})

-- Windows to close with "q"
vim.api.nvim_create_autocmd("FileType", {
  desc = 'Windows to close with "q"',
  pattern = { "help" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = true })
  end,
})

-- Highlight when yanking (copying) text
-- Try it with `yap` in normal mode
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Return to last edit position when opening files (You want this!)
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Return to last edit position when opening files (You want this!)",
  callback = function()
    local last_pos = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)

    if last_pos[1] > 0 and last_pos[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
    end
  end,
})

-- Notify if file is changed outside of vim
local checktime_group = vim.api.nvim_create_augroup("auto_checktime", { clear = true })

-- Trigger `checktime` when files changes on disk
-- https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
-- https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  callback = function()
    vim.schedule(function()
      local modes = { "n", "i", "ic" }

      if utils.has_value(modes, vim.api.nvim_get_mode().mode) and vim.fn.getcmdwintype() == "" then
        vim.cmd [[checktime]]
      end
    end)
  end,
  group = checktime_group,
})

-- Notification after file change
-- https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  callback = function()
    vim.schedule(function()
      utils.info "File changed on disk. Buffer reloaded."
    end)
  end,
  group = checktime_group,
})

-- Allow files to be saved as root when forgetting to start Vim using sudo.
-- https://www.youtube.com/watch?v=AcvxrF2MrrI
-- https://www.youtube.com/watch?v=u1HgODpoijc
vim.api.nvim_create_user_command("W", ":execute ':silent w !sudo tee % > /dev/null' | :edit!", {})

-- Set Salt formula YAML templates filetype to jinja
vim.filetype.add {
  desc = "Salt formula YAML has jinja filetype",
  pattern = {
    ["${HOME}/.*/salt%-formula/.*%.yaml"] = "jinja",
    ["${HOME}/.*/salt%-formula/.*%.yml"] = "jinja",
  },
}

-- Set Salt formula Python state files filetype to python
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Salt formula pure Python states has python filetype",
  pattern = "*.sls",
  callback = function()
    local first_line = vim.fn.getline(1)

    if first_line:match "^#!py" then
      vim.bo.filetype = "python"
    end
  end,
})
