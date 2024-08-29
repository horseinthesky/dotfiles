local wk = require "which-key"

-- Colors
local hls = {
  WhichKey = "Special",
  WhichKeyGroup = "Number",
  WhichKeyValue = "Title",
}

for group, link in pairs(hls) do
  vim.api.nvim_set_hl(0, group, { link = link })
end

-- Setup
local conf = {
  preset = "helix",
  win = {
    border = "single",
  },
  icons = {
    breadcrumb = "󰜴",
    separator = "󰜴",
    group = " ",
  },
}

wk.setup(conf)

-- Desc
wk.add {
  -- g
  { "gd", group = "Diff" },
  { "gdh", desc = "Diff from (left)" },
  { "gdl", desc = "Diff to (right)" },
  { "gj", desc = "Split/join array" },
  { "gn", desc = "Show filename" },
  { "gf", hidden = true, desc = "Go to file under cursor" },
  { "gi", hidden = true, desc = "Go to last insert" },
  { "gN", hidden = true, desc = "Search backwards and select" },
  { "gt", hidden = true, desc = "Go to next tab page" },
  { "gT", hidden = true, desc = "Go to previous tab page" },
  { "gv", hidden = true, desc = "Last visual selection" },
  { "gw", hidden = true, desc = "Format" },
  { "gx", hidden = true, desc = "Open file with system app" },
  { "g%", hidden = true, desc = "Cycle backwards through results" },
  { "g'", hidden = true, desc = "marks" },
  { "g`", hidden = true, desc = "marks" },
  { "g~", hidden = true, desc = "Toggle cases" },

  -- v
  -- Inside
  { "vi", group = "Inside" },
  { "vib", desc = "Block" },
  { "vic", desc = "Class" },
  { "vif", desc = "Function" },
  { "vil", desc = "Loop" },
  { "vim", desc = "Call" },
  { "vis", desc = "Statement" },
  { "viC", desc = "Comment" },
  -- Outside
  { "vo", group = "Outside" },
  { "vob", desc = "Block" },
  { "voc", desc = "Class" },
  { "vof", desc = "Function" },
  { "vol", desc = "Loop" },
  { "vom", desc = "Call" },
  { "vos", desc = "Statement" },
  { "voC", desc = "Comment" },
  -- hidden
  { "v0", hidden = true, desc = "Start of line" },
  { "vb", hidden = true, desc = "Prev word" },
  { "vc", hidden = true, desc = "Change" },
  { "vd", hidden = true, desc = "Delete" },
  { "ve", hidden = true, desc = "Next end of word" },
  { "vf", hidden = true, desc = "Move to next char" },
  { "vF", hidden = true, desc = "Move to prev char" },

  -- ] Next
  { "]b", desc = "Buffer" },
  { "]d", desc = "Definition" },
  { "]h", desc = "Git hunk" },
  { "]l", desc = "Loclist entry" },
  { "]q", desc = "Quickfixlist entry" },
  { "]t", desc = "Tab" },
  { "]w", desc = "Whitespace" },
  { "]f", desc = "Goto next function start" },
  { "]F", desc = "Goto next function end" },
  { "]c", desc = "Goto next class start" },
  { "]C", desc = "Goto next class end" },
  { "]m", hidden = true, desc = "Goto next method start" },
  { "]M", hidden = true, desc = "Goto next method end" },
  { "]s", hidden = true, desc = "Misspelled word" },
  { "]%", hidden = true, desc = "Unmatched group" },
  { "]{", hidden = true, desc = "{" },
  { "](", hidden = true, desc = "(" },
  { "]<", hidden = true, desc = "<" },
  { "]]", hidden = true, desc = "]" },
  { "][", hidden = true, desc = "[" },

  -- [ Prev
  { "[b", desc = "Buffer" },
  { "[d", desc = "Definition" },
  { "[h", desc = "Git hunk" },
  { "[l", desc = "Loclist entry" },
  { "[q", desc = "Quickfixlist entry" },
  { "[t", desc = "Tab" },
  { "[w", desc = "Whitespace" },
  { "[f", desc = "Goto prev function start" },
  { "[F", desc = "Goto prev function end" },
  { "[c", desc = "Goto prev class start" },
  { "[C", desc = "Goto prev class end" },
  { "[m", hidden = true, desc = "Goto prev method start" },
  { "[M", hidden = true, desc = "Goto prev method end" },
  { "[s", hidden = true, desc = "Misspelled word" },
  { "[%", hidden = true, desc = "Unmatched group" },
  { "[{", hidden = true, desc = "{" },
  { "[(", hidden = true, desc = "(" },
  { "[<", hidden = true, desc = "<" },
  { "[]", hidden = true, desc = "]" },
  { "[[", hidden = true, desc = "[" },

  -- leader
  { "<leader>'", desc = "Horizontal split" },
  { "<leader>;", desc = "Vertical split" },
  { "<leader>A", desc = "Yank the whole buffer" },
  { "<leader>F", desc = "Format" },
  { "<leader>I", desc = "Toggle indentline" },
  { "<leader>W", desc = "Strip trailing whitespaces" },
  { "<leader>p", desc = "Paste white keeping original text" },
  { "<leader>v", desc = "Reselect pasted text" },
  { "<leader>C", desc = "Copy to system clipboard" },
  -- swap next
  { "<leader>s", group = "Swap next" },
  { "<leader>sb", desc = "Outer block" },
  { "<leader>sc", desc = "Outer class" },
  { "<leader>sf", desc = "Outer function" },
  { "<leader>sm", desc = "Outer call" },
  { "<leader>sp", desc = "Inner parameter" },
  { "<leader>ss", desc = "Outer statement" },
  -- swap prev
  { "<leader>S", group = "Swap previous" },
  { "<leader>Sc", desc = "Outer class" },
  { "<leader>Sf", desc = "Outer function" },
  { "<leader>Sp", desc = "Inner parameter" },
  -- Annotate
  { "<leader>a", desc = "Annotate" },
  { "<leader>ac", desc = "Class" },
  { "<leader>af", desc = "Function" },
  { "<leader>at", desc = "Type" },
  -- Buffers
  { "<leader>b", group = "Buffers" },
  { "<leader>bd", desc = "Delete buffer" },
  { "<leader>bp", desc = "Pick buffer" },
  -- Tabs
  { "<leader>t", group = "Tabs" },
  { "<leader>tc", desc = "Close tab" },
  { "<leader>th", desc = "Move left" },
  { "<leader>tj", desc = "Move first" },
  { "<leader>tk", desc = "Move last" },
  { "<leader>tl", desc = "Move right" },
  { "<leader>to", desc = "Only this tab" },
  { "<leader>tt", desc = "New tab" },
  -- Code
  { "<leader>c", group = "Code" },
  { "<leader>cD", desc = "Line diagnostics" },
  { "<leader>cR", desc = "Restart LSP client" },
  { "<leader>ca", desc = "Code action" },
  { "<leader>cd", desc = "Definition" },
  { "<leader>ch", desc = "Hints (inlay)" },
  { "<leader>ci", desc = "Lsp info" },
  { "<leader>cr", desc = "Rename" },
  -- Git
  { "<leader>g", group = "Git" },
  { "<leader>gb", desc = "Branches" },
  { "<leader>gc", desc = "Commits" },
  { "<leader>gh", desc = "Hunk" },
  { "<leader>gs", desc = "Status" },
  { "<leader>gw", desc = "Blame (who)" },
  -- Replace
  { "<leader>r", group = "Replace" },
  { "<leader>rc", desc = "Replace with confirmation" },
  { "<leader>rr", desc = "Replace all entries" },
  { "<leader>rs", desc = "Replace one entry" },
  -- Find
  { "<leader>f", group = "Find" },
  { "<leader>fm", desc = "Marks" },
  { "<leader>fo", desc = "Options" },
  { "<leader>fp", desc = "Project" },
  { "<leader>fr", desc = "Registers" },
  { "<leader>ft", desc = "Tabs" },
  { "<leader>fw", desc = "Word" },
  { "<leader>fB", desc = "Builtins" },
  { "<leader>fC", desc = "Colorscheme" },
  { "<leader>fE", desc = "Workspace line" },
  { "<leader>fH", desc = "Highlights" },
  { "<leader>fO", desc = "Oldfiles" },
  { "<leader>fS", desc = "Symbols" },
  { "<leader>fT", desc = "Todo-comments" },
  { "<leader>fa", desc = "Autocommands" },
  { "<leader>fb", desc = "Buffers" },
  { "<leader>fc", desc = "Commands" },
  { "<leader>fd", desc = "Devdocs" },
  { "<leader>fe", desc = "Buffer line" },
  { "<leader>ff", desc = "Files" },
  { "<leader>fh", desc = "Help" },
  { "<leader>fg", desc = "Live grep" },
  { "<leader>fk", desc = "Keymaps" },
  -- Find LSP
  { "<leader>fl", group = "Lsp" },
  { "<leader>flD", desc = "Workspace diagnostics" },
  { "<leader>flS", desc = "Workspace symbols" },
  { "<leader>fld", desc = "Document diagnostics" },
  { "<leader>fli", desc = "Implementations" },
  { "<leader>flr", desc = "References" },
  { "<leader>fls", desc = "Document symbols" },
  -- Find LSP Calls
  { "<leader>flc", group = "Calls" },
  { "<leader>flci", desc = "Incoming" },
  { "<leader>flco", desc = "Outgoing" },
  -- Hidden
  { "<leader>B", hidden = true, desc = "List buffers" },
  { "<leader>B", hidden = true, desc = "List buffers" },
}
