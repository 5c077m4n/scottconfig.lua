require'options'
require'plugins'.setup()
require'plugins'.initPackages()

local cmd = vim.cmd

-- Theme
cmd [[
try
	colorscheme molokai
catch /^Vim\%((\a\+)\)\=:E185/
	colorscheme default
	set background=dark
endtry
]]

-- Trigger autoread when changing buffers inside while inside vim
cmd [[
augroup autoread_on_buffer_change
	autocmd!
	autocmd FocusGained,BufEnter * :checktime
augroup END
]]

-- Return to the last editing point when opening files
cmd [[
augroup last_read_point
	autocmd!
	autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END
]]
