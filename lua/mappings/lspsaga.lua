local code_actions = require'lspsaga.codeaction'
local hover = require'lspsaga.hover'
local action = require'lspsaga.action'
local signaturehelp = require'lspsaga.signaturehelp'
local rename = require'lspsaga.rename'
local provider = require'lspsaga.provider'
local diagnostic = require'lspsaga.diagnostic'
local floaterm = require'lspsaga.floaterm'

vimp.nnoremap('<leader>ca', function() code_actions.code_action() end)
vimp.vnoremap('<leader>ca', function() code_actions.range_code_action() end)
vimp.nnoremap('K', function() hover.render_hover_doc() end)
vimp.nnoremap('<C-f>', function() action.smart_scroll_with_saga(1) end)
vimp.nnoremap('<C-b>', function() action.smart_scroll_with_saga(-1) end)
vimp.nnoremap('gs', function() signaturehelp.signaturehelp_help() end)
vimp.nnoremap('<leader>rn', function() rename.rename() end)
vimp.nnoremap('gd', function() provider.preview_definition() end)
vimp.nnoremap('g]', function() diagnostic.lsp_jump_diagnostic_next() end)
vimp.nnoremap('g[', function() diagnostic.lsp_jump_diagnostic_prev() end)
vimp.nnoremap('<A-f>', function() floaterm.open_float_terminal() end)
vimp.tnoremap({'expr'}, '<A-f>', [[:lua require'lspsaga.floaterm'.close_float_terminal()<CR>]])
