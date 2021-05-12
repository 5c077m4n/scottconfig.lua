require'telescope'.setup {
	defaults = {
		vimgrep_arguments = {
			'ag',
			'--vimgrep',
			'--all-types',
			'--hidden',
			'--smart-case',
		},
	}
}
