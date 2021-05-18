local Terminal  = require('toggleterm.terminal').Terminal

local lazygit = Terminal:new { cmd = 'lazygit', hidden = true, direction = 'float' }
local term1 = Terminal:new { count = 1, direction = 'horizontal' }
local term2 = Terminal:new { count = 2, direction = 'horizontal' }
-- local term3 = Terminal:new { count = 3, direction = 'horizontal' }

vimp.nnoremap({'silent'}, '<F9>', function() lazygit:toggle() end)
vimp.tnoremap({'silent', 'expr'}, [[<C-\><C-n><F9>]], [[lua function() lazygit:toggle() end]])
vimp.nnoremap({'silent'}, '<F10>', function() term1:toggle() end)
vimp.tnoremap({'silent', 'expr'}, [[<C-\><C-n><F10>]], [[lua function() term1:toggle() end]])
vimp.nnoremap({'silent'}, '<F11>', function() term2:toggle() end)
vimp.tnoremap({'silent', 'expr'}, [[<C-\><C-n><F11>]], [[lua function() term2:toggle() end]])
-- vimp.nnoremap({'silent'}, '<F12>', function() term3:toggle() end)
-- vimp.tnoremap({'silent', 'expr'}, [[<C-\><C-n><F12>]], [[lua function() term3:toggle() end]])
