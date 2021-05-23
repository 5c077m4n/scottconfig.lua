local telescope_builtin = require'telescope.builtin'

vimp.nnoremap('<leader>ffl', telescope_builtin.find_files)
vimp.nnoremap('<leader>ffg', telescope_builtin.git_files)
vimp.nnoremap('<leader>fs', telescope_builtin.live_grep)
vimp.nnoremap('<leader>ffs', telescope_builtin.current_buffer_fuzzy_find)
vimp.nnoremap('<leader>fb', telescope_builtin.buffers)
vimp.nnoremap('<leader>fo', telescope_builtin.oldfiles)
vimp.nnoremap('<leader>fc', telescope_builtin.git_commits)
vimp.nnoremap('<leader>ffc', telescope_builtin.git_bcommits)
