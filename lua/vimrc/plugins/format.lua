require'format'.setup {
	['*'] = {
		{cmd = {'sed -i \'s/[ \t]*$//\''}}, -- remove trailing whitespaces
	},
	vim = {{cmd = {'lua-format'}, start_pattern = '^lua << EOF$', end_pattern = '^EOF$'}},
	vimwiki = {{cmd = {'prettier -w --parser babel'}, start_pattern = '^{{{javascript$', end_pattern = '^}}}$'}},
	lua = {{cmd = {function(file) return string.format('lua-format', file) end}}},
	go = {{cmd = {'gofmt -w', 'goimports -w'}, tempfile_postfix = '.tmp'}},
	javascript = {{cmd = {'prettier --write', 'eslint --fix'}}},
	markdown = {
		{cmd = {'prettier --write'}},
		{cmd = {'black'}, start_pattern = '^```python$', end_pattern = '^```$', target = 'current'},
	},
}

vimp.nnoremap({'silent', 'override'}, '<leader>l', ':FormatWrite')
