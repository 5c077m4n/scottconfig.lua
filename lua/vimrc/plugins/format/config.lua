local function prettierFmt()
	return {
		exe = 'prettier',
		args = {'--stdin-filepath', vim.api.nvim_buf_get_name(0)},
		stdin = true,
		tempfile_dir = '/tmp/fmt-file/',
	}
end

require'formatter'.setup {
	logging = false,
	filetype = {
		javascript = {prettierFmt},
		javascriptreact = {prettierFmt},
		typescript = {prettierFmt},
		typescriptreact = {prettierFmt},
		rust = {
			function()
				return {
					exe = 'rustfmt',
					args = {'--emit=stdout'},
					stdin = true,
					tempfile_dir = '/tmp/fmt-file/',
				}
			end,
		},
		lua = {
			function()
				return {exe = 'lua-format', stdin = true, tempfile_dir = '/tmp/fmt-file/'}
			end,
		},
	},
}

require'surround'.setup {
	prefix = 's',
	mappings_style = 'sandwich',
	pairs = {
		nestable = {{'(', ')'}, {'[', ']'}, {'{', '}'}, {'<', '>'}},
		linear = {{[[']], [[']]}, {[["]], [["]]}},
	},
	brackets = {"(", "{", "[", '<'},
}
