require'nvim-treesitter.configs'.setup {
	ensure_installed = {'javascript', 'typescript', 'css', 'html', 'json', 'jsdoc', 'rust', 'graphql', 'regex', 'tsx', 'python', 'yaml', 'lua', 'bash'},
	ignore_install = {}, -- List of parsers to ignore installing
	highlight = {
		enable = true,              -- false will disable the whole extension
		disable = {},  -- list of language that will be disabled
	},
}
