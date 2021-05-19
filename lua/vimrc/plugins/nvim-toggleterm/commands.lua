local Terminal  = require('toggleterm.terminal').Terminal

local terminals = {
	lazygit = Terminal:new {
		cmd = 'lazygit', 
		hidden = true,
		direction = 'float',
		float_opts = {
		    height = 60,
			width = 200,
		},
	},
	term1 = Terminal:new { count = 1, direction = 'horizontal' },
	term2 = Terminal:new { count = 2, direction = 'horizontal' },
}

function _G._toggle_lazygit() terminals.lazygit:toggle() end
function _G._toggle_term1() terminals.term1:toggle() end
function _G._toggle_term2() terminals.term2:toggle() end

vimp.nnoremap({'silent'}, '<F9>', _G._toggle_lazygit)
vimp.tnoremap({'silent'}, '<F9>', [[<C-\><C-n>:lua _G._toggle_lazygit()<CR>]])
vimp.nnoremap({'silent'}, '<F10>', _G._toggle_term1)
vimp.tnoremap({'silent'}, '<F10>', [[<C-\><C-n>:lua _G._toggle_term1()<CR>]])
vimp.nnoremap({'silent'}, '<F11>', _G._toggle_term2)
vimp.tnoremap({'silent'}, '<F11>', [[<C-\><C-n>:lua _G._toggle_term2()<CR>]])
