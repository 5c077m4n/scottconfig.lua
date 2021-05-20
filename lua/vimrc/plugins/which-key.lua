local which_key = require'which-key'

which_key.setup {
	plugins = {
		marks = true,
		registers = true,
		spelling = {
			enabled = false,
			suggestions = 20,
		},
	},
	triggers = {'<leader>'}
}

which_key.register {
	['<leader>'] = {
		h = {
			name = '+gitsigns',
			p = '+peek',
			b = '+blame',
			r = '+reset hunk',
			R = '+reset buffer',
		},
	},
	{ mode = 'n' },
}
