local function prettierFmt()
	return {exe = 'prettier', args = {'--stdin-filepath', vim.api.nvim_buf_get_name(0)}, stdin = true}
end

require'formatter'.setup {
	logging = true,
	filetype = {
		javascript = {prettierFmt],
		javascriptreact = {prettierFmt},
		typescript = {prettierFmt},
		typescriptreact = {prettierFmt},
		rust = {function() return {exe = 'rustfmt', args = {'--emit=stdout'}, stdin = true} end},
		lua = {function() return {exe = 'lua-format', stdin = true} end},
	},
}
