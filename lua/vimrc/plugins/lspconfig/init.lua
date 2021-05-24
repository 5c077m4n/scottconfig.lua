local nvim_lsp = require'lspconfig'
local lspinstall = require'lspinstall'
local lsp_sig = require'lsp_signature'

local function on_attach(_client, bufnr)
	local lsp = vim.lsp

	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	lsp_sig.on_attach()

	-- lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
	-- lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
	-- lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
	-- lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
	-- lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
	-- lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
	-- lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
	-- lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler

	vimp.add_buffer_maps(bufnr, function()
		vimp.nnoremap({'silent'}, 'gD', lsp.buf.declaration)
		vimp.nnoremap({'silent'}, 'gd', lsp.buf.definition)
		vimp.nnoremap({'silent'}, 'K', lsp.buf.hover)
		vimp.nnoremap({'silent'}, 'gi', lsp.buf.implementation)
		vimp.nnoremap({'silent'}, '<leader>gD', lsp.buf.type_definition)
		vimp.nnoremap({'silent'}, '<leader>rn', lsp.buf.rename)
		vimp.nnoremap({'silent'}, 'gr', lsp.buf.references)
		vimp.nnoremap({'silent'}, '<leader>ca', lsp.buf.code_action)
		vimp.nnoremap({'silent'}, 'g[', lsp.diagnostic.goto_prev)
		vimp.nnoremap({'silent'}, 'g]', lsp.diagnostic.goto_next)
		vimp.nnoremap({'silent'}, '<C-f>', lsp.buf.formatting)
	end)
end

local function setup_servers()
	lspinstall.setup()
	local servers = lspinstall.installed_servers()

	for _, server in pairs(servers) do
		nvim_lsp[server].setup {on_attach = on_attach}
	end
end

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
lspinstall.post_install_hook = function()
	setup_servers() -- reload installed servers
	vim.cmd [[bufdo e]] -- this triggers the FileType autocmd that starts the server
end

require'lspkind'.init()
setup_servers()
