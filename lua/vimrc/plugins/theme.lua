require('github-theme').setup {
	themeStyle = 'dimmed',
	sidebars = { 'lazygit', 'terminal', 'packer' },
	colors = { hint = 'orange', error = '#ff0000' },
}
require('colorizer').setup()
require('bufferline').setup {
	options = {
		numbers = 'both',
		mappings = false,
		offsets = {
			{
				filetype = 'NvimTree',
				text = 'File Explorer',
				highlight = 'Directory',
				text_align = 'left',
			},
		},
		diagnostics = 'nvim_lsp',
		diagnostics_indicator = function(count, _level, _diagnostics_dict, _context)
			return '(' .. count .. ')'
		end,
	},
}
require('todo-comments').setup()
