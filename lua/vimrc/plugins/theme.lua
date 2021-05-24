vim.g.material_style = 'darker' -- 'darker' | 'lighter' | 'oceanic' | 'palenight' | 'deep ocean'
vim.g.indentLine_fileTypeExclude = {'dashboard'}

vim.cmd [[
augroup no_tabline_in_dashboard
	autocmd!
	autocmd FileType dashboard setlocal showtabline=0 
	autocmd WinLeave setlocal showtabline=2
augroup END
]]

require'material'.set()
require'colorizer'.setup()
require'bufferline'.setup {
	options = {
		numbers = 'both',
		separator_style = 'slant',
		mappings = false,
		diagnostics = 'nvim_lsp',
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			return '(' .. count .. ')'
		end,
		sort_by = function(buffer_a, buffer_b)
			return buffer_a.modified > buffer_b.modified
		end,
	},
}
require'todo-comments'.setup()
