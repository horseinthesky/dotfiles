local nmap = require("config.utils").nmap

-- Keymaps
local snacks_keymaps = {
  -- General
  {
    "<leader>fa",
    function()
      Snacks.picker.autocmds()
    end,
    { desc = "Autocommands" },
  },
  {
    "<leader>fc",
    function()
      Snacks.picker.commands()
    end,
    { desc = "Commands" },
  },
  {
    "<leader>fC",
    function()
      Snacks.picker.colorschemes()
    end,
    { desc = "Colorschemes" },
  },
  {
    "<leader>fh",
    function()
      Snacks.picker.help()
    end,
    { desc = "Help" },
  },
  {
    "<leader>fH",
    function()
      Snacks.picker.highlights()
    end,
    { desc = "Highlights" },
  },
  {
    "<leader>fi",
    function()
      Snacks.picker.icons()
    end,
    { desc = "Icons" },
  },
  {
    "<leader>fk",
    function()
      Snacks.picker.keymaps()
    end,
    { desc = "Keymaps" },
  },
  {
    "<leader>fm",
    function()
      Snacks.picker.man()
    end,
    { desc = "Man pages" },
  },
  {
    "<leader>fn",
    function()
      Snacks.picker.notifications()
    end,
    { desc = "Notifications" },
  },
  {
    "<leader>e",
    function()
      Snacks.explorer { hidden = true }
    end,
    { desc = "File Explorer" },
  },

  -- Search
  {
    ";",
    function()
      Snacks.picker.smart { hidden = true }
    end,
    { desc = "Smart find files" },
  },
  {
    "<leader>fg",
    function()
      Snacks.picker.grep()
    end,
    { desc = "Live grep" },
  },
  {
    "<leader>fb",
    function()
      Snacks.picker.lines()
    end,
    { desc = "Buffer lines" },
  },
  {
    "<leader>fw",
    function()
      Snacks.picker.grep_word()
    end,
    { desc = "Grep word" },
  },

  -- LSP
  {
    "<leader>fld",
    function()
      Snacks.picker.diagnostics_buffer()
    end,
    { desc = "Diagnostics" },
  },
  {
    "<leader>flD",
    function()
      Snacks.picker.diagnostics()
    end,
    { desc = "Workspace diagnostics" },
  },
  {
    "<leader>fls",
    function()
      Snacks.picker.lsp_symbols()
    end,
    { desc = "Symbols" },
  },
  {
    "<leader>flS",
    function()
      Snacks.picker.lsp_workspace_symbols()
    end,
    { desc = "Workspace symbols" },
  },
  {
    "<leader>flr",
    function()
      Snacks.picker.lsp_references()
    end,
    { desc = "References" },
  },
  {
    "<leader>fli",
    function()
      Snacks.picker.lsp_implementations()
    end,
    { desc = "Implementations" },
  },
  -- TODO: (horseinthesky) Set calls keymaps once https://github.com/folke/snacks.nvim/pull/1483 is done

  -- Git
  {
    "<leader>gb",
    function()
      Snacks.picker.git_branches()
    end,
    { desc = "Branches" },
  },
  {
    "<leader>gl",
    function()
      Snacks.picker.git_log()
    end,
    { desc = "Logs" },
  },
  {
    "<leader>gf",
    function()
      Snacks.picker.git_log_file()
    end,
    { desc = "Log file" },
  },
  {
    "<leader>gL",
    function()
      Snacks.picker.git_log_line()
    end,
    { desc = "Log line" },
  },
  {
    "<leader>gs",
    function()
      Snacks.picker.git_status()
    end,
    { desc = "Status" },
  },
  {
    "<leader>gH",
    function()
      Snacks.picker.git_diff()
    end,
    { desc = "Hunk" },
  },
  {
    "<leader>gt",
    function()
      Snacks.picker.git_stash()
    end,
    { desc = "Stash" },
  },

  -- Other plugins
  {
    "<leader>ft",
    function()
      Snacks.picker.todo_comments()
    end,
    { desc = "Todo" },
  },
}

for _, keymap in ipairs(snacks_keymaps) do
  local lhs, rhs, opts = unpack(keymap)
  nmap(lhs, rhs, opts)
end

-- LSP Progress on startup
vim.api.nvim_create_autocmd("LspProgress", {
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(vim.lsp.status(), "info", {
      id = "lsp_progress",
      title = "LSP Progress",
      opts = function(notif)
        notif.icon = ev.data.params.value.kind == "end" and ""
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})

-- dashboard
local function get_footer()
  return ""
    .. "v"
    .. vim.version().major
    .. "."
    .. vim.version().minor
    .. "."
    .. vim.version().patch
    .. "   "
    .. os.date "%d-%m-%Y %H:%M:%S"
end

local dashboard = {
  preset = {
    header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
    keys = {
      { icon = "󰈔 ", key = "n", desc = "New file", action = ":ene | startinsert" },
      { icon = "󰤘 ", key = "r", desc = "Recent files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
      { icon = "󰈞 ", key = "f", desc = "Find file", action = ":lua Snacks.dashboard.pick('files')" },
      { icon = " ", key = "g", desc = "Live grep", action = ":lua Snacks.dashboard.pick('live_grep')" },
      {
        icon = "",
        key = "c",
        desc = "Config",
        action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') .. '/lua' })",
      },
      { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
      { icon = " ", key = "q", desc = "Quit", action = ":qa" },
    },
    footer = get_footer,
  },
  sections = {
    { section = "header", padding = 3 },
    { section = "keys", gap = 1, padding = 10 },
    -- { section = "footer" },
    function()
      return { text = { { get_footer(), align = "center" } } }
    end,
  },
}

-- Highlights
local hls = {
  SnacksPickerPrompt = "Type",
  SnacksPickerMatch = "Type",
  SnacksPickerDir = "SpecialKey",
  -- SnacksPickerList = "SpecialKey",
  -- SnacksPickerListCursorLine = "Normal",
}

for group, link in pairs(hls) do
  vim.api.nvim_set_hl(0, group, { link = link })
end

return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      input = {},
      notifier = {},
      -- dashboard = dashboard,
      picker = {
        prompt = " ",
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "i" } },
              ["<c-u>"] = { "preview_scroll_up", mode = { "i" } },
              ["<c-d>"] = { "preview_scroll_down", mode = { "i" } },
            },
          },
        },
        layout = {
          preset = "sidebar",
        },
      },
      styles = {
        input = {
          relative = "cursor",
          row = -3,
        },
      },
    },
  },
}
