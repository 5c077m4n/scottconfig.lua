require'options'
require'plugins'.setup()
-- Needed for the global scope
require'vimp'
require'mappings'

local cmd = vim.cmd

-- Trigger autoread when changing buffers inside while inside vim
pcall(cmd [[
augroup autoread_on_buffer_change
	autocmd!
	autocmd FocusGained,BufEnter * :checktime
augroup END
]])

-- Return to the last editing point when opening files
pcall(cmd [[
augroup last_read_point
	autocmd!
	autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END
]])
