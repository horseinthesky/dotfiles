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
  A = "Yank the whole buffer",
  F = "Format",
  I = "Toggle indentline",
  S = {
    name = "Swap previous",
    ["<space>"] = "which_key_ignore",
    c = "Outer class",
    f = "Outer function",
    p = "Inner parameter",
  },
  T = "Replace each tab with 4 whitespaces",
  W = "Strip trailing whitespaces",
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
    D = "Line diagnostics",
    a = "Code action",
    d = "Definition",
    h = "Hover",
    r = "Rename",
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
    d = "Devdocs",
    e = "Buffer line",
    f = "Files",
    h = "Help",
    g = "Live grep",
    k = "Keymaps",
    l = {
      name = "Lsp",
      D = "Workspace diagnostics",
      S = "Workspace symbols",
      d = "Document diagnostics",
      i = "Implementations",
      r = "References",
      s = "Document symbols",
      c = {
        name = "Calls",
        i = "Incoming",
        o = "Outgoing",
      },
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
    -- d = "which_key_ignore",
    c = "Commits",
    h = "Hunk",
    s = "Status",
    w = "Blame (who)",
  },
  i = "Lsp info",
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
    c = "Close tab",
    h = "Move left",
    j = "Move first",
    k = "Move last",
    l = "Move right",
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
  j = "split/join",
  n = "Show filename",
}

local v_map = {
  i = {
    name = "inside",
    b = "Block",
    c = "Class",
    f = "Function",
    l = "Loop",
    m = "Call",
    s = "Statement",
    C = "Comment",
  },
  o = {
    name = "outside",
    b = "Block",
    c = "Class",
    f = "Function",
    l = "Loop",
    m = "Call",
    s = "Statement",
    C = "Comment",
  },
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
  ignore_missing = true,
}

wk.setup(conf)
wk.register(leader_map, { prefix = "<leader>" })
wk.register(g_map, { prefix = "g" })
wk.register(v_map, { prefix = "v" })
wk.register(open_square_bracket_map, { prefix = "]" })
wk.register(close_square_bracket_map, { prefix = "[" })
