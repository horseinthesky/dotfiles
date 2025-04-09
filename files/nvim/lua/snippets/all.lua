local ls = require "luasnip"
local s = ls.snippet
local f = ls.function_node

local function comment(notation)
  local entry = vim.split(vim.opt.commentstring:get(), "%", true)[1]:gsub(" ", "")
  return string.format("%s %s: (%s) ", entry, notation, os.getenv "USER")
end

return {
  s(
    "todo",
    f(function()
      return comment "TODO"
    end)
  ),
  s(
    "note",
    f(function()
      return comment "NOTE"
    end)
  ),
  s(
    "fix",
    f(function()
      return comment "FIX"
    end)
  ),
  s(
    "warn",
    f(function()
      return comment "WARNING"
    end)
  ),
  s(
    "hack",
    f(function()
      return comment "HACK"
    end)
  ),
  s(
    "bug",
    f(function()
      return comment "BUG"
    end)
  ),
}
