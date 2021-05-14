local cmd = vim.api.nvim_command
local nmap = vimp.nmap
local xmap = vimp.xmap
local nnoremap = vimp.nnoremap
local map_command = vimp.map_command

nmap({'buffer', 'silent'}, 'g[', '<Plug>(coc-diagnostic-prev)')
nmap({'buffer', 'silent'}, 'g]', '<Plug>(coc-diagnostic-next)')
nmap({'buffer', 'silent'}, 'gd', '<Plug>(coc-definition)')
nmap({'buffer', 'silent'}, 'gt', '<Plug>(coc-type-definition)')
nmap({'buffer', 'silent'}, 'gi', '<Plug>(coc-implementation)')
nmap({'buffer', 'silent'}, 'gr', '<Plug>(coc-references)')
nmap({'buffer'}, '<leader>ac', '<Plug>(coc-codeaction)')
nmap({'buffer'}, '<leader>qf', '<Plug>(coc-fix-current)')
nmap({'buffer'}, '<leader>rn', '<Plug>(coc-rename)')
xmap({'buffer'}, '<leader>qr', '<Plug>(coc-format-selected)')
nmap({'buffer'}, '<leader>qr', '<Plug>(coc-format-selected)')

nnoremap({'buffer', 'silent'}, '<leader>ca', ':CocList diagnostics<CR>')
nnoremap({'buffer', 'silent'}, '<leader>cc', ':CocList commands<CR>')
nnoremap({'buffer', 'silent'}, '<leader>cr', ':CocRestart<CR>')

-- Format current buffer.
map_command('Format', function() cmd [[:call CocAction('format')]] end)
-- Fold current buffer.
map_command('', function() cmd [[call CocAction('fold', <f-args>)]] end)
-- Organize imports of the current buffer.
map_command('OrgImp', function() cmd [[:call CocAction('runCommand', 'editor.action.organizeImport')]] end)

--- Jest
-- Run jest for current project
map_command('Jest', function() cmd [[:call CocAction('runCommand', 'jest.projectTest')]] end)
-- Run jest for current file
map_command('JestFile', function() cmd [[:call CocAction('runCommand', 'jest.fileTest', ['%'])]] end)
-- Run jest for current test
map_command('JestTest', function() cmd [[:call CocAction('runCommand', 'jest.singleTest')]] end)
-- Init jest in current cwd, require global jest command exists
map_command('JestInit', function() cmd [[:call CocAction('runCommand', 'jest.init')]] end)
