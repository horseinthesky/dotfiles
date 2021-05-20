" ==== SPLITS ====
nnoremap <leader>; :vsplit n<CR>
nnoremap <leader>' :split n<CR>

" Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Split resizing
nnoremap <C-Left> <cmd>vertical resize +3<CR>
nnoremap <C-Right> <cmd>vertical resize -3<CR>
nnoremap <C-Up> <cmd>resize +3<CR>
nnoremap <C-Down> <cmd>resize -3<CR>
inoremap <C-Left> <cmd>vertical resize +3<CR>
inoremap <C-Right> <cmd>vertical resize -3<CR>
inoremap <C-Up> <cmd>resize +3<CR>
inoremap <C-Down> <cmd>resize -3<CR>

" ==== Buffers ====
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>
nnoremap <leader>bd :bdelete<cr>

" ==== Tabs ====
" Useful mappings for managing tabs
nnoremap ]t :tabnew<cr>
nnoremap [t :tabprevious<cr>
nnoremap <leader>tt :tabnew<CR>
nnoremap <leader>tl :tabnext<cr>
nnoremap <leader>th :tabprevious<cr>
nnoremap <leader>tj :tablast<CR>
nnoremap <leader>tk :tabfirst<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>to :tabonly<cr>
nnoremap <leader>tH :-tabmove<CR>
nnoremap <leader>tL :+tabmove<CR>
nnoremap <leader>tJ :tabmove 0<CR>
nnoremap <leader>tK :tabmove $<CR>

" <tab> / <s-tab> | Circular windows navigation
nnoremap <tab> :tabn<cr>
nnoremap <S-tab> :tabp<cr>

" ==== Terminal ====
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
nnoremap <leader>` :10split <Bar> :terminal<CR>

" ==== quickfix list ====
nnoremap <leader>qo :copen
nnoremap ]q :cnext<cr>
nnoremap [q :cprev<cr>
nnoremap <leader>qc :cclose<cr>

" ==== location list  ====
nnoremap <leader>lo :lopen
nnoremap ]l :lnext<cr>
nnoremap [l :lprev<cr>
nnoremap <leader>lc :lclose<cr>

" ==== Bindings ====
" Replace all tabs with 4 whitespaces
nnoremap <leader>T :%s/\t/    /g<CR>

" Strip all trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Linewise wrapped lines movement
nnoremap j gj
nnoremap k gk

" Reload current buffer
nnoremap <expr><leader>R (&filetype == 'lua') ? '<cmd>luafile %<CR>' : '<cmd>source %<CR>'

" Alternate way to save
nnoremap <C-s> :w<CR>

"gp selects code that was just pasted in the visual mode last used
nnoremap <expr> <leader>v  '`[' . strpart(getregtype(), 0, 1) . '`]'

" Press * to search for the term under the cursor and then press a key below
" to replace all instances of it in the current file.
" Second binding is for comfirmation.
nnoremap <leader>rr :%s///g<Left><Left>
nnoremap <leader>rc :%s///gc<Left><Left><Left>

" The same as above but instead of acting on the whole file it will be
" restricted to the previously visually selected range. You can do that by
" pressing *, visually selecting the range you want it to apply to and then
" press a key below to replace all instances of it in the current selection.
xnoremap <Leader>rr :s///g<Left><Left>
xnoremap <Leader>rc :s///gc<Left><Left><Left>

" Press key below on the word or on visual selection and type a replacement term.
" Press . to repeat the replacement again. Useful
" for replacing a few instances of the term (comparable to multiple cursors).
nnoremap <leader>rs :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <leader>rs "sy:let @/=@s<CR>cgn
