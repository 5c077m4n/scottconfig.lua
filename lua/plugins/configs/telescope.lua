local telescope_builtin = require'telescope.builtin'

vimp.nnoremap('<leader>ffl', telescope_builtin.find_files)
vimp.nnoremap('<leader>fsr', telescope_builtin.live_grep)
vimp.nnoremap('<leader>fb', telescope_builtin.buffers)
