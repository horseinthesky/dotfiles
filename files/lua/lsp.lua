local utils = require "utils"
-- local icons = utils.icons
local lspconfig = require "lspconfig"

-- compe
require'compe'.setup {
  preselect = 'disable',
  source_timeout = 100,

  source = {
    path = {kind = ""},
    buffer = {kind = ""},
    calc = {kind = ""},
    nvim_lsp = {kind = ""},
    nvim_lua = {kind = ""},
    spell = {kind = ""},
    ultisnips = {kind = ""},
    tabnine = {kind = "", priority = 50},
    emoji = {kind = "ﲃ", filetypes={"markdown"}},
  },
}

-- Servers setup
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(client, _)

  utils.opt("omnifunc", "v:lua.vim.lsp.omnifunc")

  local lsp_keymappings = {
    -- {"n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>"},
    -- {"n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>"},
    {"n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>"},
    {"n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>"},
    {"n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>"},
    -- {"n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>"},
    -- {"n", "gr", "<cmd>lua vim.lsp.buf.rename()<CR>"},
    {"n", "<leader>F", "<cmd>lua vim.lsp.buf.formatting()<CR>"},
    {"n", "<leader>td", "<cmd>lua vim.lsp.buf.type_definition()<CR>"},
    {"n", "<leader>rf", "<cmd>lua vim.lsp.buf.references()<CR>"},
    -- {"n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action({ source = { organizeImports = true } })<CR>"},
    -- {"n", "<leader>ld", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>"},
    {"n", "<leader>ll", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>"},
    -- Use <Tab> and <S-Tab> to navigate through popup menu
    {"i", "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true}},
    {"i", "<S-Tab>", 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true}}
  }

  for _, map in ipairs(lsp_keymappings) do
    local mode, lhs, rhs, opts = unpack(map)
    utils.map(mode, lhs, rhs, opts)
  end

  -- Format on save
  -- if client.resolved_capabilities.document_formatting then
  --   vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting()]]
  -- end

  -- Document highlight
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
        hi LspReferenceRead cterm=bold ctermbg=239 guibg=#504945
        hi LspReferenceText cterm=bold ctermbg=239 guibg=#504945
        hi LspReferenceWrite cterm=bold ctermbg=243 guibg=#7c6f64
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]],
      false
    )
  end
end

local efm = require "efm"
local flake8 = efm.flake8
local isort = efm.isort
local autopep8 = efm.autopep8
local mypy = efm.mypy
local luafmt = efm.luafmt
local prettier = efm.prettier

local languages = {
  python = {isort, flake8, autopep8, mypy},
  lua = {luafmt},
  yaml = {prettier},
  json = {prettier},
  html = {prettier},
  css = {prettier},
  markdown = {prettier}
}

lspconfig.efm.setup {
  root_dir = lspconfig.util.root_pattern(".git", "."),
  filetypes = vim.tbl_keys(languages),
  init_options = {documentFormatting = true, codeAction = true},
  settings = {languages = languages, log_level = 1, log_file = "~/efm.log"},
  on_attach = on_attach
}

lspconfig.pyright.setup {
  capabilities = capabilities,
  on_attach = on_attach
}

-- lspconfig.pyls.setup {
--   cmd = {"pyls"},
--   filetypes = {"python"},
--   capabilities = capabilities,
--   settings = {
--     pyls = {
--       configurationSources = {"flake8"},
--       plugins = {
--         jedi_completion = {enabled = true},
--         jedi_hover = {enabled = true},
--         jedi_references = {enabled = true},
--         jedi_signature_help = {enabled = true},
--         jedi_symbols = {enabled = true, all_scopes = true},
--         pycodestyle = {enabled = false},
--         flake8 = {
--           enabled = true,
--           ignore = {},
--           maxLineLength = 160
--         },
--         pyls_mypy = {enabled = true, live_mode = true},
--         pyls_isort = {enabled = true},
--         yapf = {enabled = false},
--         pylint = {enabled = false},
--         pydocstyle = {enabled = false},
--         mccabe = {enabled = false},
--         preload = {enabled = false},
--         rope_completion = {enabled = false}
--       }
--     }
--   },
--   on_attach = on_attach
-- }

local sumneko_root_path = vim.fn.expand("~") .. "/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"

lspconfig.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = vim.split(package.path, ";")
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {"vim"}
      },
      workspace = {
        library = {
          -- Make the server aware of Neovim runtime files
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true
        }
      }
    }
  },
  on_attach = on_attach
}

lspconfig.jsonls.setup {
  cmd = {"vscode-json-languageserver", "--stdio"},
  filetypes = {"json", "jsonc"},
  capabilities = capabilities,
  init_options = {
    provideFormatter = true
  },
  on_attach = on_attach
}

lspconfig.yamlls.setup {
  capabilities = capabilities,
  on_attach = on_attach
}

lspconfig.vimls.setup {
  capabilities = capabilities,
  on_attach = on_attach
}

-- Diagnostic
vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    -- Enable/diable virtual text
    virtual_text = {
      spacing = 4,
      prefix = " "
    },
    -- Enable/diable diagnistic in Insert mode
    update_in_insert = true
  }
)

-- Diagnostic highligths & signs
local hl_cmds =
  [[
  highlight LspDiagnosticsDefaultInformation ctermfg=109 guifg=#83a598
  highlight LspDiagnosticsDefaultHint ctermfg=108 guifg=#8ec07c
  highlight LspDiagnosticsDefaultError ctermfg=167 guifg=#fb4934
  highlight LspDiagnosticsDefaultWarning ctermfg=214 guifg=#fabd2f
]]

vim.api.nvim_exec(hl_cmds, false)

local lsp_signs = {
  LspDiagnosticsSignHint = {
    -- text = icons.hint,
    text = "",
    texthl = "LspDiagnosticsSignHint"
  },
  LspDiagnosticsSignInformation = {
    -- text = icons.info,
    text = "",
    texthl = "LspDiagnosticsSignInformation"
  },
  LspDiagnosticsSignWarning = {
    -- text = icons.warning,
    text = "",
    texthl = "LspDiagnosticsSignWarning"
  },
  LspDiagnosticsSignError = {
    -- text = icons.error,
    text = "",
    texthl = "LspDiagnosticsSignError"
  }
}
for hl_group, config in pairs(lsp_signs) do
  vim.fn.sign_define(hl_group, config)
end
