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
        { "gs", desc = "Split/join array" },
        ---- Hide default g keymaps
        { "gN", hidden = true, desc = "Search backwards and select" },
        { "gw", hidden = true, desc = "Format" },
        { "gx", hidden = true, desc = "Open file with system app" },
        { "g%", hidden = true, desc = "Cycle backwards through results" },
        { "g'", hidden = true, desc = "marks" },
        { "g`", hidden = true, desc = "marks" },
        { "g~", hidden = true, desc = "Toggle cases" },
        { "g,", hidden = true, desc = "Go to [count] newer position in change list" },
        { "g;", hidden = true, desc = "Go to [count] older position in change list" },
        -- Hide default lsp keymaps
        { "gO", hidden = true, desc = "Document diagnostic" },
        { "gra", hidden = true, desc = "Code actions" },
        { "grn", hidden = true, desc = "Code rename" },
        { "grr", hidden = true, desc = "Code references" },
        { "gri", hidden = true, desc = "Code implementation" },
        { "grt", hidden = true, desc = "Type definition" },
        { "grx", hidden = true, desc = "Codelens run" },

        -- ] Next
        { "]b", desc = "Buffer" },
        { "]d", desc = "Definition" },
        { "]h", desc = "Git hunk" },
        { "]l", desc = "Loclist entry" },
        { "]q", desc = "Quickfixlist entry" },
        { "]w", desc = "Whitespace" },
        { "]a", hidden = true, desc = "next" },
        { "]A", hidden = true, desc = "last" },
        { "]B", hidden = true, desc = "blast" },
        { "]L", hidden = true, desc = "llast" },
        { "]Q", hidden = true, desc = "clast" },
        { "]T", hidden = true, desc = "tlast" },
        { "]w", hidden = true, desc = "whitespace" },
        { "]D", hidden = true, desc = "Jump to the last diagnostic in the current buffer" },
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
        { "[a", hidden = true, desc = "previous" },
        { "[A", hidden = true, desc = "rewind" },
        { "[B", hidden = true, desc = "brewind" },
        { "[L", hidden = true, desc = "lrewind" },
        { "[Q", hidden = true, desc = "crewind" },
        { "[T", hidden = true, desc = "trewind" },
        { "[w", hidden = true, desc = "whitespace" },
        { "[D", hidden = true, desc = "Jump to the first diagnostic in the current buffer" },
        { "[m", hidden = true, desc = "Goto prev method start" },
        { "[M", hidden = true, desc = "Goto prev method end" },
        { "[s", hidden = true, desc = "Misspelled word" },
        { "[%", hidden = true, desc = "Unmatched group" },
        { "[{", hidden = true, desc = "{" },
        { "[(", hidden = true, desc = "(" },
        { "[<", hidden = true, desc = "<" },
        { "[]", hidden = true, desc = "]" },
        { "[[", hidden = true, desc = "[" },
      }
    end,
  },
}
