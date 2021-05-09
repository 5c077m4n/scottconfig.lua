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

require'mappings.nvim-tree'
