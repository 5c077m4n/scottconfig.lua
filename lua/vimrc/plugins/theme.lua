vim.g.indentLine_fileTypeExclude = {'dashboard'}
vim.g.onedark_style = 'warm'

vim.cmd [[
augroup no_tabline_in_dashboard
	autocmd!
	autocmd FileType dashboard setlocal showtabline=0 
	autocmd WinLeave setlocal showtabline=2
augroup END
]]

require'onedark'.setup()
require'colorizer'.setup()
require'bufferline'.setup {
	options = {
		numbers = 'both',
		separator_style = 'slant',
		mappings = false,
		offsets = {{filetype = "NvimTree", text = "File Explorer", highlight = "Directory", text_align = "left"}},
		diagnostics = 'nvim_lsp',
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			return '(' .. count .. ')'
		end,
	},
}
require'todo-comments'.setup()
