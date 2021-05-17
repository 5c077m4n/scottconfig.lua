local telescope_builtin = require'telescope.builtin'

vimp.nnoremap('<leader>ffl', telescope_builtin.find_files)
vimp.nnoremap('<leader>fs', function()
	telescope_builtin.live_grep { search_dir = {vim.fn.getcwd()} }
end)
vimp.nnoremap('<leader>ffs', telescope_builtin.current_buffer_fuzzy_find)
vimp.nnoremap('<leader>fb', telescope_builtin.buffers)
vimp.nnoremap('<leader>fc', telescope_builtin.git_commits)
vimp.nnoremap('<leader>ffc', telescope_builtin.git_bcommits)
