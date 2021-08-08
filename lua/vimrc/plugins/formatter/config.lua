local function eslint_fmt()
	return {
		exe = 'eslint',
		args = { '--stdin-filename', vim.api.nvim_buf_get_name(0) },
		stdin = true,
		tempfile_dir = '/tmp/fmt-file/',
	}
end
local function prettier_fmt()
	return {
		exe = 'pretter',
		args = { '--stdin-filepath', vim.api.nvim_buf_get_name(0) },
		stdin = true,
		tempfile_dir = '/tmp/fmt-file/',
	}
end

require('formatter').setup({
	logging = false,
	filetype = {
		javascript = { eslint_fmt, prettier_fmt },
		javascriptreact = { eslint_fmt, prettier_fmt },
		typescript = { eslint_fmt, prettier_fmt },
		typescriptreact = { eslint_fmt, prettier_fmt },
		json = { eslint_fmt, prettier_fmt },
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
