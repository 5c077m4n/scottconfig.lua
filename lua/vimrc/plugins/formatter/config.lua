local function prettier_fmt()
	return {
		exe = 'prettier',
		args = { '--stdin-filepath', vim.api.nvim_buf_get_name(0) },
		stdin = true,
		tempfile_dir = '/tmp/fmt-file/',
	}
end

require('formatter').setup({
	logging = false,
	filetype = {
		javascript = { prettier_fmt },
		javascriptreact = { prettier_fmt },
		typescript = { prettier_fmt },
		typescriptreact = { prettier_fmt },
		json = { prettier_fmt },
		yaml = { prettier_fmt },
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
})
