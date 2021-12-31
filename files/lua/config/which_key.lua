local wk = require "which-key"

vim.api.nvim_exec(
  [[
    highlight default link WhichKey          Special
    highlight default link WhichKeySeperator LineNr
    highlight default link WhichKeyGroup     Number
    highlight default link WhichKeyDesc      Identifier
    highlight default link WhichKeyValue     Title
    highlight default link WhichKeyFloat     Normal
  ]],
  false
)

local leader_map = {
  ["'"] = "horizontal split",
  [";"] = "vertical split",
  ["`"] = "terminal",
  A = "yank all buffer",
  D = "annotations",
  F = "format",
  I = "indentline toggle",
  M = "startup time",
  P = "TS playground",
  S = {
    name = "swap previous",
    ["<space>"] = "which_key_ignore",
    p = "inner parameter",
    f = "outer function",
    c = "outer class",
  },
  R = "reload buffer",
  T = "replace tabs",
  W = "strip whitespaces",
  b = {
    name = "buffers",
    d = "delete buffer",
    p = "pick buffer",
  },
  c = {
    name = "code",
    a = "code action",
    d = "definition",
    i = "implementation",
    h = "hover",
    r = "rename",
    s = "sinature help",
    D = "line diagnistics",
    l = "diagnostics to loclist",
    t = "which_key_ignore",
  },
  f = {
    name = "find",
    b = "buffers",
    B = "builtins",
    f = "files",
    g = "live grep",
    w = "word",
    r = "registers",
    s = "search",
    L = "line",
    m = "marks",
    M = "keymaps",
    o = "options",
    O = "oldfiles",
    c = "commands",
    a = "autocommands",
    t = "todo-comments",
    h = "help",
    H = "highlights",
    C = "colorscheme",
    S = "symbols",
    l = {
      name = "lsp",
      d = "document diagnostics",
      D = "workspace diagnostics",
      r = "references",
      s = "document symbols",
      S = "workspace symbols",
    },
  },
  g = {
    name = "git",
    d = "which_key_ignore",
    b = "branches",
    w = "blame (who)",
    c = "cimmits",
    s = "status",
    h = "hunk",
  },
  i = "lsp info",
  l = {
    name = "loclist",
    o = "open loclist",
    c = "close loclist",
    r = "which_key_ignore",
  },
  p = {
    name = "packer",
    i = "install",
    c = "compile",
    u = "update",
    s = "sync",
    t = "status",
  },
  q = {
    name = "quicklist",
    o = "open quicklist",
    c = "close quicklist",
  },
  r = {
    name = "replace",
    r = "replace all entries",
    c = "replace with confirmation",
    s = "replace one entry",
  },
  s = {
    name = "swap next",
    ["<space>"] = "which_key_ignore",
    p = "inner parameter",
    f = "outer function",
    c = "outer class",
    b = "outer block",
    s = "outer statement",
    m = "outer call",
  },
  t = {
    name = "tabs",
    t = "new tab",
    l = "next tab",
    h = "previous tab",
    j = "last tab",
    k = "first tab",
    c = "close tab",
    o = "only this tab",
    H = "tab move left",
    L = "tab move right",
    J = "tab move first",
    K = "tab move last",
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
  l = "loclist entry",
  q = "quickfixlist entry",
  b = "buffer",
  t = "tab",
  d = "definition",
  w = "whitespace",
  h = "git hunk",
  m = "function start",
  M = "function end",
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
