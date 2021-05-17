local lspinstall = require'lspinstall'
local nvim_lsp = require'lspconfig'

local function on_attach(_client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	vimp.add_buffer_maps(bufnr, function()
		local lsp = vim.lsp

		vimp.nnoremap({'silent'}, 'gD', lsp.buf.declaration)
		vimp.nnoremap({'silent'}, 'gd', lsp.buf.definition)
		vimp.nnoremap({'silent'}, 'K', lsp.buf.hover)
		vimp.nnoremap({'silent'}, 'gi', lsp.buf.implementation)
		vimp.nnoremap({'silent'}, '<C-k>', lsp.buf.signature_help)
		vimp.nnoremap({'silent'}, '<leader>gD', lsp.buf.type_definition)
		vimp.nnoremap({'silent'}, '<leader>rn', lsp.buf.rename)
		vimp.nnoremap({'silent'}, 'gr', lsp.buf.references)
		vimp.nnoremap({'silent'}, '<leader>ca', lsp.buf.code_action)
		vimp.nnoremap({'silent'}, 'g[', lsp.diagnostic.goto_prev)
		vimp.nnoremap({'silent'}, 'g]', lsp.diagnostic.goto_next)

		vimp.map_command('Format', lsp.buf.formatting)
	end)
end

local function setup_servers()
	lspinstall.setup()
	local servers = lspinstall.installed_servers()

	for _, server in pairs(servers) do
		nvim_lsp[server].setup { on_attach = on_attach }
	end
end

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
lspinstall.post_install_hook = function ()
	setup_servers() -- reload installed servers
	vim.cmd [[bufdo e]] -- this triggers the FileType autocmd that starts the server
end

setup_servers()
