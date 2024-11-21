vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.g.mapleader=" "
vim.g.have_nerd_font = true

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10

-- **hides**
vim.opt.mouse = 'a'

-- syncs clipboard between nvim and os
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
