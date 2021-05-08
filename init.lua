local o = vim.o
local g = vim.g

o.tabstop = 4
o.shiftwidth = o.tabstop
g.mapleader = ' '
g.maplocalleader = ','

require'plugins'.bootstrap()
require'plugins'.setup()

require'colors'
require'treesitter'
require'mappings'

require'lsp/typescript'
require'lsp/html'
require'lsp/css'
require'lsp/rust'
require'lsp/lua'

local utils = require'utils'

g.python3_host_prog = utils.trim(vim.fn.system('which python3'))

-- Trigger autoread when changing buffers inside while inside vim
vim.cmd([[
augroup autoread_on_buffer_change
	autocmd!
	autocmd FocusGained,BufEnter * :checktime
augroup END
]])

-- Return to the last editing point when opening files
vim.cmd([[
augroup last_read_point
	autocmd!
	autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END
]])
