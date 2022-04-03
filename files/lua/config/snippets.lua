local map = require("utils").map

local ls = require "luasnip"

local s = ls.snippet

local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local types = require("luasnip.util.types")
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")

-- Config
ls.config.setup {
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection
  history = true,

  -- Updates as you type
  updateevents = "TextChanged,TextChangedI",
}

-- Helper functions
local function sha256(msg)
  local tmpfile = os.tmpname()
  os.execute([[python -c 'import hashlib; print(hashlib.sha256("]] .. msg .. [[".encode()).hexdigest())' > ]] .. tmpfile)

  local file = io.open(tmpfile)
  local result = file:read()
  file:close()
  os.remove(tmpfile)

  return result
end

local function token_and_hash(nbytes)
  local hexstr = "0123456789abcdfe"
  local token = ""

  for _ = 1, nbytes * 2 do
    local randint = math.random(1, 16)
    token = token .. hexstr:sub(randint, randint)
  end

  return { token, sha256(token) .. ":", "" }
end

local function comment(notation)
  local entry = vim.split(vim.opt.commentstring:get(), "%", true)[1]:gsub(" ", "")

  return string.format("%s %s: (%s) ", entry, notation, os.getenv "USER")
end

-- Snippets
ls.add_snippets("all", {
  s(
    "user",
    fmt("{name}: {token_and_hash}  name: {name_again}\n  <<: *{group}", {
      name = i(1, "username"),
      name_again = rep(1),
      group = i(0, "group"),
      token_and_hash = f(function()
        return token_and_hash(16)
      end),
    })
  ),
  s("todo", f(function() return comment("TODO") end)),
  s("note", f(function() return comment("NOTE") end)),
  s("fix", f(function() return comment("FIX") end)),
  s("warn", f(function() return comment("WARNING") end)),
  s("hack", f(function() return comment("HACK") end)),
})

ls.add_snippets("lua", {
  s(
    "req",
    fmt([[local {} = require "{}"]], {
      f(function(name)
        local parts = vim.split(name[1][1], ".", true)
        return parts[#parts] or ""
      end, { 1 }),
      i(1),
    })
  ),
})

-- Keymaps
-- Expand or jump to next item
map({ "i", "s" }, "<C-j>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end)

-- Jump to previous item
map({ "i", "s" }, "<C-k>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end)

-- Selecting within a list of options.
map("i", "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

-- Load VS Code snippets
require("luasnip.loaders.from_vscode").lazy_load()
