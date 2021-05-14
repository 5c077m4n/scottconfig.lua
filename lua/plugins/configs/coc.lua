local coc_utils = require'utils.coc'

vim.g.coc_global_extensions = coc_utils.get_coc_extenstions()

pcall(function()
	vim.api.nvim_command [[
	augroup highlight_on_hover
	autocmd!
	autocmd CursorHold * silent call CocActionAsync('highlight')
	augroup END
	]]
end)
