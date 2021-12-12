local vimp = require('vimp')
local hop = require('hop')
local hop_hint = require('hop.hint')

vimp.nnoremap('f', function()
	hop.hint_char1({ direction = hop_hint.HintDirection.AFTER_CURSOR, current_line_only = true })
end)
vimp.nnoremap('F', hop.hint_words)
