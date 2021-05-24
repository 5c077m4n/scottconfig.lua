require'neogit'.setup {}
require'gitsigns'.setup {
	signs = {
		add = {hl = 'GitSignsAdd', text = '+', numhl = 'GitSignsAddNr' , linehl = 'GitSignsAddLn'},
		change = {hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn'},
		delete = {hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn'},
		topdelete = {hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn'},
		changedelete = {hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn'},
	},
	watch_index = {
		interval = 800
	},
	current_line_blame = true,
	update_debounce = 500,
}
