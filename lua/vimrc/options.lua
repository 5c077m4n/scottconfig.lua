local utils = require 'vimrc.utils'

local o = vim.opt
local g = vim.g

g.mapleader = ' '
g.maplocalleader = ' '
g.python3_host_prog = utils.trim(vim.fn.system 'which python3')

-- Configure backspace so it acts as it should
o.backspace = { 'eol', 'start', 'indent' }

o.updatetime = 250
o.timeoutlen = 500
o.termguicolors = true
o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.history = 5000
o.tabstop = 4
o.shiftwidth = o.tabstop:get()
o.ai = true
o.si = true
o.wrap = false
o.showbreak = '+'
-- Toggle paste mode
o.pastetoggle = '<F3>'
-- Show tabs and spaces
o.list = true
o.listchars = { tab = '| ', space = '·', trail = '-' }

o.completeopt = { 'menuone', 'noselect' }

-- Incremental live completion
o.inccommand = 'nosplit'

-- Line numbering
o.number = true
o.relativenumber = true

o.langmenu = 'en'
o.wildmenu = true
o.wildignore = { '*.o', '*~', '*.pyc' }
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

o.undodir = os.getenv 'HOME' .. '/undodir'
o.undofile = true
