-- 'darker' | 'lighter' | 'oceanic' | 'palenight' | 'deep ocean'
vim.g.material_style = 'darker'

require'material'.set()
require'colorizer'.setup()
require'bufferline'.setup {
	separator_style = 'slant',
	diagnostics = 'nvim_lsp',
	sort_by = function(buffer_a, buffer_b)
		return buffer_a.modified > buffer_b.modified
	end,
}
require'todo-comments'.setup()
