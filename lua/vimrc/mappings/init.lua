vimp.nnoremap('<leader>1', [[:edit ~/.config/nvim/init.lua<CR>]])
vimp.nnoremap('<leader>2', function()
	vimp.unmap_all()
	require'vimrc.utils.modules'.unload_lua_namespace('vimrc')
	require'vimrc'
end)
vimp.nnoremap('<leader>3', [[:PackerInstall<CR>]])
vimp.nnoremap('<leader>4', [[:PackerSync<CR>]])

-- Splits
vimp.nnoremap('<C-h>', '<C-w>h')
vimp.nnoremap('<C-j>', '<C-w>j')
vimp.nnoremap('<C-k>', '<C-w>k')
vimp.nnoremap('<C-l>', '<C-w>l')
vimp.nnoremap({'silent'}, '<leader>wq', '<C-w>q')
vimp.nnoremap({'silent'}, '<leader>wv', ':vertical split<CR>')
vimp.nnoremap({'silent'}, '<leader>wh', ':split<CR>')
vimp.nnoremap({'silent'}, '<leader>wt', ':vs#<CR>')

-- Tabs
vimp.nnoremap({'silent'}, '<leader>tn', ':tab split<CR>')
vimp.nnoremap({'silent'}, '<leader>tq', ':tabclose<CR>')
vimp.nnoremap({'silent'}, '<leader>tQ', ':tabonly<CR>')
vimp.nnoremap({'silent'}, '<leader>t]', ':tabn<CR>')
vimp.nnoremap({'silent'}, '<leader>t[', ':tabp<CR>')
vimp.nnoremap({'silent'}, '<leader>tl', ':tabs<CR>')
vimp.tnoremap('<C-]>', [[<C-\><C-n>]])

-- Ctrl+c copys to clipboard
vimp.vnoremap('<C-c>', '"+y')
-- Join line does not go one down
vimp.nnoremap('J', 'mzJ`z')
-- Remap VIM 0 to first non-blank character
vimp.nnoremap('0', '^')
vimp.vnoremap('0', '^')

-- Unsets the last search pattern register by hitting return
vimp.nnoremap('<CR>', ':noh<CR>')

-- Word traversing
vimp.inoremap('<C-b>', '<C-o>b')
vimp.inoremap('<C-e>', '<C-o>e')
vimp.inoremap('<C-w>', '<C-o>w')
vimp.inoremap('<C-h>', '<C-o>h')
vimp.inoremap('<C-j>', '<C-o>j')
vimp.inoremap('<C-k>', '<C-o>k')
vimp.inoremap('<C-l>', '<C-o>l')

-- Switch CWD to the directory of the open buffer
vimp.nnoremap('<leader>cd', ':cd %:p:h<CR>:pwd<CR>')

vimp.nnoremap('U', '<C-r>')