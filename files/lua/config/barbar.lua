local map = require("utils").map

vim.g.bufferline = {
  icons = "numbers",
  auto_hide = true,
  clickable = false,
  closable = false,
  tabpages = false,
  maximum_padding = 1,
  icon_separator_active = "",
  icon_separator_inactive = "▎",
}

map("n", "<leader>bp", "<cmd>BufferPick<CR>")

if vim.g.colors_name == "gruvbox" then
  if vim.opt.background:get() == "dark" then
    local cmd = [[
      highlight BufferCurrent guifg=#504945 guibg=#bdae93
      highlight BufferCurrentIndex guifg=#fe8019 guibg=#bdae93
      highlight BufferCurrentTarget guifg=#fb4934 guibg=#bdae93
      highlight BufferInactive guifg=#bdae93 guibg=#504945
      highlight BufferInactiveIndex guifg=#fe8019 guibg=#504945
      highlight BufferInactiveTarget guifg=#fb4934 guibg=#504945
      highlight link BufferCurrentSign BufferCurrent
      highlight link BufferCurrentMod BufferCurrent
      highlight link BufferInactiveSign BufferInactive
      highlight link BufferInactiveMod BufferInactive
      highlight BufferTabpageFill guifg=#bdae93 guibg=None
    ]]
    vim.api.nvim_exec(cmd, false)
  else
    local cmd = [[
      highlight BufferCurrent guifg=#d5c4a1 guibg=#665c54
      highlight BufferCurrentIndex guifg=#d65d0e guibg=#665c54
      highlight BufferCurrentTarget guifg=#cc241d guibg=#665c54
      highlight BufferInactive guifg=#665c54 guibg=#d5c4a1
      highlight BufferInactiveIndex guifg=#d65d0e guibg=#d5c4a1
      highlight BufferInactiveTarget guifg=#cc241d guibg=#d5c4a1
      highlight link BufferCurrentSign BufferCurrent
      highlight link BufferCurrentMod BufferCurrent
      highlight link BufferInactiveSign BufferInactive
      highlight link BufferInactiveMod BufferInactive
      highlight BufferTabpageFill guifg=#665c54 guibg=None
    ]]
    vim.api.nvim_exec(cmd, false)
  end
end
