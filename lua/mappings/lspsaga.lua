local code_actions = require'lspsaga.codeaction'
local hover = require'lspsaga.hover'
local action = require'lspsaga.action'
local signaturehelp = require'lspsaga.signaturehelp'
local rename = require'lspsaga.rename'
local provider = require'lspsaga.provider'
local diagnostic = require'lspsaga.diagnostic'
local floaterm = require'lspsaga.floaterm'

vimp.nnoremap('<leader>ca', code_actions.code_action)
vimp.vnoremap('<leader>ca', code_actions.range_code_action)
vimp.nnoremap('K', hover.render_hover_doc)
vimp.nnoremap('<C-f>', function() action.smart_scroll_with_saga(1) end)
vimp.nnoremap('<C-b>', function() action.smart_scroll_with_saga(-1) end)
vimp.nnoremap('gs', signaturehelp.signaturehelp_help)
vimp.nnoremap('<leader>rn', rename.rename)
vimp.nnoremap('gd', provider.preview_definition)
vimp.nnoremap('g]', diagnostic.lsp_jump_diagnostic_next)
vimp.nnoremap('g[', diagnostic.lsp_jump_diagnostic_prev)
vimp.nnoremap('<A-f>', floaterm.open_float_terminal)
vimp.tnoremap({'expr'}, '<A-f>', [[:lua require'lspsaga.floaterm'.close_float_terminal()<CR>]])
