require('github-theme').setup {
	themeStyle = 'dimmed',
	functionStyle = 'italic',
	sidebars = { 'qf', 'vista_kind', 'terminal', 'packer' },

	-- Change the "hint" color to the "orange" color, and make the "error" color bright red
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
