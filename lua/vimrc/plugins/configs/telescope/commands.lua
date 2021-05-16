local telescope_builtin = require'telescope.builtin'

vimp.nnoremap('<leader>ffl', telescope_builtin.find_files)
vimp.nnoremap('<leader>fs', function()
	telescope_builtin.live_grep { search_dir = {vim.fn.getcwd()} }
end)
vimp.nnoremap('<leader>fb', telescope_builtin.buffers)
