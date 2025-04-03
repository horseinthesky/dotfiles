local map = require("utils").map

-- dashboard
local function get_footer()
  local datetime = os.date "%d-%m-%Y %H:%M:%S"
  local plugins_text = ""
    .. "v"
    .. vim.version().major
    .. "."
    .. vim.version().minor
    .. "."
    .. vim.version().patch
    .. "   "
    .. datetime

  return plugins_text
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
        action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config') .. '/lua'})",
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

-- Setup
require("snacks").setup {
  input = {},
  notifier = {},
  dashboard = dashboard,
  picker = {
    win = {
      input = {
        keys = {
          ["<Esc>"] = { "close", mode = { "i" } },
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
}

-- Keymaps
local snacks_keymaps = {
  ---- Picker
  -- General
  { "<leader>fa", Snacks.picker.autocmds, { desc = "Autocommands" } },
  { "<leader>fc", Snacks.picker.commands, { desc = "Commands" } },
  { "<leader>fC", Snacks.picker.colorschemes, { desc = "Colorschemes" } },
  { "<leader>fh", Snacks.picker.help, { desc = "Help" } },
  { "<leader>fH", Snacks.picker.highlights, { desc = "Highlights" } },
  { "<leader>fi", Snacks.picker.icons, { desc = "Icons" } },
  { "<leader>fk", Snacks.picker.keymaps, { desc = "Keymaps" } },
  { "<leader>fm", Snacks.picker.man, { desc = "Man pages" } },
  { "<leader>fn", Snacks.picker.notifications, { desc = "Notifications" } },
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
  { "<leader>fg", Snacks.picker.grep, { desc = "Live grep" } },
  { "<leader>fb", Snacks.picker.lines, { desc = "Buffer lines" } },
  { "<leader>fw", Snacks.picker.grep_word, { desc = "Grep word" } },

  -- LSP
  { "<leader>fld", Snacks.picker.diagnostics_buffer, { desc = "Diagnostics" } },
  { "<leader>flD", Snacks.picker.diagnostics, { desc = "Workspace diagnostics" } },
  { "<leader>fls", Snacks.picker.lsp_symbols, { desc = "Symbols" } },
  { "<leader>flS", Snacks.picker.lsp_workspace_symbols, { desc = "Workspace symbols" } },
  { "<leader>flr", Snacks.picker.lsp_references, { desc = "References" } },
  { "<leader>fli", Snacks.picker.lsp_implementations, { desc = "Implementations" } },
  -- TODO: (horseinthesky) Set calls keymaps once https://github.com/folke/snacks.nvim/pull/1483 is done

  -- Git
  { "<leader>gb", Snacks.picker.git_branches, { desc = "Branches" } },
  { "<leader>gl", Snacks.picker.git_log, { desc = "Logs" } },
  { "<leader>gf", Snacks.picker.git_log_file, { desc = "Log file" } },
  { "<leader>gL", Snacks.picker.git_log_line, { desc = "Log line" } },
  { "<leader>gs", Snacks.picker.git_status, { desc = "Status" } },
  { "<leader>gH", Snacks.picker.git_diff, { desc = "Hunk" } },
  { "<leader>gt", Snacks.picker.git_stash, { desc = "Stash" } },

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
  map("n", lhs, rhs, opts)
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
        notif.icon = ev.data.params.value.kind == "end" and " "
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})
