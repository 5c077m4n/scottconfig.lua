local telescope = require('telescope')
local _actions = require('telescope.actions')
local trouble = require('trouble.providers.telescope')

telescope.setup({
	defaults = {
		mappings = {
			i = { ['<C-t>'] = trouble.open_with_trouble },
			n = { ['<C-t>'] = trouble.open_with_trouble },
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = false,
			override_file_sorter = true,
			case_mode = 'smart_case',
		},
	},
})

telescope.load_extension('fzf')
