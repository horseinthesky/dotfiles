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
  ["'"] = "horizontal split",
  [";"] = "vertical split",
  ["`"] = "terminal",
  A = "yank all buffer",
  F = "format",
  I = "toggle indentline",
  M = "startup time",
  P = "TS playground",
  S = {
    name = "swap previous",
    ["<space>"] = "which_key_ignore",
    c = "outer class",
    f = "outer function",
    p = "inner parameter",
  },
  R = "reload buffer",
  T = "replace tabs",
  W = "strip whitespaces",
  a = {
    name = "annotate",
    c = "class",
    f = "function",
    t = "type",
  },
  b = {
    name = "buffers",
    d = "delete buffer",
    p = "pick buffer",
  },
  c = {
    name = "code",
    D = "definition",
    a = "code action",
    d = "line diagnistics",
    h = "hover",
    i = "implementation",
    l = "diagnostics to loclist",
    r = "rename",
    s = "sinature help",
    t = "which_key_ignore",
  },
  f = {
    name = "find",
    B = "builtins",
    C = "colorscheme",
    E = "workspace line",
    H = "highlights",
    M = "keymaps",
    O = "oldfiles",
    P = "neoclip",
    S = "symbols",
    T = "todo-comments",
    a = "autocommands",
    b = "buffers",
    c = "commands",
    e = "buffer line",
    f = "files",
    h = "help",
    g = "live grep",
    l = {
      name = "lsp",
      D = "workspace diagnostics",
      d = "document diagnostics",
      r = "references",
      s = "document symbols",
      S = "workspace symbols",
    },
    m = "marks",
    o = "options",
    p = "project",
    r = "registers",
    t = "tabs",
    w = "word",
  },
  g = {
    name = "git",
    b = "branches",
    d = "which_key_ignore",
    c = "cimmits",
    h = "hunk",
    s = "status",
    w = "blame (who)",
  },
  i = "lsp info",
  l = {
    name = "loclist",
    c = "close loclist",
    o = "open loclist",
    r = "which_key_ignore",
  },
  p = {
    name = "packer",
    c = "compile",
    i = "install",
    s = "sync",
    t = "status",
    u = "update",
  },
  q = {
    name = "quicklist",
    o = "open quicklist",
    c = "close quicklist",
  },
  r = {
    name = "replace",
    c = "replace with confirmation",
    r = "replace all entries",
    s = "replace one entry",
  },
  s = {
    name = "swap next",
    ["<space>"] = "which_key_ignore",
    b = "outer block",
    c = "outer class",
    f = "outer function",
    m = "outer call",
    p = "inner parameter",
    s = "outer statement",
  },
  t = {
    name = "tabs",
    H = "tab move left",
    J = "tab move first",
    K = "tab move last",
    L = "tab move right",
    c = "close tab",
    h = "previous tab",
    j = "last tab",
    k = "first tab",
    l = "next tab",
    o = "only this tab",
    t = "new tab",
  },
  v = "reselect pasted text",
}

local g_map = {
  c = "comment",
  d = {
    name = "diff",
    h = "diff from (left)",
    l = "diff to (right)",
  },
  n = "show filename",
  s = {
    name = "sessions",
    c = "session close",
    d = "session delete",
    l = "session load",
    s = "session save",
  },
}

local open_square_bracket_map = {
  b = "buffer",
  l = "loclist entry",
  t = "tab",
  d = "definition",
  w = "whitespace",
  h = "git hunk",
  m = "function start",
  M = "function end",
  q = "quickfixlist entry",
  ["]"] = "class start",
  ["["] = "class end",
}

local close_square_bracket_map = {
  l = "loclist entry",
  q = "quickfixlist entry",
  b = "buffer",
  t = "tab",
  d = "definition",
  w = "whitespace",
  h = "git hunk",
  m = "function start",
  M = "function end",
  ["["] = "class start",
  ["]"] = "class end",
}

local conf = {
  window = {
    border = "single", -- none, single, double, shadow
    position = "bottom", -- bottom, top
  },
}

wk.setup(conf)
wk.register(leader_map, { prefix = "<leader>" })
wk.register(g_map, { prefix = "g" })
wk.register(open_square_bracket_map, { prefix = "]" })
wk.register(close_square_bracket_map, { prefix = "[" })
