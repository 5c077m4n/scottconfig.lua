local tree_cb = require'nvim-tree.config'.nvim_tree_callback

vimp.nnoremap({'silent'}, '<leader>tt', ':NvimTreeToggle<CR>')
vimp.nnoremap({'silent'}, '<leader>tr', ':NvimTreeRefresh<CR>')
vimp.nnoremap({'silent'}, '<leader>ts', ':NvimTreeFindFile<CR>')

vim.g.nvim_tree_bindings = {
	['<CR>'] = tree_cb('edit'),
	['cd'] = tree_cb('cd'),
	['<C-v>'] = tree_cb('vsplit'),
	['<C-h>'] = tree_cb('split'),
	['<C-t>'] = tree_cb('tabnew'),
	['<'] = tree_cb('prev_sibling'),
	['>'] = tree_cb('next_sibling'),
	['<BS>'] = tree_cb('close_node'),
	['<Tab>'] = tree_cb('preview'),
	['I'] = tree_cb('toggle_ignored'),
	['H'] = tree_cb('toggle_dotfiles'),
	['R'] = tree_cb('refresh'),
	['a'] = tree_cb('create'),
	['<Del>'] = tree_cb('remove'),
	['r'] = tree_cb('rename'),
	['<C-r>'] = tree_cb('full_rename'),
	['dd'] = tree_cb('cut'),
	['yy'] = tree_cb('copy'),
	['p'] = tree_cb('paste'),
	['[c'] = tree_cb('prev_git_item'),
	[']c'] = tree_cb('next_git_item'),
	['u'] = tree_cb('dir_up'),
	['q'] = tree_cb('close'),
}