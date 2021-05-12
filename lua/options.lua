local utils = require'utils'

local o = vim.o
local g = vim.g

g.mapleader = ' '
g.python3_host_prog = utils.trim(vim.fn.system('which python3'))

-- Configure backspace so it acts as it should act
o.backspace = 'eol,start,indent'

o.updatetime = 300
o.termguicolors = true
o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.history = 5000
o.tabstop = 4
o.shiftwidth = o.tabstop
o.ai = true
o.si = true
o.wrap = true

o.completeopt = 'menuone,noselect'

-- Line numbering
o.number = true
o.relativenumber = true

o.langmenu = 'en'
o.wildmenu = true
o.wildignore = '*.o,*~,*.pyc'
o.encoding = 'utf8'
o.hidden = true

-- Default split positions
o.splitbelow = true
o.splitright = true

o.ignorecase = true
o.smartcase = true
o.hlsearch = true
-- Makes search act like search in modern browsers
o.incsearch = true
-- Don't redraw while executing macros (good performance config)
o.lazyredraw = true
-- For regular expressions turn magic on
o.magic = true
-- Show matching brackets when text indicator is over them
o.showmatch = true
-- How many tenths of a second to blink when matching brackets
o.mat = 2

o.undodir = os.getenv('HOME') .. '/undodir'
o.undofile = true