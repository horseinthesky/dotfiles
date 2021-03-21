local utils = require('utils')
local nvim_lsp = require('lspconfig')

-- Completion
vim.g.completion_auto_change_source = 1
-- vim.g.completion_confirm_key = ""
vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}
vim.g.completion_chain_complete_list = {
  default = {
    default = {
      { complete_items = { 'lsp' } },
      { complete_items = { 'snippet', 'UltiSnips' } },
      { complete_items = { 'tabnine' } },
      { complete_items = { 'path', 'buffers' } },
      { mode = { '<c-p>', '<c-n>', 'file' } },
    },
    -- string = {},
    -- comment = {}
  },
  -- vim = {
  --   {complete_items = {'lsp'}},
  --   {complete_items = {'snippet'}},
  --   {mode = 'cmd'}
  -- },
  python = {
    { complete_items = { 'lsp'} },
    { complete_items = { 'snippet', 'UltiSnips' } },
    { complete_items = { 'tabnine' } },
    { complete_items = { 'path', 'buffers' } },
    { mode = { '<c-p>', '<c-n>', 'file' } },
  },
}

-- Servers setup
nvim_lsp.pyls.setup {
  cmd = {'pyls'},
  filetypes = {'python'},
  settings = {
    pyls = {
      plugins = {
        jedi_completion = {enabled = true},
        jedi_hover = {enabled = true},
        jedi_references = {enabled = true},
        jedi_signature_help = {enabled = true},
        jedi_symbols = {enabled = true, all_scopes = true},
        pycodestyle = {enabled = true},
        yapf = {enabled = false},
        pylint = {enabled = false},
        pydocstyle = {enabled = false},
        mccabe = {enabled = false},
        preload = {enabled = false},
        rope_completion = {enabled = false},
      },
    },
  },
  on_attach = require'completion'.on_attach,
}

nvim_lsp.jsonls.setup {
  cmd = {'vscode-json-languageserver', '--stdio'},
  filetypes = {'json', 'jsonc'},
  init_options = {
    provideFormatter = true
  },
  on_attach = require'completion'.on_attach,
}

nvim_lsp.yamlls.setup {
  on_attach = require'completion'.on_attach,
}

nvim_lsp.bashls.setup {
  filetypes = {'zsh', 'bash', 'sh'},
  on_attach = require'completion'.on_attach,
}

nvim_lsp.vimls.setup {
  on_attach = require'completion'.on_attach,
}

-- Format on save
-- vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting()]]

-- Diagnostic
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable/diable virtual text
    virtual_text = {
      spacing = 4,
      prefix = ' ',
    },

    -- Enable/diable diagnistic in Insert mode
    update_in_insert = true,
  }
)

-- LSP keymappings
local lsp_keymappings = {
  {'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>'},
  {'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>'},
  {'n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>'},
  {'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>'},
  {'n', '<leader>xr', '<cmd>lua vim.lsp.buf.rename()<CR>'},
  {'n', '<leader>xa', '<cmd>lua vim.lsp.buf.code_action()<CR>'},
  {'n', '<leader>xd', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>'},
  {'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>'},
  {'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next(vim.lsp.diagnostic.get_next_pos())<CR>'},
  {'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_next(vim.lsp.diagnostic.get_prev_pos())<CR>'},
  -- Use <Tab> and <S-Tab> to navigate through popup menu
  {'i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true}},
  {'i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true}},
}

for _, map in ipairs(lsp_keymappings) do
  mode, lhs, rhs, opts = unpack(map)
  utils.map(mode, lhs, rhs, opts)
end

-- LSP highligths
local hl_cmds = [[
  highlight LspDiagnosticsSignError ctermfg=167 guifg=#fb4934
  highlight LspDiagnosticsSignWarning ctermfg=214 guifg=#fabd2f
  highlight link LspDiagnosticsVirtualTextError LspDiagnosticsSignError
  highlight link LspDiagnosticsVirtualTextWarning LspDiagnosticsSignWarning
]]

vim.api.nvim_exec(hl_cmds, false)

local lsp_signs = {
  LspDiagnosticsSignHint = {
    text = '',
    texthl = 'LspDiagnosticsSignHint'
  },
  LspDiagnosticsSignInformation = {
    text = '',
    texthl = 'LspDiagnosticsSignInformation',
  },
  LspDiagnosticsSignWarning = {
    text = '',
    texthl = 'LspDiagnosticsSignWarning',
  },
  LspDiagnosticsSignError = {
    text = '',
    texthl = 'LspDiagnosticsSignError',
  },
}
for hl_group, config in pairs(lsp_signs) do vim.fn.sign_define(hl_group, config) end

-- vim.api.nvim_exec([[
--   hi LspReferenceRead cterm=bold ctermbg=136 guibg=#b57614
--   hi LspReferenceText cterm=bold ctermbg=136 guibg=#b57614
--   hi LspReferenceWrite cterm=bold ctermbg=239 guibg=#504945
--   augroup lsp_document_highlight
--     autocmd! * <buffer>
--     autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--     autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--   augroup END
-- ]], false)
