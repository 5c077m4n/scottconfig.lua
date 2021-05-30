local nvim_lsp = require'lspconfig'
local lspinstall = require'lspinstall'
local lsp_sig = require'lsp_signature'

local function on_attach(_client, bufnr)
	local lsp = vim.lsp

	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	lsp_sig.on_attach {
		bind = true,
		handler_opts = {
			border = "single",
		},
	}

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
		vimp.nnoremap({'silent'}, '<leader>l', lsp.buf.formatting)
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

require'lspkind'.init() -- Icons on popup
setup_servers()
