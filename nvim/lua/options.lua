-- local leader to space
vim.g.mapleader     = " "
vim.g.maplocallader = " "

-- make it prettier
vim.g.have_nerd_font = true

-- remote files with scamp / scp
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw       = 1

-- tabs
vim.cmd("set expandtab")
vim.cmd("set shiftwidth=2")
vim.cmd("set softtabstop=2")
vim.cmd("set tabstop=2")

-- general options
local options = {
    breakindent = true,
    clipboard = "unnamedplus",
    --cmdheight = 1,
    cursorline = true,
    cursorlineopt = "both",
    mouse = "a",
    mousemoveevent = true,
    number = true,
    numberwidth = 4,
    relativenumber = true,
    ruler = true,
    scrolloff = 10,
    smartcase = true,
    smartindent = true,
    smoothscroll = true,
    splitbelow = true,
    splitright = true,
    swapfile = false,
    title = true,
    titlelen = 0,
}
for k, v in pairs(options) do
    vim.opt[k] = v
end
