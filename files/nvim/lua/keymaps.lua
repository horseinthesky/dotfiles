local utils = require "utils"

local mappings = {
  -- Miscellaneous
  -- alternate way to save
  { "n", "<C-s>", "<cmd>w<CR>" },
  -- yank all buffer
  { "n", "<leader>A", "<cmd>%y<CR>" },
  -- keep cursor position when J
  { "n", "J", "mzJ'z" },
  -- selects code that was just pasted in the visual mode last used
  { "n", "<leader>v", "'`[' . strpart(getregtype(), 0, 1) . '`]'", { expr = true } },
  -- visual shifting (does not exit Visual mode)
  { "v", "<", "<gv" },
  { "v", ">", ">gv" },
  -- linewise wrapped lines movement
  { "n", "j", "gj" },
  { "n", "k", "gk" },
  -- center search results
  { "n", "n", "nzz" },
  { "n", "N", "Nzz" },
  -- strip all trailing whitespace in the current file while saving last search pattern
  { "n", "<leader>W", "<cmd>let _s=@/ <Bar> %s/\\s\\+$//e <Bar> let @/=_s <Bar> unlet _s<CR>" },
  -- move lines up/down in any mode with Alt+k/j
  { "v", "<A-j>", ":m '>+1<CR>gv=gv" },
  { "v", "<A-k>", ":m '<-2<CR>gv=gv" },
  { "i", "<A-j>", "<esc>:m .+1<CR>==i" },
  { "i", "<A-k>", "<esc>:m .-2<CR>==i" },
  { "n", "<A-j>", ":m .+1<CR>==" },
  { "n", "<A-k>", ":m .-2<CR>==" },

  -- Splits
  { "n", "<leader>;", "<cmd>vsplit n<CR>" },
  { "n", "<leader>'", "<cmd>split n<CR>" },
  -- split navigation
  { "n", "<C-J>", "<C-W><C-J>" },
  { "n", "<C-K>", "<C-W><C-K>" },
  { "n", "<C-L>", "<C-W><C-L>" },
  { "n", "<C-H>", "<C-W><C-H>" },
  -- split resizing
  { "n", "<C-Left>", "<cmd>vertical resize +3<CR>" },
  { "n", "<C-Right>", "<cmd>vertical resize -3<CR>" },
  { "n", "<C-Up>", "<cmd>resize +3<CR>" },
  { "n", "<C-Down>", "<cmd>resize -3<CR>" },
  { "i", "<C-Left>", "<cmd>vertical resize +3<CR>" },
  { "i", "<C-Right>", "<cmd>vertical resize -3<CR>" },
  { "i", "<C-Up>", "<cmd>resize +3<CR>" },
  { "i", "<C-Down>", "<cmd>resize -3<CR>" },

  -- Buffers
  { "n", "]b", "<cmd>bnext<CR>" },
  { "n", "[b", "<cmd>bprev<CR>" },
  { "n", "<leader>B", ":ls<CR>:b<Space>" },
  { "n", "<leader>bd", "<cmd>bdelete<CR>" },
  { "n", "<leader>bo", "<cmd>%bdelete|edit#|bdelete#<CR>" },
  { "n", "<C-w>d", "<cmd>bdelete<CR>" },

  -- Tabs
  { "n", "]t", "<cmd>tabn<CR>" },
  { "n", "[t", "<cmd>tabp<CR>" },
  { "n", "<leader>tt", "<cmd>tabnew<CR>" },
  { "n", "<leader>tc", "<cmd>tabclose<CR>" },
  { "n", "<leader>to", "<cmd>tabonly<cr>" },
  { "n", "<leader>th", "<cmd>-tabmove<CR>" },
  { "n", "<leader>tl", "<cmd>+tabmove<CR>" },
  { "n", "<leader>tj", "<cmd>tabmove 0<CR>" },
  { "n", "<leader>tk", "<cmd>tabmove $<CR>" },
  -- <tab> / <s-tab> | Circular windows navigation
  { "n", "<Tab>", "<cmd>tabn<CR>" },
  { "n", "<S-Tab>", "<cmd>tabp<CR>" },
  -- replace all <tab>s with 4 whitespaces
  { "n", "<leader>T", "<cmd>%s/\t/    /g<CR>" },

  -- Multiple replace
  -- Press * to search for the term under the cursor and then press a key below
  -- to replace all instances of it in the current file.
  -- Second binding is for comfirmation.
  { "n", "<leader>rr", ":%s///g<Left><Left>" },
  { "n", "<leader>rc", ":%s///gc<Left><Left><Left>" },
  -- The same as above but instead of acting on the whole file it will be
  -- restricted to the previously visually selected range. You can do that by
  -- pressing *, visually selecting the range you want it to apply to and then
  -- press a key below to replace all instances of it in the current selection.
  { "x", "<leader>rr", ":s///g<Left><Left>" },
  { "x", "<leader>rc", ":s///gc<Left><Left><Left>" },
  -- Press key below on the word or on visual selection and type a replacement term.
  -- Press . to repeat the replacement again. Useful
  -- for replacing a few instances of the term (comparable to multiple cursors).
  { "n", "<leader>rs", ":let @/='\\<'.expand('<cword>').'\\>'<CR>cgn" },
  { "x", "<leader>rs", '"sy:let @/=@s<CR>cgn' },
}

for _, keymap in ipairs(mappings) do
  local mode, lhs, rhs, opts = unpack(keymap)
  utils.map(mode, lhs, rhs, opts)
end

-- Show filename
utils.map("n", "gn", function()
  utils.info(vim.api.nvim_buf_get_name(0), "Filename")
end)

-- Text-objects
-- https://thevaluable.dev/vim-create-text-objects/
local chars = { "_", ".", ":", ",", ";", "|", "/", "\\", "*", "+", "%", "`", "?" }

for _, char in ipairs(chars) do
  for _, mode in ipairs { "x", "o" } do
    utils.map(mode, "i" .. char, string.format(":<C-u>silent! normal! f%sF%slvt%s<CR>", char, char, char))
    utils.map(mode, "a" .. char, string.format(":<C-u>silent! normal! f%sF%svf%s<CR>", char, char, char))
  end
end
