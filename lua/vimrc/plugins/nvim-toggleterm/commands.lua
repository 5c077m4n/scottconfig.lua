local Terminal  = require('toggleterm.terminal').Terminal

local lazygit = Terminal:new { cmd = 'lazygit', hidden = true, direction = 'float' }
local term1 = Terminal:new { count = 1, direction = 'horizontal' }
local term2 = Terminal:new { count = 2, direction = 'horizontal' }

vimp.nnoremap({'silent'}, '<F9>', function() lazygit:toggle() end)
vimp.tnoremap({'silent', 'expr'}, '<F9>', [[lua lazygit:toggle()]])
vimp.nnoremap({'silent'}, '<F10>', function() term1:toggle() end)
vimp.tnoremap({'silent', 'expr'}, '<F10>', [[lua term1:toggle()]])
vimp.nnoremap({'silent'}, '<F11>', function() term2:toggle() end)
vimp.tnoremap({'silent', 'expr'}, '<F11>', [[lua term2:toggle()]])
