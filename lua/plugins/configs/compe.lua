local utils = require'utils'

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
function _G.tab_complete()
	if vim.fn.pumvisible() == 1 then
		return utils.nvim_replace_termcodes'<C-n>'
	elseif vim.fn.call('vsnip#available', {1}) == 1 then
		return utils.nvim_replace_termcodes'<Plug>(vsnip-expand-or-jump)'
	elseif utils.check_back_space() then
		return utils.nvim_replace_termcodes'<Tab>'
	else
		return vim.fn['compe#complete']()
	end
end
function _G.s_tab_complete()
	if vim.fn.pumvisible() == 1 then
		return utils.nvim_replace_termcodes'<C-p>'
	elseif vim.fn.call('vsnip#jumpable', {-1}) == 1 then
		return utils.nvim_replace_termcodes'<Plug>(vsnip-jump-prev)'
	else
		return utils.nvim_replace_termcodes'<S-Tab>'
	end
end

require'compe'.setup {
	enabled = true;
	autocomplete = true;
	debug = false;
	min_length = 1;
	preselect = 'enable';
	throttle_time = 80;
	source_timeout = 200;
	incomplete_delay = 400;
	max_abbr_width = 100;
	max_kind_width = 100;
	max_menu_width = 100;
	documentation = true;

	source = {
		path = true;
		buffer = true;
		calc = true;
		nvim_lsp = true;
		nvim_lua = true;
		vsnip = true;
		ultisnips = true;
	};
}
