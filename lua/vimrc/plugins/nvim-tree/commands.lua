local vimp = require('vimp')

vimp.nnoremap({ 'silent' }, '<leader>tt', ':NvimTreeToggle<CR>')
vimp.nnoremap({ 'silent' }, '<leader>tr', ':NvimTreeRefresh<CR>')
vimp.nnoremap({ 'silent' }, '<leader>ts', ':NvimTreeFindFile<CR>')
