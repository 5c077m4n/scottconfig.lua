local Terminal  = require('toggleterm.terminal').Terminal
local utils = require'vimrc.utils'

local terminals = {
	lazygit = Terminal:new { cmd = 'lazygit', hidden = true, direction = 'float' },
	term1 = Terminal:new { count = 1, direction = 'horizontal' },
	term2 = Terminal:new { count = 2, direction = 'horizontal' },
}

function _G.toggle_lazygit() terminals.lazygit:toggle() end
function _G.toggle_term1() terminals.term1:toggle() end
function _G.toggle_term2() terminals.term2:toggle() end

vimp.nnoremap({'silent'}, '<F9>', _G.toggle_lazygit)
vimp.tnoremap({'silent', 'expr'}, '<F9>', [[:lua _G.toggle_lazygit()<CR>]])
vimp.nnoremap({'silent'}, '<F10>', _G.toggle_term1)
vimp.tnoremap({'silent', 'expr'}, '<F10>', [[:lua _G.toggle_term1()<CR>]])
vimp.nnoremap({'silent'}, '<F11>', _G.toggle_term2)
vimp.tnoremap({'silent', 'expr'}, '<F11>', [[:lua _G.toggle_term2()<CR>]])
