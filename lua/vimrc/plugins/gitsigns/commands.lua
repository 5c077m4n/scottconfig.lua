local gitsigns = require('gitsigns')
local gitsigns_actions = require('gitsigns.actions')

local keymap = require('vimrc.utils.keymapping')

keymap.nnoremap('<leader>hr', gitsigns.reset_hunk)
keymap.vnoremap('<leader>hr', function()
	gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
end)
keymap.nnoremap('<leader>hR', gitsigns.reset_buffer)
keymap.nnoremap('<leader>hp', gitsigns.preview_hunk)
keymap.nnoremap('<leader>h[', gitsigns_actions.prev_hunk)
keymap.nnoremap('<leader>h]', gitsigns_actions.next_hunk)
keymap.nnoremap('<leader>hb', function()
	gitsigns.blame_line({ full = true })
end)
