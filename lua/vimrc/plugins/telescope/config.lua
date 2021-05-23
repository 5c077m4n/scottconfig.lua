local telescope = require'telescope'
local actions = require'telescope.actions'
local trouble = require'trouble.providers.telescope'

telescope.setup {
	defaults = {
		vimgrep_arguments = {
			'ag',
			'--vimgrep',
		},
		mappings = {
			i = { ['<C-t>'] = trouble.open_with_trouble },
			n = { ['<C-t>'] = trouble.open_with_trouble },
		},
	},
}
