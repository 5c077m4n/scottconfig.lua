require'options'
require'plugins'.setup()
require'plugins'.initPackages()

local cmd = vim.cmd

-- Trigger autoread when changing buffers inside while inside vim
cmd [[
augroup autoread_on_buffer_change
	autocmd!
	autocmd BufEnter * :checktime
augroup END
]]

-- Return to the last editing point when opening files
cmd [[
augroup last_read_point
	autocmd!
	autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END
]]
