local o = vim.o
local g = vim.g

o.tabstop = 4
o.shiftwidth = vim.o.tabstop
g.mapleader = ' '
g.maplocalleader = ','

require'packer'.bootstrap()
require'packer'.setup()

require'colors'
require'treesitter'
require'lsp/ts'
require'lsp/rust'
require'mappings'

local utils = require'utils'

g.python3_host_prog = utils.trim(vim.fn.system('which python3'))
