local coc_utils = require'utils.coc'

local cmd = vim.api.nvim_command

vim.g.coc_global_extensions = coc_utils.get_coc_extenstions()

pcall(function()
	cmd [[
	augroup highlight_on_hover
	autocmd!
	autocmd CursorHold * silent call CocActionAsync('highlight')
	augroup END
	]]
end)
