return {
  {
    "goolord/alpha-nvim",
    lazy = false,
    config = function()
      -- Header
      local header = {
        type = "text",
        val = {
          [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
          [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
          [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
          [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
          [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
          [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
        },
        opts = {
          position = "center",
          hl = "Title",
        },
      }

      -- Buttons
      local dashboard = require "alpha.themes.dashboard"

      local function button(key, txt, keybind, keybind_opts)
        local b = dashboard.button(key, txt, keybind, keybind_opts)
        b.opts.hl = "Normal"
        b.opts.hl_shortcut = "Type"
        return b
      end

      local buttons = {
        type = "group",
        val = {
          button("e", "  New file", ":ene <BAR> startinsert<CR>"),
          button("r", "  Recent files", ":Telescope oldfiles<CR>"),
          button("f", "󰈞  Find file", ":Telescope find_files<CR>"),
          button("g", "  Live grep", ":Telescope live_grep<CR>"),
          button("p", "  Find project", ":Telescope project<CR>"),
          button("c", "  Configuration", function()
            Snacks.dashboard.pick("files", { cwd = vim.fn.stdpath "config" .. "/lua" })
          end),
          button("q", "  Quit", ":qa<CR>"),
        },
        opts = {
          position = "center",
          spacing = 1,
        },
      }

      -- Quote
      local quote = {
        type = "text",
        val = require "alpha.fortune"(),
        opts = {
          position = "center",
          hl = "Identifier",
        },
      }

      -- Footer
      local function version()
        local ver = vim.version()
        local ver_formatted = "v" .. ver.major .. "." .. ver.minor .. "." .. ver.patch
        local total_plugins = "  " .. #require("lazy").plugins() .. " plugins"
        local datetime = os.date "  %Y-%m-%d  %H:%M:%S"

        return ver_formatted .. datetime .. total_plugins
      end

      local footer = {
        type = "text",
        val = version(),
        opts = {
          hl = "Constant",
          position = "center",
        },
      }

      -- Layout
      -- ┌──────────────────────────────────────────────────────────┐
      -- │                    /                                     │
      -- │      header_padding                                      │
      -- │                    \┌──────────────┐ _                   │
      -- │                     │    header    │  \                  │
      -- │                    /└──────────────┘   \                 │
      -- │  head_quote_padding                     \                │
      -- │                    \┌──────────────┐     \               │
      -- │                     │    quote     │      \              │
      -- │                    /└──────────────┘       \             │
      -- │ quote_button_padding                        \            │
      -- │                    \                         occu_height │
      -- │                  ┌────────────────────┐     /            │
      -- │                  │       button       │    /             │
      -- │                  │       button       │   /              │
      -- │                  │       button       │  /               │
      -- │                  └────────────────────┘‾‾                │
      -- │                    /                                     │
      -- │   foot_butt_padding                                      │
      -- │                    \┌──────────────┐                     │
      -- │                     │    footer    │                     │
      -- │                     └──────────────┘                     │
      -- │                                                          │
      -- └──────────────────────────────────────────────────────────┘

      local head_quote_padding = 2
      local quote_button_padding = 4
      local occu_height = #header.val + #quote.val + 2 * #buttons.val + head_quote_padding + quote_button_padding
      local header_padding = math.max(0, math.ceil((vim.api.nvim_win_get_height(0) - occu_height) * 0.25))
      local foot_butt_padding =
        math.max(0, math.ceil(vim.api.nvim_win_get_height(0) - occu_height - header_padding - 2))

      local config = {
        layout = {
          { type = "padding", val = header_padding },
          header,
          { type = "padding", val = head_quote_padding },
          quote,
          { type = "padding", val = quote_button_padding },
          buttons,
          { type = "padding", val = foot_butt_padding },
          footer,
        },
        opts = {
          margin = 3,
        },
      }

      require("alpha").setup(config)
    end,
    cond = function()
      return vim.api.nvim_buf_get_name(0) == ""
    end,
  },
}
