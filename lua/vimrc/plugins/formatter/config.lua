local function prettier_fmt()
	return {
		exe = 'prettier',
		args = { '--stdin-filepath', vim.api.nvim_buf_get_name(0) },
		stdin = true,
	}
end
local function shell_fmt()
	return {
		exe = 'shfmt',
		stdin = true,
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
				}
			end,
		},
		python = {
			function()
				return { exe = 'autopep8 -', stdin = true }
			end,
		},
		lua = {
			function()
				return { exe = 'stylua -', stdin = true }
			end,
		},
		sh = { shell_fmt },
		bash = { shell_fmt },
		zsh = { shell_fmt },
	},
})
