local telescope_builtin = require'telescope.builtin'

vimp.nnoremap('<leader>ffl', function() telescope_builtin.find_files() end)
vimp.nnoremap('<leader>fsr', function() telescope_builtin.live_grep() end)
vimp.nnoremap('<leader>fb', function() telescope_builtin.buffers() end)
