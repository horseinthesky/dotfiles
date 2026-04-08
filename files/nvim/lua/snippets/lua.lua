local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s(
    "reqm",
    fmt([[local {} = require "{}"]], {
      f(function(name)
        local parts = vim.split(name[1][1], ".", { plain = true })
        return parts[#parts] or ""
      end, { 1 }),
      i(1, "package"),
    })
  ),
  s(
    "reqf",
    fmt([[local {} = require("{}").{}]], {
      f(function(args)
        return args[1][1] or ""
      end, { 2 }),
      i(1, "package"),
      i(2, "name"),
    })
  ),
}
