local hls = {
  WhichKey = "Special",
  WhichKeyGroup = "Number",
  WhichKeyValue = "Title",
}

for group, link in pairs(hls) do
  vim.api.nvim_set_hl(0, group, { link = link })
end

return {
  {
    "folke/which-key.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      local wk = require "which-key"

      wk.setup {
        preset = "helix",
        icons = {
          breadcrumb = "󰜴",
          separator = "󰜴",
          group = " ",
        },
      }

      wk.add {
        ---- g
        { "gs", desc = "Split/join array" },
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
        { "g,", hidden = true, desc = "Go to [count] newer position in change list" },
        { "g;", hidden = true, desc = "Go to [count] older position in change list" },
        { "gO", hidden = true, desc = "Document diagnostic" },
        { "gra", hidden = true, desc = "Code actions" },
        { "grn", hidden = true, desc = "Code rename" },
        { "grr", hidden = true, desc = "Code references" },
        { "gri", hidden = true, desc = "Code implementation" },

        ---- v
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
        -- Hidden
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
        { "<leader>1", hidden = true, desc = "BufferLineGoToBuffer1" },
        { "<leader>2", hidden = true, desc = "BufferLineGoToBuffer2" },
        { "<leader>3", hidden = true, desc = "BufferLineGoToBuffer3" },
        { "<leader>4", hidden = true, desc = "BufferLineGoToBuffer4" },
        { "<leader>5", hidden = true, desc = "BufferLineGoToBuffer5" },
        { "<leader>6", hidden = true, desc = "BufferLineGoToBuffer6" },
        { "<leader>7", hidden = true, desc = "BufferLineGoToBuffer7" },
        { "<leader>8", hidden = true, desc = "BufferLineGoToBuffer8" },
        { "<leader>9", hidden = true, desc = "BufferLineGoToBuffer9" },

        -- Buffers
        { "<leader>b", group = "Buffers" },
        -- Tabs
        { "<leader>t", group = "Tabs" },
        -- Code
        { "<leader>c", group = "Code" },
        -- Git
        { "<leader>g", group = "Git" },
        -- Replace
        { "<leader>r", group = "Replace" },
        -- Find
        { "<leader>f", group = "Find" },
        -- Find LSP
        { "<leader>fl", group = "Lsp" },
        { "<leader>flc", group = "Calls" },
        -- { "<leader>flci", desc = "Incoming" },
        -- { "<leader>flco", desc = "Outgoing" },

        ---- Treesitter swap
        -- Next
        { "<leader>s", group = "Swap next" },
        { "<leader>sb", desc = "Outer block" },
        { "<leader>sc", desc = "Outer class" },
        { "<leader>sf", desc = "Outer function" },
        { "<leader>sm", desc = "Outer call" },
        { "<leader>sp", desc = "Inner parameter" },
        { "<leader>ss", desc = "Outer statement" },
        -- Prev
        { "<leader>S", group = "Swap previous" },
        { "<leader>Sb", desc = "Outer block" },
        { "<leader>Sc", desc = "Outer class" },
        { "<leader>Sf", desc = "Outer function" },
        { "<leader>Sm", desc = "Outer call" },
        { "<leader>Sp", desc = "Inner parameter" },
        { "<leader>Ss", desc = "Outer statement" },

        ---- Plugins groups
        -- neogen
        { "<leader>a", desc = "Annotate" },
        -- Markview
        { "<leader>m", group = "Markview" },
      }
    end,
  },
}
