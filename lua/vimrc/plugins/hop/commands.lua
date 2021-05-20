local hop = require'hop'

vimp.nnoremap('hw', hop.hint_words)

require'which-key'.register {
	h = {
		name = 'hop',
		w = '+word',
	},
}
