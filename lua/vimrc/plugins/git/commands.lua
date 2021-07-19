local gitsigns = require 'gitsigns'

vimp.nnoremap('<leader>hr', gitsigns.reset_hunk)
vimp.nnoremap('<leader>hR', gitsigns.reset_buffer)
vimp.nnoremap('<leader>hp', gitsigns.preview_hunk)
vimp.nnoremap('<leader>hb', function()
	gitsigns.preview_hunk(true)
end)

-- Git mergetool
vimp.nnoremap('<leader>gs', [[:Gstatus<CR>]])
vimp.nnoremap('<leader>gm', [[:G mergetool<CR>]])
vimp.nnoremap('<leader>gdd', [[:Gvdiffsplit!<CR>]])
vimp.nnoremap('<leader>gdh', [[:diffget //2<CR>]])
vimp.nnoremap('<leader>gdl', [[:diffget //3<CR>]])
vimp.nnoremap('<leader>gdD', [[:diffoff<CR>]])
