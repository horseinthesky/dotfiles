local wk = require "which-key"

local hls = {
  WhichKey = "Special",
  WhichKeySeperator = "LineNr",
  WhichKeyGroup = "Number",
  WhichKeyDesc = "Identifier",
  WhichKeyValue = "Title",
  WhichKeyFloat = "Normal",
}

for group, link in pairs(hls) do
  vim.api.nvim_set_hl(0, group, { link = link })
end

local leader_map = {
  ["'"] = "Horizontal split",
  [";"] = "Vertical split",
  ["`"] = "Terminal",
  A = "Yank the whole buffer",
  B = "List buffers",
  F = "Format",
  I = "Toggle indentline",
  M = "Startup time",
  P = "TS playground",
  S = {
    name = "Swap previous",
    ["<space>"] = "which_key_ignore",
    c = "Outer class",
    f = "Outer function",
    p = "Inner parameter",
  },
  R = "Reload buffer",
  T = "Replace tabs",
  W = "Strip whitespaces",
  a = {
    name = "Annotate",
    c = "Class",
    f = "Function",
    t = "Type",
  },
  b = {
    name = "Buffers",
    d = "Delete buffer",
    p = "Pick buffer",
  },
  c = {
    name = "Code",
    D = "Definition",
    a = "Code action",
    d = "Line diagnistics",
    h = "Hover",
    i = "Implementation",
    l = "Diagnostics to loclist",
    r = "Rename",
    s = "Sinature help",
    t = {
      name = "Tags",
      a = {
        name = "Add",
        j = "JSON",
        y = "YAML",
        x = "XML",
      },
      r = {
        name = "Remove",
        j = "JSON",
        y = "YAML",
        x = "XML",
      },
    },
  },
  f = {
    name = "Find",
    B = "Builtins",
    C = "Colorscheme",
    E = "Workspace line",
    H = "Highlights",
    O = "Oldfiles",
    P = "Neoclip",
    S = "Symbols",
    T = "Todo-comments",
    a = "Autocommands",
    b = "Buffers",
    c = "Commands",
    e = "Buffer line",
    f = "Files",
    h = "Help",
    g = "Live grep",
    k = "Keymaps",
    l = {
      name = "Lsp",
      D = "Workspace diagnostics",
      d = "Document diagnostics",
      r = "References",
      s = "Document symbols",
      S = "Workspace symbols",
    },
    m = "Marks",
    o = "Options",
    p = "Project",
    r = "Registers",
    t = "Tabs",
    w = "Word",
  },
  g = {
    name = "Git",
    b = "Branches",
    d = "which_key_ignore",
    c = "Commits",
    h = "Hunk",
    s = "Status",
    w = "Blame (who)",
  },
  i = "Lsp info",
  l = {
    name = "Loclist",
    c = "Close loclist",
    o = "Open loclist",
    r = "Which_key_ignore",
  },
  p = {
    name = "Packer",
    c = "Compile",
    i = "Install",
    s = "Sync",
    t = "Status",
    u = "Update",
  },
  q = {
    name = "Quicklist",
    o = "Open quicklist",
    c = "Close quicklist",
  },
  r = {
    name = "Replace",
    c = "Replace with confirmation",
    r = "Replace all entries",
    s = "Replace one entry",
  },
  s = {
    name = "Swap next",
    ["<space>"] = "which_key_ignore",
    b = "Outer block",
    c = "Outer class",
    f = "Outer function",
    m = "Outer call",
    p = "Inner parameter",
    s = "Outer statement",
  },
  t = {
    name = "Tabs",
    H = "Tab move left",
    J = "Tab move first",
    K = "Tab move last",
    L = "Tab move right",
    c = "Close tab",
    h = "Previous tab",
    j = "Last tab",
    k = "First tab",
    l = "Next tab",
    o = "Only this tab",
    t = "New tab",
  },
  v = "Reselect pasted text",
}

local g_map = {
  c = "Comment",
  d = {
    name = "Diff",
    h = "Diff from (left)",
    l = "Diff to (right)",
  },
  n = "Show filename",
}

local open_square_bracket_map = {
  b = "Buffer",
  l = "Loclist entry",
  t = "Tab",
  d = "Definition",
  w = "Whitespace",
  h = "Git hunk",
  m = "Function start",
  M = "Function end",
  q = "Quickfixlist entry",
  ["]"] = "Class start",
  ["["] = "Class end",
}

local close_square_bracket_map = {
  l = "Loclist entry",
  q = "Quickfixlist entry",
  b = "Buffer",
  t = "Tab",
  d = "Definition",
  w = "Whitespace",
  h = "Git hunk",
  m = "Function start",
  M = "Function end",
  ["["] = "Class start",
  ["]"] = "Class end",
}

local conf = {
  window = {
    border = "single",
    winblend = 10,
  },
  icons = {
    breadcrumb = "ﰲ",
    separator = "ﰲ",
    group = " ",
  },
}

wk.setup(conf)
wk.register(leader_map, { prefix = "<leader>" })
wk.register(g_map, { prefix = "g" })
wk.register(open_square_bracket_map, { prefix = "]" })
wk.register(close_square_bracket_map, { prefix = "[" })
