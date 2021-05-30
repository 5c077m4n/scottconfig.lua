local nvim_lsp = require'lspconfig'
local lspinstall = require'lspinstall'
local lsp_sig = require'lsp_signature'
local saga = require'lspsaga'

saga.init_lsp_saga {
	code_action_keys = {
		quit = 'q',
		exec = '<CR>'
	},
	rename_action_keys = {
		quit = {'<C-c>', '<Esc>'},
		exec = '<CR>'
	},
	rename_prompt_prefix = '>',
}

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
		vimp.nnoremap({'silent'}, 'gh', require'lspsaga.provider'.lsp_finder)
		vimp.nnoremap({'silent'}, 'K', require'lspsaga.hover'.render_hover_doc)
		vimp.nnoremap({'silent'}, '<C-f>', function() 
			require'lspsaga.action'.smart_scroll_with_saga(1)
		end)
		vimp.nnoremap({'silent'}, '<C-b>', function() 
			require'lspsaga.action'.smart_scroll_with_saga(-1)
		end)
		vimp.nnoremap({'silent'}, 'gi', lsp.buf.implementation)
		vimp.nnoremap({'silent'}, '<leader>gD', lsp.buf.type_definition)
		vimp.nnoremap({'silent'}, '<leader>rn', require'lspsaga.rename'.rename)
		vimp.nnoremap({'silent'}, 'gr', lsp.buf.references)
		vimp.nnoremap({'silent'}, 'g[', lsp.diagnostic.goto_prev)
		vimp.nnoremap({'silent'}, 'g]', lsp.diagnostic.goto_next)
		vimp.nnoremap({'silent'}, '<leader>l', lsp.buf.formatting)
		vimp.nnoremap({'silent'}, '<leader>ca', require'lspsaga.codeaction'.code_action)
		vimp.vnoremap({'silent'}, '<leader>ca', require'lspsaga.codeaction'.range_code_action)
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
