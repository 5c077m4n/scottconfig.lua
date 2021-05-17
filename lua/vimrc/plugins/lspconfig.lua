local lspinstall = require'lspinstall'
local nvim_lsp = require'lspconfig'

local function on_attach(_client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	vimp.add_buffer_maps(bufnr, function()
		vimp.nnoremap({'silent'}, 'gD', function() vim.lsp.buf.declaration() end)
		vimp.nnoremap({'silent'}, 'gd', function() vim.lsp.buf.definition() end)
		vimp.nnoremap({'silent'}, 'K', function() vim.lsp.buf.hover() end)
		vimp.nnoremap({'silent'}, 'gi', function() vim.lsp.buf.implementation() end)
		vimp.nnoremap({'silent'}, '<C-k>', function() vim.lsp.buf.signature_help() end)
		vimp.nnoremap({'silent'}, '<leader>gD', function() vim.lsp.buf.type_definition() end)
		vimp.nnoremap({'silent'}, '<leader>rn', function() vim.lsp.buf.rename() end)
		vimp.nnoremap({'silent'}, 'gr', function() vim.lsp.buf.references() end)
		vimp.nnoremap({'silent'}, '<leader>ca', function() vim.lsp.buf.code_action() end)
		vimp.nnoremap({'silent'}, 'g[', function() vim.lsp.diagnostic.goto_prev() end)
		vimp.nnoremap({'silent'}, 'g]', function() vim.lsp.diagnostic.goto_next() end)
	end)
end

local function setup_servers()
	lspinstall.setup()
	local servers = lspinstall.installed_servers()
	for _, server in pairs(servers) do
		nvim_lsp[server].setup { on_attach }
	end
end

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
lspinstall.post_install_hook = function ()
	setup_servers() -- reload installed servers
	vim.cmd [[bufdo e]] -- this triggers the FileType autocmd that starts the server
end

setup_servers()
