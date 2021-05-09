vimp.nnoremap('<leader>1', [[:edit ~/.config/nvim/init.vim<CR>]])
vimp.nnoremap('<leader>2', [[:source ~/.config/nvim/init.vim<CR>]])

vimp.nnoremap('<C-h>', '<C-w>h')
vimp.nnoremap('<C-j>', '<C-w>j')
vimp.nnoremap('<C-k>', '<C-w>k')
vimp.nnoremap('<C-l>', '<C-w>l')
vimp.nnoremap({'silent'}, '<leader>wq', '<C-w>q')
vimp.nnoremap({'silent'}, '<leader>wv', ':vertical split')
vimp.nnoremap({'silent'}, '<leader>wh', ':split')
vimp.nnoremap({'silent'}, '<leader>wt', ':vs#')

vimp.nnoremap({'silent'}, '<leader>tn', ':tab split')
vimp.nnoremap({'silent'}, '<leader>tq', ':tabclose')
vimp.nnoremap({'silent'}, '<leader>tQ', ':tabonly')
vimp.nnoremap({'silent'}, '<leader>]', ':tabn')
vimp.nnoremap({'silent'}, '<leader>[', ':tabp')
vimp.nnoremap({'silent'}, '<leader>tl', ':tabs')

vimp.vnoremap('<C-c>', '"+y')

vimp.nnoremap('J', 'mzJ`z')
