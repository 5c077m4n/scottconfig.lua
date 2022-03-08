local vimp = require('vimp')

vimp.nnoremap('<leader>1', [[:edit ~/.config/nvim/init.lua<CR>]])
vimp.nnoremap('<leader>2', require('vimrc.utils.modules').reload_vimrc)
vimp.nnoremap('<leader>3', require('vimrc.utils.modules').update_vimrc)
vimp.nnoremap('<leader>4', require('packer').sync)

-- Splits
vimp.nnoremap({ 'override' }, '<C-h>', '<C-w>h')
vimp.nnoremap({ 'override' }, '<C-j>', '<C-w>j')
vimp.nnoremap({ 'override' }, '<C-k>', '<C-w>k')
vimp.nnoremap({ 'override' }, '<C-l>', '<C-w>l')
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
-- Ctrl+y copys to clipboard
vimp.vnoremap('<C-y>', [["+y]])
-- Y copies to line end
vimp.nnoremap({ 'silent', 'override' }, 'Y', 'y$')
-- V selects to line end
vimp.nnoremap('V', 'v$')
-- Join line does not go one down
vimp.nnoremap('J', [[mzJ`z]])

-- Jump to line start/end
vimp.nnoremap('[[', '^')
vimp.vnoremap('[[', '^')
vimp.nnoremap(']]', '$')
vimp.vnoremap(']]', '$')

-- Move selection up/down
vimp.vnoremap('<A-k>', [[:m '>-2<CR>gv=gv]])
vimp.vnoremap('<A-j>', [[:m '>+1<CR>gv=gv]])
vimp.nnoremap('<A-k>', [[:m .-2<CR>==]])
vimp.nnoremap('<A-j>', [[:m .+1<CR>==]])

-- Unsets the last search pattern register by hitting return
vimp.nnoremap({ 'silent' }, '<CR>', ':nohlsearch<CR><CR>')

-- Word traversing
vimp.inoremap('<C-b>', function()
	vim.cmd([[normal! b]])
end)
vimp.inoremap('<C-e>', function()
	vim.cmd([[normal! e]])
end)
vimp.inoremap({ 'override' }, '<C-w>', function()
	vim.cmd([[normal! w]])
end)
vimp.inoremap('<C-h>', function()
	vim.cmd([[normal! h]])
end)
vimp.inoremap('<C-j>', function()
	vim.cmd([[normal! j]])
end)
vimp.inoremap('<C-k>', function()
	vim.cmd([[normal! k]])
end)
vimp.inoremap('<C-l>', function()
	vim.cmd([[normal! l]])
end)

-- Select currect word
vimp.nnoremap('<leader>V', 'viw')
-- Yank currect word
vimp.nnoremap('<leader>Y', 'viwy')
-- Switch currect word
vimp.nnoremap('<leader>S', 'viws')
-- Delete current word
vimp.nnoremap('<leader>D', 'daw')
-- Uppercase current word
vimp.nnoremap('<leader>U', 'viwU')

-- Switch CWD to the directory of the open buffer
vimp.nnoremap('<leader>cd', [[:cd %:p:h<CR>:pwd<CR>]])

-- Undo
vimp.nnoremap('U', '<C-r>')

vimp.map_command('CopyCursorLocation', function()
	local cursor_location = vim.fn.expand('%') .. ':' .. vim.fn.line('.') .. ':' .. vim.fn.col('.')

	if vim.fn.has('clipboard') then
		vim.fn.setreg('+', cursor_location)
	else
		vim.fn.setreg('1', cursor_location)
	end
	vim.notify(cursor_location, vim.lsp.log_levels.TRACE)
end)
