local nvim_tree = require('nvim-tree')
local tree_cb = require('nvim-tree.config').nvim_tree_callback

local g = vim.g
g.nvim_tree_indent_markers = 1
g.nvim_tree_hide_dotfiles = 0
g.nvim_tree_git_hl = 1
g.nvim_tree_add_trailing = 1

nvim_tree.setup({
	disable_netrw = true,
	hijack_netrw = true,
	open_on_setup = true,
	ignore_ft_on_setup = {},
	open_on_tab = true,
	hijack_cursor = false,
	update_cwd = false,
	lsp_diagnostics = true,
	update_focused_file = {
		enable = true,
		update_cwd = false,
		ignore_list = {},
	},
	view = {
		side = 'left',
		width = 40,
		auto_resize = true,
		mappings = {
			custom_only = true,
			list = {
				{ key = { '<CR>', 'o', '<2-LeftMouse>', '<Right>', 'l' }, cb = tree_cb('edit') },
				{ key = { '<C-]>', 'cd', '<2-RightMouse>' }, cb = tree_cb('cd') },
				{ key = '<C-v>', cb = tree_cb('vsplit') },
				{ key = '<C-h>', cb = tree_cb('split') },
				{ key = '<C-t>', cb = tree_cb('tabnew') },
				{ key = '<', cb = tree_cb('prev_sibling') },
				{ key = '>', cb = tree_cb('next_sibling') },
				{ key = { '<BS>', '<Left>', 'h' }, cb = tree_cb('close_node') },
				{ key = '<Tab>', cb = tree_cb('preview') },
				{ key = 'I', cb = tree_cb('toggle_ignored') },
				{ key = 'H', cb = tree_cb('toggle_dotfiles') },
				{ key = 'R', cb = tree_cb('refresh') },
				{ key = 'a', cb = tree_cb('create') },
				{ key = { '<Del>', 'D' }, cb = tree_cb('remove') },
				{ key = 'r', cb = tree_cb('rename') },
				{ key = '<C-r>', cb = tree_cb('full_rename') },
				{ key = 'dd', cb = tree_cb('cut') },
				{ key = 'yy', cb = tree_cb('copy') },
				{ key = 'p', cb = tree_cb('paste') },
				{ key = '[c', cb = tree_cb('prev_git_item') },
				{ key = ']c', cb = tree_cb('next_git_item') },
				{ key = 'u', cb = tree_cb('dir_up') },
				{ key = 'q', cb = tree_cb('close') },
				{ key = 'o', cb = tree_cb('system_open') },
				{ key = '?', cb = tree_cb('toggle_help') },
			},
		},
	},
})
