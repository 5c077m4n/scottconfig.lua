local telescope = require 'telescope'
local _actions = require 'telescope.actions'
local trouble = require 'trouble.providers.telescope'

require'session-lens'.setup {shorten_path = true, theme_conf = {border = true}}
require'telescope'.load_extension 'dap'

telescope.setup {
	defaults = {
		mappings = {i = {['<C-t>'] = trouble.open_with_trouble}, n = {['<C-t>'] = trouble.open_with_trouble}},
	},
}
