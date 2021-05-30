local nvim_lsp = require'lspconfig'
local lspinstall = require'lspinstall'
local lsp_sig = require'lsp_signature'
local telescope_builtin = require'telescope.builtin'
local saga = require'lspsaga'
local which_key = require'which-key'

saga.init_lsp_saga {
	code_action_keys = {
		exec = '<CR>',
		quit = {'q', '<Esc>'},
	},
	rename_action_keys = {
		exec = '<CR>',
		quit = {'<C-c>', '<Esc>'},
	},
	rename_prompt_prefix = '>',
	finder_action_keys = {
		open = '<CR>',
		vsplit = '<C-v>',
		split = '<C-h>',
		scroll_down = '<C-f>',
		scroll_up = '<C-b>',
		quit = {'q', '<Esc>'},
	},
	code_action_prompt = {
		enable = true,
		sign = false,
		sign_priority = 20,
		virtual_text = true,
	},
}

local function on_attach(_client, bufnr)
	local lsp = vim.lsp

	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	lsp_sig.on_attach {
		bind = true,
		handler_opts = {
			border = 'single',
		},
	}

	vimp.add_buffer_maps(bufnr, function()
		vimp.nnoremap({'silent'}, 'gD', lsp.buf.declaration)
		vimp.nnoremap({'silent'}, 'gd', telescope_builtin.lsp_definitions)
		vimp.nnoremap({'silent'}, 'gh', require'lspsaga.provider'.lsp_finder)
		vimp.nnoremap({'silent'}, 'K', require'lspsaga.hover'.render_hover_doc)
		vimp.nnoremap({'silent'}, '<C-f>', function()
			require'lspsaga.action'.smart_scroll_with_saga(1)
		end)
		vimp.nnoremap({'silent'}, '<C-b>', function()
			require'lspsaga.action'.smart_scroll_with_saga(-1)
		end)
		vimp.nnoremap({'silent'}, 'gi', telescope_builtin.lsp_implementations)
		vimp.nnoremap({'silent'}, '<leader>gD', lsp.buf.type_definition)
		vimp.nnoremap({'silent'}, '<leader>rn', require'lspsaga.rename'.rename)
		vimp.nnoremap({'silent'}, 'gr', telescope_builtin.lsp_references)
		vimp.nnoremap({'silent'}, 'g[', lsp.diagnostic.goto_prev)
		vimp.nnoremap({'silent'}, 'g]', lsp.diagnostic.goto_next)
		vimp.nnoremap({'silent'}, '<leader>l', lsp.buf.formatting)
		vimp.nnoremap({'silent'}, '<leader>ca', require'lspsaga.codeaction'.code_action)
		vimp.vnoremap({'silent'}, '<leader>ca', require'lspsaga.codeaction'.range_code_action)
	end)

	which_key.register({
		['gD'] = 'Declaration',
		['gd'] = 'Definition',
		['gh'] = 'LSP Finder',
		['K'] = 'Show docs',
		['gi'] = 'Show implementations',
		['gr'] = 'Show refs',
		['<leader>rn'] = 'Param rename',
		['<leader>l'] = 'Format',
	}, { buffer = bufnr, silent = true })
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
