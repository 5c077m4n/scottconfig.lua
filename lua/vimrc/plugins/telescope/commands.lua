local telescope_builtin = require'telescope.builtin'

vimp.nnoremap('<leader>fls', telescope_builtin.find_files)
vimp.nnoremap('<leader>fgs', telescope_builtin.git_files)
vimp.nnoremap('<leader>fs', telescope_builtin.live_grep)
vimp.nnoremap('<leader>fb', telescope_builtin.buffers)
vimp.nnoremap('<leader>fm', telescope_builtin.marks)
vimp.nnoremap('<leader>fo', telescope_builtin.oldfiles)
vimp.nnoremap('<leader>fc', telescope_builtin.git_commits)
vimp.nnoremap('<leader>ffc', telescope_builtin.git_bcommits)
vimp.nnoremap('<leader>ffs', telescope_builtin.current_buffer_fuzzy_find)
vimp.nnoremap('<leader>fft', telescope_builtin.filetypes)

require'which-key'.register {
	['<leader>f'] = {
		name = 'Fuzzy search',
		f = {
			name = '+current file search',
			c = '+commit list',
			s = '+fuzzy find',
			t = '+filetypes',
		},
		ls = 'File list',
		gs = 'Git file list',
		s = 'Live grep',
		b = 'Buffer list',
		o = 'Old files',
		c = 'Git commits',
		m = 'Bookmarks',
	},
}
