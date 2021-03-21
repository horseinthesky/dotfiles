local packer = require 'packer'
local util = require 'packer.util'

packer.init {
    compile_path = util.join_paths(vim.fn.stdpath('config'), 'packer', 'packer_compiled.vim')
}

local function nightly()
  return vim.fn.has('nvim-0.5') == 1
end

packer.startup(function()
  -- local utils = require 'utils'

  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true}

  -- Fuzzy finder
  -- use {
  --     'nvim-telescope/telescope.nvim',
  --     requires = {
  --       {'nvim-lua/popup.nvim'},
  --       {'nvim-lua/plenary.nvim'},
  --       {'nvim-telescope/telescope-fzy-native.nvim'},
  --     },
  --     cond = nightly,
  --     config = function()
  --       local actions = require('telescope.actions')
  --         require('telescope').setup {
  --           defaults = {
  --             file_sorter = require('telescope.sorters').get_fzy_sorter,

  --             mappings = {
  --               i = {
  --                 ["<C-q>"] = actions.send_to_qflist,
  --                 ['<rsc'] = actions.close,
  --               },
  --             }
  --           },
  --           extensions = {
  --             fzy_native = {
  --               override_generic_sorter = false,
  --               override_file_sorter = true,
  --             }
  --           }
  --         }
  --         require('telescope').load_extension('fzy_native')
  --     end,
  -- }

  -- Lua development
  -- use {'tjdevries/nlua.nvim'}

  -- LSP and completion
  use {'neovim/nvim-lspconfig', cond = nightly}
  use {'nvim-lua/completion-nvim', cond = nightly}
  use {'steelsojka/completion-buffers', cond = nightly}
  use {
    'aca/completion-tabnine',
    run = './install.sh',
    cond = nightly,
  }
  use {
    'onsails/lspkind-nvim',
    cond = nightly,
    config = function()
      require 'lspkind'.init()
    end,
  }
  --
  -- Features
  use {
    'junegunn/fzf.vim',
    cond = nightly,
    requires = {
      'junegunn/fzf',
      run = 'cd ~/.fzf && ./install --all',
      cond = nightly,
    },
    config = function()
      vim.g.fzf_colors = {
        ['hl'] = {'fg', 'Search'},
        ['hl+'] = {'fg', 'Search'},
        ['info'] = {'fg', 'PreProc'},
        ['pointer'] = {'fg', 'Exception'},
        ['bg+'] = {'bg', 'CursorLine', 'CursorColumn'},
        ['marker'] = {'fg', 'Tag'},
      }
      vim.g.fzf_action = {
        ['ctrl-t'] = 'tab split',
        ['ctrl-s'] = 'split',
        ['ctrl-v'] = 'vsplit',
      }
      vim.g.fzf_layout = {
        ['window'] = {
          ['width'] = 1,
          ['height'] = 0.5,
          ['yoffset'] = 1,
        }
      }
      vim.g.fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

      local utils = require 'utils'
      utils.map('n', ';', '<cmd>Files<CR>')
      utils.map('n', '<C-p>', '<cmd>Rg<CR>')
      utils.map('n', '<leader>bl', '<cmd>BLines<CR>')
      utils.map('n', '<leader>m', '<cmd>Maps<CR>')
      utils.map('n', '<leader>co', '<cmd>Commands<CR>')
    end,
  }
  use {
    'SirVer/ultisnips',
    requires = {
      {'honza/vim-snippets', cond = nightly},
    },
    cond = nightly,
    config = function()
      vim.g.UltiSnipsExpandTrigger='<C-s>'
      vim.g.UltiSnipsJumpForwardTrigger='<C-j>'
      vim.g.UltiSnipsJumpBackwardTrigger='<C-k>'

      -- If you want :UltiSnipsEdit to split your window.
      vim.g.UltiSnipsEditSplit="vertical"
    end,
  }
  use {
    'voldikss/vim-floaterm',
    cond = nightly,
    config = function()
      -- vim.g.floaterm_keymap_toggle = '<F3>'
      -- vim.g.floaterm_keymap_new = '<F4>'
      -- vim.g.floaterm_keymap_prev = '<F5>'
      -- vim.g.floaterm_keymap_next = '<F6>'
      vim.g.floaterm_position = 'bottom'
      vim.g.floaterm_width = 1.001
      vim.g.floaterm_height = 0.3

      local utils = require 'utils'
      utils.map('n', '<F3>', '<cmd>FloatermToggle<CR>')
      utils.map('t', '<F3>', '<cmd>FloatermToggle<CR>')
      utils.map('n', '<F4>', '<cmd>FloatermNew python<CR>')
      utils.map('t', '<F4>', '<cmd>FloatermNew python<CR>')
      utils.map('n', '<F5>', '<cmd>FloatermPrev<CR>')
      utils.map('t', '<F5>', '<cmd>FloatermPrev<CR>')
      utils.map('n', '<F6>', '<cmd>FloatermNext<CR>')
      utils.map('t', '<F6>', '<cmd>FloatermNext<CR>')
    end,
  }
  use {'liuchengxu/vim-which-key', cond = nightly}
  use {'dstein64/vim-startuptime', cond = nightly}
  use {
    'easymotion/vim-easymotion',
    cond = nightly,
    config = function()
      vim.g.EasyMotion_do_mapping = 0
      vim.g.EasyMotion_smartcase = 1

      local utils = require 'utils'
      utils.map('n', 'f', ':call EasyMotion#S(1,0,2)<CR>')
    end,
  }
  use {
    'mg979/vim-visual-multi',
    branch = 'master',
    cond = nightly,
    config = function()
      vim.g.VM_mouse_mappings = 1
    end,
  }
  use {
    'matze/vim-move',
    cond = nightly,
    config = function ()
      vim.g.move_key_modifier = 'S'
    end,
  }
  use {'tpope/vim-surround', cond = nightly}
  use {'tpope/vim-commentary', cond = nightly}
  use {'tpope/vim-repeat', cond = nightly}
  use {
    'tpope/vim-fugitive',
    cond = nightly,
    config = function ()
      local utils = require 'utils'
      utils.map('n', '<leader>gd', '<cmd>Gvdiffsplit!<CR>')
      utils.map('n', 'gdh', '<cmd>diffget //2<CR>')
      utils.map('n', 'gdl', '<cmd>diffget //3<CR>')
    end,
  }
  use {'godlygeek/tabular', cond = nightly}
  use {
    'majutsushi/tagbar',
    cond = nightly,
    config = function ()
      local utils = require 'utils'
      utils.map('n', '<F8>', '<cmd>TagbarToggle<CR>')
      vim.g.tagbar_autofocus = 1
      vim.g.tagbar_autoclose = 1
      vim.g.tagbar_sort = 1
    end,
  }
  use {
    'simnalamburt/vim-mundo',
    cond = nightly,
    config = function()
      local utils = require 'utils'
      utils.map('n', '<F7>', '<cmd>MundoToggle<CR>')
      vim.g.mundo_prefer_python3 = 1
      vim.g.mundo_width = 25
      vim.g.mundo_preview_bottom = 1
      vim.g.mundo_close_on_revert = 1
      -- vim.g.mundo_preview_height = 1
      -- vim.g.mundo_right = 1
    end,
  }
  use {
    'AndrewRadev/sideways.vim',
    cond = nightly,
    config = function()
      local utils = require 'utils'
      utils.map('n', '<leader>h', '<cmd>SidewaysLeft<CR>')
      utils.map('n', '<leader>l', '<cmd>SidewaysRight<CR>')
    end,
  }
  -- use {
  --   'kkoomen/vim-doge',
  --   run = ':call doge#install()',
  --   config = function()
  --     -- Runs on <leader>d and TAB/S-TAB for jumping TODOs
  --     vim.g.doge_doc_standard_python = 'google'
  --   end,
  -- }
  use {'will133/vim-dirdiff', cond = nightly}
  use {
    'AndrewRadev/linediff.vim',
    cond = nightly,
    config = function()
      local utils = require 'utils'
      utils.map('n', '<leader>ld', ':Linediff<CR>')
      utils.map('x', '<leader>ld', ':Linediff<CR>')
      utils.map('n', '<leader>lr', '<cmd>LinediffReset<CR>')
    end
  }

  -- Visuals
  use {
    'mhinz/vim-startify',
    cond = nightly,
    config = function()
      vim.g.startify_files_number = 10
      vim.g.startify_session_persistence = 1
      vim.g.startify_bookmarks = {
        { ['v'] = '~/.config/nvim/init.vim' },
        { ['z'] = '~/.zshrc' },
      }
      vim.g.startify_lists = {
        { ['type'] = 'bookmarks', ['header'] = {'   Bookmarks'} },
        { ['type'] = 'dir',       ['header'] = {'   Recent files'} },
        { ['type'] = 'sessions',  ['header'] = {'   Saved sessions'} },
      }

      local utils = require 'utils'
      utils.map('n', '<leader>ss', '<cmd>SSave!<CR>')
      utils.map('n', '<leader>sl', '<cmd>SLoad!<CR>')
      utils.map('n', '<leader>sc', '<cmd>SClose!<CR>')
      utils.map('n', '<leader>sd', '<cmd>SDelete!<CR>')
    end,
  }
  use {'morhetz/gruvbox', cond = nightly}
  use {'lifepillar/vim-solarized8', cond = nightly}
  use {
    'chrisbra/Colorizer',
    cond = nightly,
    config = function()
      local utils = require 'utils'
      utils.map('n', '<leader>ct', '<cmd>ColorToggle<CR>')
      utils.map('n', '<leader>cs', '<cmd>ColorSwapFgBg<CR>')
    end,
  }
  use {
    'yggdroot/indentline',
    cond = nightly,
    config = function()
      vim.g.indentLine_fileTypeExclude = {
        'help',
        'tagbar',
        'markdown',
        'startify',
        'json'
      }
      vim.g.indentLine_char_list = {'|', '¦', '┆', '┊'}
      -- vim.g.indentLine_setColors = 0
      vim.g.indentLine_color_term = 239

      local utils = require 'utils'
      utils.map('n', '<leader>i', '<cmd>IndentLinesToggle<CR>')
    end,
  }
  use {
    'blueyed/vim-diminactive',
    cond = nightly,
    config = function ()
      vim.g.diminactive_use_syntax = 1
    end,
  }
  use {
    'ntpeters/vim-better-whitespace',
    cond = nightly,
    config = function()
      vim.g.better_whitespace_ctermcolor = 167

      local utils = require 'utils'
      utils.map('n', ']w', '<cmd>NextTrailingWhitespace<CR>')
      utils.map('n', '[w', '<cmd>PrevTrailingWhitespace<CR>')
    end,
  }
  -- use {
  --   'nvim-treesitter/nvim-treesitter',
  --   run = ':TSUpdate',
  --   cond = nightly,
  --   config = function()
  --     require'nvim-treesitter.configs'.setup {
  --       ensure_installed = 'maintained',
  --       highlight = {
  --         enable = true,
  --       },
  --     }
  --   end,
  -- }

  -- Statusine
  use {
    'glepnir/galaxyline.nvim',
     branch = 'main',
     requires = {
       {
         'kyazdani42/nvim-web-devicons',
         -- cond = nightly,
       },
       {
         'lewis6991/gitsigns.nvim',
         requires = {
           {
             'nvim-lua/plenary.nvim',
             -- cond = nightly,
           },
         },
         -- cond = nightly,
         config = function()
           require 'gitsigns'.setup {
             signs = {
               add          = {hl = 'DiffAdd'   , text = ' '},
               change       = {hl = 'DiffChange', text = ' '},
               delete       = {hl = 'DiffDelete', text = ' '},
               topdelete    = {hl = 'DiffDelete', text = ' '},
               changedelete = {hl = 'DiffChange', text = ' '},
             }
           }
         end,
       },
     },
     -- cond = nightly,
     -- after = 'nvim-web-devicons',
     config = function() require 'statusline' end,
   }
  -- use {
  --   'glepnir/galaxyline.nvim',
  --    branch = 'main',
  --    requires = {
  --      {
  --        'kyazdani42/nvim-web-devicons',
  --        opt = true,
  --      },
  --    },
  --    cond = nightly,
  --    after = 'nvim-web-devicons',
  --    config = function() require 'statusline' end,
  -- }
  use {
    'akinsho/nvim-bufferline.lua',
    cond = nightly,
    config = function()
      require 'bufferline'.setup {
        options = {
          buffer_close_icon = '',
          modified_icon = '●',
          close_icon = '',
          left_trunc_marker = '',
          right_trunc_marker = '',
          max_name_length = 14,
          max_prefix_length = 13,
          tab_size = 5,
          enforce_regular_tabs = true,
          view = 'multiwindow',
          show_buffer_close_icons = true,
          separator_style = 'thin'
        },
        highlights = {
          background = {
            guifg = comment_fg,
            guibg = '#282c34'
          },
          fill = {
            guifg = comment_fg,
            guibg = '#282c34'
          },
          buffer_selected = {
            guifg = normal_fg,
            guibg = '#3A3E44',
            gui = 'bold'
          },
          separator_visible = {
            guifg = '#282c34',
            guibg = '#282c34'
          },
          separator_selected = {
            guifg = '#282c34',
            guibg = '#282c34'
          },
          separator = {
            guifg = '#282c34',
            guibg = '#282c34'
          },
          indicator_selected = {
            guifg = '#282c34',
            guibg = '#282c34'
          },
          modified_selected = {
            guifg = string_fg,
            guibg = '#3A3E44'
          }
        }
      }
    end,
  }

end)
