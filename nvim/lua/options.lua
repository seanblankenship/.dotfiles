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
  timeoutlen = 500,             -- time before timeout (default 1000)
  title = true,                 -- filename in the terminal window
  titlelen = 0,                 -- full filename in title
  wrap = true,                  -- turn on linewrapping
  undofile = true,              -- persistent undo across session
  updatetime = 100,             -- faster CursorHold actions (default 4000)
}
for k, v in pairs(options) do
  vim.opt[k] = v
end

-- performance overrides for SSHFS remote editing to help with lag
if os.getenv("NVIM_SSHFS") == "1" then
  local remote_options = {
    cursorline = false,      -- avoid extra redraws
    relativenumber = false,  -- cuts down redraw on line movement
    wrap = false,            -- avoids line wrapping 
    undofile = false,        -- don't persist undo over networked FS
    swapfile = false,        -- already false, but defensively repeat
    smoothscroll = false,    -- anything to help performance
    mousemoveevent = false,  -- avoid constant redraws on mouse move
    showmode = false,        -- skip unnecessary UI updates
    cmdheight = 1,           -- limit command area redraw (if unset)
  }
  for k, v in pairs(remote_options) do
    vim.opt[k] = v
  end
  vim.cmd("set noshowcmd")   -- don't show partial commands
  vim.cmd("set lazyredraw")  -- delay redraw in macros and mappings
end