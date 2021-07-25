local gitsigns = require 'gitsigns'

vimp.nnoremap('<leader>hr', gitsigns.reset_hunk)
vimp.nnoremap('<leader>hR', gitsigns.reset_buffer)
vimp.nnoremap('<leader>hp', gitsigns.preview_hunk)
vimp.nnoremap('<leader>hb', function()
	gitsigns.preview_hunk(true)
end)
