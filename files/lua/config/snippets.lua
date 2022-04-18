local map = require("utils").map

-- Load VS Code snippets
require("luasnip.loaders.from_vscode").lazy_load()

local ls = require "luasnip"

local s = ls.snippet

local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local types = require "luasnip.util.types"
local events = require "luasnip.util.events"

-- Config
ls.config.setup {
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection
  history = true,

  -- Updates as you type
  updateevents = "TextChanged,TextChangedI",
}

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

-- Helper functions
local function sha256(msg)
  local tmpfile = os.tmpname()
  os.execute(
    [[python -c 'import hashlib; print(hashlib.sha256("]] .. msg .. [[".encode()).hexdigest())' > ]] .. tmpfile
  )

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

-- General snippets
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
})

-- Lua
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

-- Python
local function node_with_virtual_text(pos, node, text)
  local nodes
  if node.type == types.textNode then
    node.pos = 2
    nodes = { i(1), node }
  else
    node.pos = 1
    nodes = { node }
  end

  return sn(pos, nodes, {
    callbacks = {
      -- node has pos 1 inside the snippetNode.
      [1] = {
        [events.enter] = function(nd)
          -- node_pos: {line, column}
          local node_pos = nd.mark:pos_begin()
          -- reuse luasnips namespace, column doesn't matter, just 0 it.
          nd.virt_text_id = vim.api.nvim_buf_set_extmark(0, ls.session.ns_id, node_pos[1], 0, {
            virt_text = { { text, "GruvboxOrange" } },
          })
        end,

        [events.leave] = function(nd)
          vim.api.nvim_buf_del_extmark(0, ls.session.ns_id, nd.virt_text_id)
        end,
      },
    },
  })
end

local function nodes_with_virtual_text(nodes, opts)
  if opts == nil then
    opts = {}
  end

  local new_nodes = {}

  for pos, node in ipairs(nodes) do
    if opts.texts[pos] ~= nil then
      node = node_with_virtual_text(pos, node, opts.texts[pos])
    end

    table.insert(new_nodes, node)
  end

  return new_nodes
end

local function choice_text_node(pos, choices, opts)
  choices = nodes_with_virtual_text(choices, opts)
  return c(pos, choices, opts)
end

local ct = choice_text_node

ls.add_snippets("python", {
  s(
    "def",
    fmt(
      [[
      def {func}({args}){ret}:
          {doc}
          {body}
      ]],
      {
        func = i(1),
        args = i(2),
        ret = c(3, {
          t "",
          sn(nil, {
            t " -> ",
            i(1),
          }),
        }),
        doc = isn(4, {
          ct(1, {
            sn(
              2,
              fmt(
                [[
                """{desc}
                Args:
                    {args}
                Returns:
                    {returns}
                """
                ]],
                {
                  desc = i(1),
                  args = i(2), -- TODO should read from the args in the function
                  returns = i(3),
                }
              )
            ),
            -- NOTE we need to surround the `fmt` with `sn` to make this work
            sn(1, fmt([["""{desc}"""]], { desc = i(1) })),
            t "",
          }, {
            texts = {
              "(full docstring)",
              "(single line docstring)",
              "(no docstring)",
            },
          }),
        }, "    "),
        body = i(0),
      }
    )
  ),
})
