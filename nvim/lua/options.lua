-- local leader to space
vim.g.mapleader      = " "
vim.g.maplocalleader = " "

-- make it prettier
vim.g.have_nerd_font = true     -- give me all the fancy icons

-- remote files with scamp / scp
vim.g.loaded_netrwPlugin = 1    -- disable netrw since using neotree
vim.g.loaded_netrw       = 1    -- disable netrw itself

-- general options
local options = {
  backup = false,               -- reduce clutter
  breakindent = true,           -- keep indenting on wrapping of long lines
  clipboard = "unnamedplus",    -- use the system clipboard
  --cmdheight = 1,              -- height of command area
  colorcolumn = "120",          -- visual line at 120 chars instead of 80. yes, i am a heathen
  confirm = true,               -- ask for confirmation instead of erroring
  cursorline = true,            -- highlight the current line because i am blind
  cursorlineopt = "both",       -- highlights the number as well as the line
  expandtab = true,             -- use spaces instead of tabs
  fillchars = { eob = " " },    -- hide ~ on empty lines
  linebreak = true,             -- cleaner line wrapping
  ignorecase = true,            -- needed for smartcase to work
  mouse = "a",                  -- enables mouse. again, heathen.
  mousemoveevent = true,        -- enables mouse move events
  number = true,                -- absolute line numbers
  numberwidth = 4,              -- width of the line number column
  relativenumber = true,        -- makes it easier to length to jump up or down
  ruler = true,                 -- cursor position in the status line
  scrolloff = 10,               -- number of lines visible around the cursor
  shiftwidth = 2,               -- consistent tabs
  signcolumn = "yes",           -- avoid text shifting
  smartcase = true,             -- ignores case, unless uppercase, in search
  smartindent = true,           -- used with expandtab
  smoothscroll = true,          -- turn on smoothscrolling
  softtabstop = 2,              -- consistent tabs
  splitbelow = true,            -- horizontal splits below by default
  splitright = true,            -- vertical splits right by default
  swapfile = false,             -- no swp files
  tabstop = 2,                  -- consistent tabs
  termguicolors = true,         -- enable 24-bit color
  title = true,                 -- filename in the terminal window
  titlelen = 0,                 -- full filename in title
  wrap = true,                  -- turn on linewrapping
  undofile = true,              -- persistent undo across session
  updatetime = 300,             -- time before CursorHold fires
}
for k, v in pairs(options) do
  vim.opt[k] = v
end
