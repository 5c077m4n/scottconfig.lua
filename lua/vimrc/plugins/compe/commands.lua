local utils = require 'vimrc.utils'

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
function _G.tab_complete()
	if vim.fn.pumvisible() == 1 then
		return utils.get_termcode '<C-n>'
	elseif vim.fn.call('vsnip#available', {1}) == 1 then
		return utils.get_termcode '<Plug>(vsnip-expand-or-jump)'
	elseif utils.check_back_space() then
		return utils.get_termcode '<Tab>'
	else
		return vim.fn['compe#complete']()
	end
end
function _G.s_tab_complete()
	if vim.fn.pumvisible() == 1 then
		return utils.get_termcode '<C-p>'
	elseif vim.fn.call('vsnip#jumpable', {-1}) == 1 then
		return utils.get_termcode '<Plug>(vsnip-jump-prev)'
	else
		return utils.get_termcode '<S-Tab>'
	end
end

vimp.inoremap({'expr'}, '<Tab>', [[v:lua._G.tab_complete()]])
vimp.snoremap({'expr'}, '<Tab>', [[v:lua._G.tab_complete()]])
vimp.inoremap({'expr'}, '<S-Tab>', [[v:lua._G.s_tab_complete()]])
vimp.snoremap({'expr'}, '<S-Tab>', [[v:lua._G.s_tab_complete()]])
