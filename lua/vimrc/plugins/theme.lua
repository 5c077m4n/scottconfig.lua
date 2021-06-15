vim.g.tokyonight_style = 'night'
vim.g.tokyonight_sidebars = {'qf', 'vista_kind', 'terminal', 'packer'}
vim.cmd [[
try
	colorscheme tokyonight
catch /^Vim\%((\a\+)\)\=:E185/
	colorscheme default
	set background=dark
endtry
]]
vim.cmd [[
augroup no_tabline_in_dashboard
	autocmd!
	autocmd FileType dashboard setlocal showtabline=0
	autocmd WinLeave setlocal showtabline=2
augroup END
]]

require'colorizer'.setup()
require'bufferline'.setup {
	options = {
		numbers = 'both',
		mappings = false,
		offsets = {{filetype = 'NvimTree', text = 'File Explorer', highlight = 'Directory', text_align = 'left'}},
		diagnostics = 'nvim_lsp',
		diagnostics_indicator = function(count, _level, _diagnostics_dict, _context)
			return '(' .. count .. ')'
		end,
	},
}
require'todo-comments'.setup()
