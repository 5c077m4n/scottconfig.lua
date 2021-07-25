require 'vimp'

vimp.nnoremap('<leader>1', [[:edit ~/.config/nvim/init.lua<CR>]])
vimp.nnoremap('<leader>2', require('vimrc.utils.modules').reload_vimrc)
vimp.nnoremap('<leader>3', require('vimrc.utils.modules').update_vimrc)
vimp.nnoremap('<leader>4', require('packer').sync)

-- Splits
vimp.nnoremap('<C-h>', '<C-w>h')
vimp.nnoremap('<C-j>', '<C-w>j')
vimp.nnoremap('<C-k>', '<C-w>k')
vimp.nnoremap('<C-l>', '<C-w>l')
vimp.nnoremap({ 'silent' }, '<leader>wq', '<C-w>q')
vimp.nnoremap({ 'silent' }, '<leader>wv', ':vertical split<CR>')
vimp.nnoremap({ 'silent' }, '<leader>wh', ':split<CR>')
vimp.nnoremap({ 'silent' }, '<leader>wt', ':vs#<CR>')

-- Tabs
vimp.nnoremap({ 'silent' }, '<leader>tn', ':tab split<CR>')
vimp.nnoremap({ 'silent' }, '<leader>tq', ':tabclose<CR>')
vimp.nnoremap({ 'silent' }, '<leader>tQ', ':tabonly<CR>')
vimp.nnoremap({ 'silent' }, '<leader>t]', ':tabn<CR>')
vimp.nnoremap({ 'silent' }, '<leader>t[', ':tabp<CR>')
vimp.nnoremap({ 'silent' }, '<leader>tl', ':tabs<CR>')
vimp.tnoremap('<C-]>', [[<C-\><C-n>]])

-- Ctrl+a selects all file content
vimp.nnoremap('<C-a>', 'gg0vG$')
-- Ctrl+c copys to clipboard
vimp.vnoremap('<C-c>', [["+y]])
-- Join line does not go one down
vimp.nnoremap('J', [[mzJ`z]])
-- Remap VIM 0 to first non-blank character
vimp.nnoremap('0', '^')
vimp.vnoremap('0', '^')

-- Unsets the last search pattern register by hitting return
vimp.nnoremap({ 'silent' }, '<CR>', ':nohlsearch<CR><CR>')

-- Word traversing
vimp.inoremap('<C-b>', function()
	vim.cmd [[normal! b]]
end)
vimp.inoremap('<C-e>', function()
	vim.cmd [[normal! e]]
end)
vimp.inoremap('<C-w>', function()
	vim.cmd [[normal! w]]
end)
vimp.inoremap('<C-h>', function()
	vim.cmd [[normal! h]]
end)
vimp.inoremap('<C-j>', function()
	vim.cmd [[normal! j]]
end)
vimp.inoremap('<C-k>', function()
	vim.cmd [[normal! k]]
end)
vimp.inoremap('<C-l>', function()
	vim.cmd [[normal! l]]
end)

-- Switch CWD to the directory of the open buffer
vimp.nnoremap('<leader>cd', [[:cd %:p:h<CR>:pwd<CR>]])

vimp.nnoremap('U', '<C-r>')
