local lsp_installer = require('nvim-lsp-installer')
local telescope_builtin = require('telescope.builtin')
local lsp_status = require('lsp-status')
local which_key = require('which-key')

local mod_utils = require('vimrc.utils.modules')
local keymap = require('vimrc.utils.keymapping')

lsp_status.register_progress()
lsp_status.config({
	status_symbol = '',
	indicator_errors = 'E',
	indicator_warnings = 'W',
	indicator_info = 'i',
	indicator_hint = '?',
	indicator_ok = '✓',
})

lsp_installer.settings({
	ui = {
		icons = {
			server_installed = '✓',
			server_pending = '➜',
			server_uninstalled = '✗',
		},
	},
})

local function on_attach(client, bufnr)
	local lsp = vim.lsp
	local diagnostic = vim.diagnostic
	local create_command = vim.api.nvim_create_user_command

	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	lsp.handlers['textDocument/hover'] = lsp.with(lsp.handlers.hover, { border = 'single' })
	lsp.handlers['textDocument/signatureHelp'] = lsp.with(lsp.handlers.signature_help, { border = 'single' })

	keymap.nnoremap('gd', telescope_builtin.lsp_definitions, { buffer = bufnr, desc = 'Go to LSP definition' })
	keymap.nnoremap(
		'gD',
		telescope_builtin.lsp_dynamic_workspace_symbols,
		{ buffer = bufnr, desc = 'Go to declaration' }
	)
	keymap.nnoremap('gs', telescope_builtin.lsp_document_symbols, { buffer = bufnr, desc = 'Get document symbols' })
	keymap.nnoremap('gS', telescope_builtin.lsp_workspace_symbols, { buffer = bufnr, desc = 'Get workspace symbols' })
	keymap.nnoremap('K', lsp.buf.hover, { buffer = bufnr, desc = 'Show docs in hover' })
	keymap.nnoremap('<C-s>', lsp.buf.signature_help, { buffer = bufnr, desc = 'Show function signature' })
	keymap.nnoremap('gi', telescope_builtin.lsp_implementations, { buffer = bufnr, desc = 'Go to implementation' })
	keymap.nnoremap('<leader>gD', lsp.buf.type_definition, { buffer = bufnr, desc = 'Go to type definition' })
	keymap.nnoremap('<leader>rn', lsp.buf.rename, { buffer = bufnr, desc = 'LSP rename' })
	keymap.nnoremap('gr', telescope_builtin.lsp_references, { buffer = bufnr, desc = 'Find references' })
	keymap.nnoremap('g[', function()
		diagnostic.goto_prev({ popup_opts = { border = 'single' } })
	end, { buffer = bufnr, desc = 'Go to previous diagnostic' })
	keymap.nnoremap('g]', function()
		diagnostic.goto_next({ popup_opts = { border = 'single' } })
	end, { buffer = bufnr, desc = 'Go to next diagnostic' })
	keymap.nnoremap('<leader>ca', lsp.buf.code_action, { buffer = bufnr, desc = 'Code action' })
	keymap.vnoremap('<leader>ca', lsp.buf.range_code_action, { buffer = bufnr, desc = 'Code action for range' })
	keymap.nnoremap('<leader>l', lsp.buf.formatting, { buffer = bufnr, desc = 'Format page' })
	keymap.vnoremap('<leader>l', lsp.buf.range_formatting, { buffer = bufnr, desc = 'Format range' })

	create_command('Format', lsp.buf.formatting, { desc = 'Format page' })
	create_command('FormatRange', lsp.buf.range_formatting, { desc = 'Format range' })

	lsp_status.on_attach(client)

	which_key.register({
		gD = 'Declaration',
		gd = 'Definition',
		gh = 'LSP Finder',
		K = 'Show docs',
		gi = 'Show implementations',
		gr = 'Show refs',
		['g]'] = 'Next diagnostics result',
		['g['] = 'Previous diagnostics result',
		['g?'] = 'Show diagnostics result in popup',
		['<leader>rn'] = 'Rename',
		['<leader>l'] = 'Format',
	}, {
		buffer = bufnr,
		silent = true,
	})
end

local function make_config(options)
	local base_config = {
		on_attach = on_attach,
		capabilities = lsp_status.capabilities,
		flags = { debounce_text_changes = 100 },
	}
	if type(options) == 'table' then
		for key, value in pairs(options) do
			base_config[key] = value
		end
	end
	return base_config
end

local function setup_servers()
	lsp_installer.on_server_ready(function(server)
		local opts
		if server.name == 'lua' or server.name == 'sumneko_lua' then
			opts = require('lua-dev').setup({
				lspconfig = {
					on_attach = on_attach,
					settings = {
						Lua = {
							telemetry = { enable = false },
						},
					},
				},
			})
		else
			opts = make_config()
		end

		-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
		---@diagnostic disable-next-line: undefined-field
		server:setup(opts)
		vim.cmd([[do User LspAttachBuffers]])
	end)

	if
		not (
			vim.fn.executable('prettier')
			and vim.fn.executable('eslint_d')
			and vim.fn.executable('diagnostic-languageserver')
		)
	then
		mod_utils.yarn_global_install({ 'prettier', 'eslint_d', 'diagnostic-languageserver' })
	end
end

setup_servers()