local telescope = require 'telescope'
local _actions = require 'telescope.actions'
local trouble = require 'trouble.providers.telescope'

telescope.setup {
	defaults = {
		vimgrep_arguments = {
			'rg',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case',
		},
		mappings = {i = {['<C-t>'] = trouble.open_with_trouble}, n = {['<C-t>'] = trouble.open_with_trouble}},
	},
}
require'session-lens'.setup {shorten_path = true, theme_conf = {border = true}}
