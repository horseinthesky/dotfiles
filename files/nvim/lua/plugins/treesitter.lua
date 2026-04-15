local nmap = require("config.utils").nmap

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
      },
      "nvim-treesitter/nvim-treesitter-context",
    },
    build = ":TSUpdate",
    lazy = false,
    config = function()
      -- Install parsers
      local parsers = {
        "bash",
        "dockerfile",
        "go",
        "gomod",
        "gosum",
        "hcl",
        "json",
        "just",
        "lua",
        "make",
        "markdown",
        "python",
        "regex",
        "rust",
        "toml",
        "yaml",
      }

      require("nvim-treesitter").install(parsers)

      -- Textobjects plugin setup
      require("nvim-treesitter-textobjects").setup {
        select = {
          include_surrounding_whitespace = true,
        },
      }

      -- Swap
      local swap_objects = {
        b = "@block.outer",
        c = "@class.outer",
        f = "@function.outer",
        p = "@parameter.inner",
      }

      local swap = require "nvim-treesitter-textobjects.swap"

      -- Select
      local select_objects = {
        ["oc"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["of"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ob"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["ol"] = "@loop.outer",
        ["il"] = "@loop.inner",
      }

      local select = require "nvim-treesitter-textobjects.select"

      -- Move
      local move_objects = {
        goto_next_start = {
          ["]f"] = "@function.outer",
          ["]c"] = "@class.outer",
        },
        goto_next_end = {
          ["]F"] = "@function.outer",
          ["]C"] = "@class.outer",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[c"] = "@class.outer",
        },
        goto_previous_end = {
          ["[F"] = "@function.outer",
          ["[C"] = "@class.outer",
        },
      }

      local move = require "nvim-treesitter-textobjects.move"

      -- Buffer setup
      vim.api.nvim_create_autocmd("FileType", {
        pattern = parsers,
        callback = function(args)
          local buf = args.buf

          -- Textobjects keymaps
          -- swap
          nmap("<leader>s", "", { desc = "+Swap next" })
          nmap("<leader>S", "", { desc = "+Swap previous" })

          for letter, query in pairs(swap_objects) do
            nmap("<leader>s" .. letter, function()
              swap.swap_next(query)
            end, { desc = query })

            nmap("<leader>S" .. letter, function()
              swap.swap_previous(query)
            end, { buffer = buf, desc = query })
          end

          -- select
          for key, query in pairs(select_objects) do
            vim.keymap.set({ "o", "x" }, key, function()
              select.select_textobject(query, "textobjects")
            end, { buffer = buf, desc = query })
          end

          -- move
          for method, keymaps in pairs(move_objects) do
            for key, query in pairs(keymaps) do
              nmap(key, function()
                move[method](query)
              end, { buffer = buf, desc = query })
            end
          end

          -- Indent
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

          -- Highlights if only < 1 Mb
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > 1024 * 1024 then
            return
          end

          pcall(vim.treesitter.start, buf)
        end,
      })

      -- Context plugin setup
      require("treesitter-context").setup()
      nmap("<leader>O", require("treesitter-context").toggle, { desc = "Treesitter context toggle" })
    end,
  },
}
