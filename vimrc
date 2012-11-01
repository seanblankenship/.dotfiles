set nocompatible

" Get that filetype stuff happening
filetype on
filetype plugin on
filetype indent on

syntax enable       " Turn on that syntax highlighting  

set hidden          " Switch between buffers without saving
set lazyredraw      " Don't update the display while executing macros
set showmode        " displays your current mode
set wildmenu        " Enable enhanced command-line completion
set wrapscan        " Set the search scan to wrap around the file
set vb              " set visual bell -- I hate that damned beeping
set backspace=2     " Allow backspacing over indent, eol, and the start of an insert
set laststatus=2    " tell Vim to always put a status line in, even if there is only one window
set mousehide       " Hide the mouse pointer while typin
set history=100     " Keep some stuff in the history
set scrolloff=2     " When the page starts to scroll, keep the cursor 2 lines from the top and 2 lines from the bottom
set virtualedit=all " Allow the cursor to go in to invalid places 
set incsearch       " Incrementally match the search.
set synmaxcol=2048  " Syntax coloring lines that are too long just slows down the world
set number          " turn on line numbers
set expandtab       " Auto expand tabs to spaces
set showmatch       " show matching brackets
set ignorecase	    " Case-insensitive searching

" get rid of .swp files and backups
set nobackup
set nowritebackup
set noswapfile

" Tabstops are 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
"set smartindent

" Setup some default highlighting and tab spacing for some filetypes
autocmd FileType python set ts=8 sts=4 sw=4 expandtab
autocmd FileType html set ts=8 sts=2 sw=2 expandtab
autocmd FileType javascript set ts=8 sts=2 sw=2 expandtab
autocmd BufNewFile,BufRead *.php,*.install,*.profile,*.module,*.inc set ft=php ts=8 sts=2 sw=2 expandtab
autocmd BufNewFile,BufRead *.md,*.markdown set ft=markdown ts=8 sts=4 sw=4 expandtab

" These commands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

" Set the status line
set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ Buf:\ #%n\ [%b][0x%B]

" Maximize on open; on works for windows
au GUIEnter * simalt ~x

" set the colorscheme
set background=dark
colorscheme solarized

" change the font to Consolas
set guifont=Inconolata:h13

" start NERDTree on program load
"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd p
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1

" set the current directory to be the same as the file that is being edited
autocmd BufEnter * silent! lcd %:p:h

" display the current time
nmap <F2> :echo 'Current time is ' . strftime('%c')<CR>

" toggle NERDTree
nmap <F7> :NERDTreeToggle<CR>
nmap <S-F7> :NERDTreeClose<CR>

" fix stupid shift issues
cmap W w
