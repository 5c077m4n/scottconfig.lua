vimp.nnoremap('<leader>1', [[:edit ~/.config/nvim/init.lua<CR>]])
vimp.nnoremap('<leader>2', [[:luafile ~/.config/nvim/init.lua<CR>]])

vimp.nnoremap('<C-h>', '<C-w>h')
vimp.nnoremap('<C-j>', '<C-w>j')
vimp.nnoremap('<C-k>', '<C-w>k')
vimp.nnoremap('<C-l>', '<C-w>l')
vimp.nnoremap({'silent'}, '<leader>wq', '<C-w>q')
vimp.nnoremap({'silent'}, '<leader>wv', ':vertical split<CR>')
vimp.nnoremap({'silent'}, '<leader>wh', ':split<CR>')
vimp.nnoremap({'silent'}, '<leader>wt', ':vs#<CR>')

vimp.nnoremap({'silent'}, '<leader>tn', ':tab split<CR>')
vimp.nnoremap({'silent'}, '<leader>tq', ':tabclose<CR>')
vimp.nnoremap({'silent'}, '<leader>tQ', ':tabonly<CR>')
vimp.nnoremap({'silent'}, '<leader>]', ':tabn<CR>')
vimp.nnoremap({'silent'}, '<leader>[', ':tabp<CR>')
vimp.nnoremap({'silent'}, '<leader>tl', ':tabs<CR>')

vimp.vnoremap('<C-c>', '"+y')

vimp.nnoremap('J', 'mzJ`z')

-- Unsets the last search pattern register by hitting return
vimp.nnoremap('<CR>', ':noh<CR>')

-- Switch CWD to the directory of the open buffer
vimp.nnoremap('<leader>cd', ':cd %:p:h<CR>:pwd<CR>')

require'mappings.nvim-tree'
require'mappings.floaterm'
