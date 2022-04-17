local utils = require('vimrc.utils')
local keymap = require('vimrc.utils.keymapping')

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
local function tab_complete()
	if vim.fn.pumvisible() == 1 then
		return utils.get_termcode('<C-n>')
	elseif vim.fn.call('vsnip#available', { 1 }) == 1 then
		return utils.get_termcode('<Plug>(vsnip-expand-or-jump)')
	elseif utils.check_back_space() then
		return utils.get_termcode('<Tab>')
	else
		return vim.fn['compe#complete']()
	end
end
local function reverse_tab_complete()
	if vim.fn.pumvisible() == 1 then
		return utils.get_termcode('<C-p>')
	elseif vim.fn.call('vsnip#jumpable', { -1 }) == 1 then
		return utils.get_termcode('<Plug>(vsnip-jump-prev)')
	else
		return utils.get_termcode('<S-Tab>')
	end
end

keymap.inoremap('<Tab>', tab_complete, { expr = true })
keymap.snoremap('<Tab>', tab_complete, { expr = true })
keymap.inoremap('<S-Tab>', reverse_tab_complete, { expr = true })
keymap.snoremap('<S-Tab>', reverse_tab_complete, { expr = true })
