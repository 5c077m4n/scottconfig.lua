local o = vim.o
local g = vim.g

o.tabstop = 4
o.shiftwidth = o.tabstop
g.mapleader = ' '
g.maplocalleader = ','

require'packer'.bootstrap()
require'packer'.setup()

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
