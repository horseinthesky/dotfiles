local utils = require('utils')

local mappings = {
  -- Splits
  {'n', '<leader>;', '<cmd>vsplit n<CR>'},
  {'n', "<leader>'", '<cmd>split n<CR>'},
  -- split navigation
  {'n', '<C-J>', '<C-W><C-J>'},
  {'n', '<C-K>', '<C-W><C-K>'},
  {'n', '<C-L>', '<C-W><C-L>'},
  {'n', '<C-H>', '<C-W><C-H>'},
  -- split resizing
  {'n', '<C-Left>', '<cmd>vertical resize +3<CR>'},
  {'n', '<C-Right>', '<cmd>vertical resize -3<CR>'},
  {'n', '<C-Up>', '<cmd>resize +3<CR>'},
  {'n', '<C-Down>', '<cmd>resize -3<CR>'},
  {'i', '<C-Left>', '<cmd>vertical resize +3<CR>'},
  {'i', '<C-Right>', '<cmd>vertical resize -3<CR>'},
  {'i', '<C-Up>', '<cmd>resize +3<CR>'},
  {'i', '<C-Down>', '<cmd>resize -3<CR>'},

  -- Buffers
  {'n', ']b', '<cmd>bnext<CR>'},
  {'n', '[b', '<cmd>bprev<CR>'},
  {'n', 'bd', '<cmd>bdelete<CR>'},

  -- Tabs
  {'n', ']t', '<cmd>tabn<CR>'},
  {'n', '[t', '<cmd>tabp<CR>'},
	{'n', 'tt', '<cmd>tabnew<CR>'},
  {'n', 'tl', '<cmd>tabnext<cr>'},
  {'n', 'th', '<cmd>tabprevious<cr>'},
	{'n', 'tj', '<cmd>tablast<CR>'},
	{'n', 'tk', '<cmd>tabfirst<CR>'},
	{'n', 'tc', '<cmd>tabclose<CR>'},
  {'n', 'to', '<cmd>tabonly<cr>'},
	{'n', 'tH', '<cmd>-tabmove<CR>'},
	{'n', 'tL', '<cmd>+tabmove<CR>'},
	{'n', 'tJ', '<cmd>tabmove 0<CR>'},
	{'n', 'tK', '<cmd>tabmove $<CR>'},
  -- <tab> / <s-tab> | Circular windows navigation
  {'n', '<Tab>', '<cmd>tabn<CR>'},
  {'n', '<S-Tab>', '<cmd>tabp<CR>'},

  -- Terminal
  {'t', '<esc>', "(&filetype == 'fzf') ? '<Esc>' : '<c-\\><c-n>'", {expr = true}},
  {'n', '<leader>`', ':10split <Bar> :terminal<CR>'},

  -- quickfix
  {'n', 'qo', '<cmd>copen<CR>'},
  {'n', ']q', '<cmd>cnext<CR>'},
  {'n', '[q', '<cmd>cprev<CR>'},
  {'n', 'qc', '<cmd>cclose<CR>'},

  -- Replace all tabs with 4 whitespaces
  {'n', '<leader>T', '<cmd>%s/\t/    /g<CR>'},

  -- Strip all trailing whitespace in the current file
  {'n', '<leader>W', "<cmd>%s/\\s\\+$//<cr>:let @/=''<CR>"},

  -- Reselect the text that was just pasted
  {'n', '<leader>v', 'V`'},

  -- Visual shifting (does not exit Visual mode)
  {'v', '<', '<gv'},
  {'v', '>', '>gv'},

  -- Reload init.vim
  {'n', '<leader>r', '<cmd>source ~/dotfiles/files/init.vim<CR>'},

  -- Alternate way to save
  {'n', '<C-s>', '<cmd>w<CR>'},

  -- gp selects code that was just pasted in the visual mode last used
  {'n', 'gp', "'`[' . strpart(getregtype(), 0, 1) . '`]'", {expr = true}},

  -- Press * to search for the term under the cursor and then press a key below
  -- to replace all instances of it in the current file.
  -- Second binding is for comfirmation.
  {'n', '<leader>rr', ':%s///g<Left><Left>'},
  {'n', '<leader>rc', ':%s///gc<Left><Left><Left>'},

  -- The same as above but instead of acting on the whole file it will be
  -- restricted to the previously visually selected range. You can do that by
  -- pressing *, visually selecting the range you want it to apply to and then
  -- press a key below to replace all instances of it in the current selection.
  {'x', '<leader>rr', ':s///g<Left><Left>'},
  {'x', '<leader>rc', ':s///gc<Left><Left><Left>'},

  -- Press key below on the word or on visual selection and type a replacement term.
  -- Press . to repeat the replacement again. Useful
  -- for replacing a few instances of the term (comparable to multiple cursors).
  {'n', '<leader>rs', ":let @/='\\<'.expand('<cword>').'\\>'<CR>cgn"},
  {'x', '<leader>rs', '"sy:let @/=@s<CR>cgn'},
}

for _, map in ipairs(mappings) do
  mode, lhs, rhs, opts = unpack(map)
  utils.map(mode, lhs, rhs, opts)
end
