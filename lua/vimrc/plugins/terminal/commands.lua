local Terminal  = require('FTerm.terminal')

local lazygit = Terminal:new():setup {
	cmd = 'lazygit',
	dimensions  = {
        height = 0.9,
        width = 0.9,
	},
}
local term1 = Terminal:new():setup {}
local term2 = Terminal:new():setup {}
local term3 = Terminal:new():setup {}

function _G._toggle_lazygit() lazygit:toggle() end
function _G._toggle_term1() term1:toggle() end
function _G._toggle_term2() term2:toggle() end
function _G._toggle_term3() term3:toggle() end

vimp.nnoremap({'silent'}, '<F9>', _G._toggle_lazygit)
vimp.tnoremap({'silent'}, '<F9>', [[<C-\><C-n>:lua _G._toggle_lazygit()<CR>]])
vimp.nnoremap({'silent'}, '<F10>', _G._toggle_term1)
vimp.tnoremap({'silent'}, '<F10>', [[<C-\><C-n>:lua _G._toggle_term1()<CR>]])
vimp.nnoremap({'silent'}, '<F11>', _G._toggle_term2)
vimp.tnoremap({'silent'}, '<F11>', [[<C-\><C-n>:lua _G._toggle_term2()<CR>]])
vimp.nnoremap({'silent'}, '<F12>', _G._toggle_term3)
vimp.tnoremap({'silent'}, '<F12>', [[<C-\><C-n>:lua _G._toggle_term3()<CR>]])
