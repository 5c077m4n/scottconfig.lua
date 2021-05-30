local telescope_builtin = require'telescope.builtin'
local session_lens = require'session-lens'
local run_in_modifiable_only = require'vimrc.utils'.run_in_modifiable_only

vimp.nnoremap('<leader>fls', run_in_modifiable_only(telescope_builtin.find_files))
vimp.nnoremap('<leader>fgs', run_in_modifiable_only(telescope_builtin.git_files))
vimp.nnoremap('<leader>fs', run_in_modifiable_only(telescope_builtin.live_grep))
vimp.nnoremap('<leader>fb', run_in_modifiable_only(telescope_builtin.buffers))
vimp.nnoremap('<leader>fm', run_in_modifiable_only(telescope_builtin.marks))
vimp.nnoremap('<leader>fo', run_in_modifiable_only(telescope_builtin.oldfiles))
vimp.nnoremap('<leader>fc', run_in_modifiable_only(telescope_builtin.git_commits))
vimp.nnoremap('<leader>fS', run_in_modifiable_only(session_lens.search_session))
vimp.nnoremap('<leader>ffc', run_in_modifiable_only(telescope_builtin.git_bcommits))
vimp.nnoremap('<leader>ffs', run_in_modifiable_only(telescope_builtin.current_buffer_fuzzy_find))
vimp.nnoremap('<leader>fft', run_in_modifiable_only(telescope_builtin.filetypes))

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
		S = 'Sessions',
	},
}
