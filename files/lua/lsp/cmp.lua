local cmp = require "cmp"

require "cmp_nvim_lsp"
require "cmp_buffer"
require "cmp_path"
require "cmp_nvim_lua"
require "cmp_calc"
require "cmp_emoji"
require "cmp_nvim_ultisnips"

local tabnine = require "cmp_tabnine"
tabnine:setup {
  max_lines = 100,
  max_num_results = 5,
  sort = true,
}

local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "ﰠ",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "塞",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "פּ",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

cmp.setup {
  formatting = {
    format = function(entry, vim_item)
      -- fancy icons and a name of kind
      vim_item.kind = kind_icons[vim_item.kind] .. " " .. vim_item.kind

      -- set a name for each source
      vim_item.menu = ({
        buffer = "[Buffer]",
        path = "[Path]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        calc = "[Calc]",
        emoji = "[Emoji]",
        ultisnips = "[UltiSnips]",
        cmp_tabnine = "[TabNine]",
      })[entry.source.name]

      return vim_item
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  },
  documentation = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "buffer" },
    { name = "ultisnips" },
    { name = "cmp_tabnine" },
    { name = "path" },
    { name = "calc" },
    { name = "emoji" },
  },
  completion = {
    keyword_length = 2,
  },
}

vim.api.nvim_exec(
  [[
    highlight link CmpItemMenu Identifier
    highlight link CmpItemKind Type
  ]],
  false
)
