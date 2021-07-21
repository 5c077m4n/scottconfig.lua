local function prettierFmt()
	return {
		exe = 'prettier',
		args = { '--stdin-filepath', vim.api.nvim_buf_get_name(0) },
		stdin = true,
		tempfile_dir = '/tmp/fmt-file/',
	}
end

require('formatter').setup {
	logging = false,
	filetype = {
		javascript = { prettierFmt },
		javascriptreact = { prettierFmt },
		typescript = { prettierFmt },
		typescriptreact = { prettierFmt },
		rust = {
			function()
				return {
					exe = 'rustfmt',
					args = { '--emit=stdout' },
					stdin = true,
					tempfile_dir = '/tmp/fmt-file/',
				}
			end,
		},
		lua = {
			function()
				return { exe = 'stylua -', stdin = true, tempfile_dir = '/tmp/fmt-file/' }
			end,
		},
	},
}

require('surround').setup {
	prefix = 'S',
	mappings_style = 'sandwich',
	pairs = {
		nestable = { { '(', ')' }, { '[', ']' }, { '{', '}' }, { '<', '>' } },
		linear = { { [[']], [[']] }, { [["]], [["]] } },
	},
	brackets = { '(', '{', '[', '<' },
}
require('nvim-autopairs').setup()
require('nvim-autopairs.completion.compe').setup {
	map_cr = true, --  map <CR> on insert mode
	map_complete = true, -- it will auto insert `(` after select function or method item
}
