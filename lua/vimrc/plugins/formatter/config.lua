local tempfile_dir = '/tmp/fmt-file'

local function prettier_fmt()
	return {
		exe = 'prettier',
		args = { '--stdin-filepath', vim.api.nvim_buf_get_name(0) },
		stdin = true,
		tempfile_dir = tempfile_dir,
	}
end
local function shell_fmt()
	return {
		exe = 'shfmt',
		stdin = true,
		tempfile_dir = tempfile_dir,
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
					tempfile_dir = tempfile_dir,
				}
			end,
		},
		python = {
			function()
				return { exe = 'autopep8 -', stdin = true, tempfile_dir = tempfile_dir }
			end,
		},
		lua = {
			function()
				return { exe = 'stylua -', stdin = true, tempfile_dir = tempfile_dir }
			end,
		},
		sh = { shell_fmt },
		bash = { shell_fmt },
		zsh = { shell_fmt },
	},
})
