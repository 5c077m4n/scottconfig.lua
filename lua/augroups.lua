local cmd = vim.cmd

-- Re-read file when re-entering it
pcall(function() 
	cmd [[
	augroup autoread_on_buffer_change
		autocmd!
		autocmd FocusGained,BufEnter * :checktime
	augroup END
	]]
end)

pcall(function()
	cmd [[
	augroup last_read_point_on_file_open
		autocmd!
		autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
	augroup END
	]]
end)

pcall(function()
	cmd [[
	augroup highlight_yank
    	autocmd!
    	autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup = 'IncSearch', timeout = 1000}
	augroup END
	]]
end)

pcall(function() 
	cmd [[
	augroup delete_trailing_spaces_on_save
		autocmd!
		autocmd BufWritePre * silent! lua require'utils'.clean_extra_spaces()
	augroup END
	]]
end)
