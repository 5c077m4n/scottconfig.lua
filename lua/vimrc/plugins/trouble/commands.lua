local vimp = require('vimp')

vimp.nnoremap('<leader>xx', '<Cmd>TroubleToggle<CR>')
vimp.nnoremap('<leader>xw', '<Cmd>TroubleToggle lsp_workspace_diagnostics<CR>')
vimp.nnoremap('<leader>xd', '<Cmd>TroubleToggle lsp_document_diagnostics<CR>')
vimp.nnoremap('<leader>xq', '<Cmd>TroubleToggle quickfix<CR>')
vimp.nnoremap('<leader>xl', '<Cmd>TroubleToggle loclist<CR>')
