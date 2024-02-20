local map = require("utils").map

-- Load VS Code snippets
require("luasnip.loaders.from_vscode").lazy_load()

local ls = require "luasnip"

local s = ls.snippet

local snippet_from_nodes = ls.sn
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local fmta = require("luasnip.extras.fmt").fmta
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

local function comment(notation)
  local entry = vim.split(vim.opt.commentstring:get(), "%", true)[1]:gsub(" ", "")

  return string.format("%s %s: (%s) ", entry, notation, os.getenv "USER")
end

-- General snippets
ls.add_snippets("all", {
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

-- Go
local ts_locals = require "nvim-treesitter.locals"
local ts_utils = require "nvim-treesitter.ts_utils"

local get_node_text = vim.treesitter.get_node_text

local transforms = {
  int = function(_, _)
    return t "0"
  end,

  bool = function(_, _)
    return t "false"
  end,

  string = function(_, _)
    return t [[""]]
  end,

  error = function(_, info)
    if info then
      info.index = info.index + 1

      return c(info.index, {
        t(info.err_name),
        t(string.format('errors.Wrap(%s, "%s")', info.err_name, info.func_name)),
      })
    else
      return t "err"
    end
  end,

  -- Types with a "*" mean they are pointers, so return nil
  [function(text)
    return string.find(text, "*", 1, true) ~= nil
  end] = function(_, _)
    return t "nil"
  end,
}

local transform = function(text, info)
  local condition_matches = function(condition, ...)
    if type(condition) == "string" then
      return condition == text
    else
      return condition(...)
    end
  end

  for condition, result in pairs(transforms) do
    if condition_matches(condition, text, info) then
      return result(text, info)
    end
  end

  return t(text)
end

local handlers = {
  parameter_list = function(node, info)
    local result = {}

    local count = node:named_child_count()
    for idx = 0, count - 1 do
      local matching_node = node:named_child(idx)
      local type_node = matching_node:field("type")[1]
      table.insert(result, transform(get_node_text(type_node, 0), info))
      if idx ~= count - 1 then
        table.insert(result, t { ", " })
      end
    end

    return result
  end,

  type_identifier = function(node, info)
    local text = get_node_text(node, 0)
    return { transform(text, info) }
  end,
}

local function_node_types = {
  function_declaration = true,
  method_declaration = true,
  func_literal = true,
}

local function go_result_type(info)
  local cursor_node = ts_utils.get_node_at_cursor()
  local scope = ts_locals.get_scope_tree(cursor_node, 0)

  local function_node
  for _, v in ipairs(scope) do
    if function_node_types[v:type()] then
      function_node = v
      break
    end
  end

  if not function_node then
    print "Not inside of a function"
    return t ""
  end

  local query = vim.treesitter.query.parse(
    "go",
    [[
      [
        (method_declaration result: (_) @id)
        (function_declaration result: (_) @id)
        (func_literal result: (_) @id)
      ]
    ]]
  )
  for _, node in query:iter_captures(function_node, 0) do
    if handlers[node:type()] then
      return handlers[node:type()](node, info)
    end
  end
end

local go_ret_vals = function(args)
  return snippet_from_nodes(
    nil,
    go_result_type {
      index = 0,
      err_name = args[1][1],
      func_name = args[2][1],
    }
  )
end

ls.add_snippets("go", {
  s(
    "efi",
    fmta(
      [[
<val>, <err> := <f>(<args>)
if <err_same> != nil {
	return <result>
}
<finish>
]],
      {
        val = i(1),
        err = i(2, "err"),
        f = i(3),
        args = i(4),
        err_same = rep(2),
        result = d(5, go_ret_vals, { 2, 3 }),
        finish = i(0),
      }
    )
  ),
})
