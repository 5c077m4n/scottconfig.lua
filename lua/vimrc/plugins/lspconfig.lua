local vimp = require('vimp')
local lsp_installer = require('nvim-lsp-installer')
local lua_dev = require('lua-dev')
local telescope_builtin = require('telescope.builtin')
local lsp_status = require('lsp-status')
local which_key = require('which-key')

local mod_utils = require('vimrc.utils.modules')

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
	local api = vim.api

	api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	lsp.handlers['textDocument/hover'] = lsp.with(lsp.handlers.hover, { border = 'single' })
	lsp.handlers['textDocument/signatureHelp'] = lsp.with(lsp.handlers.signature_help, { border = 'single' })

	vimp.add_buffer_maps(bufnr, function()
		local diagnostic = lsp.diagnostic

		vimp.nnoremap({ 'silent', 'override' }, 'gd', telescope_builtin.lsp_definitions)
		vimp.nnoremap({ 'silent', 'override' }, 'gD', telescope_builtin.lsp_dynamic_workspace_symbols)
		vimp.nnoremap({ 'silent', 'override' }, 'gs', telescope_builtin.lsp_document_symbols)
		vimp.nnoremap({ 'silent', 'override' }, 'gS', telescope_builtin.lsp_workspace_symbols)
		vimp.nnoremap({ 'silent', 'override' }, 'K', lsp.buf.hover)
		vimp.nnoremap({ 'silent', 'override' }, '<C-x>', lsp.buf.signature_help)
		vimp.nnoremap({ 'silent', 'override' }, 'gi', telescope_builtin.lsp_implementations)
		vimp.nnoremap({ 'silent', 'override' }, '<leader>gD', lsp.buf.type_definition)
		vimp.nnoremap({ 'silent', 'override' }, '<leader>rn', lsp.buf.rename)
		vimp.nnoremap({ 'silent', 'override' }, 'gr', telescope_builtin.lsp_references)
		vimp.nnoremap({ 'silent', 'override' }, 'g[', function()
			diagnostic.goto_prev({ popup_opts = { border = 'single' } })
		end)
		vimp.nnoremap({ 'silent', 'override' }, 'g]', function()
			diagnostic.goto_next({ popup_opts = { border = 'single' } })
		end)
		vimp.nnoremap({ 'silent', 'override' }, 'g?', diagnostic.show_line_diagnostics)
		vimp.nnoremap({ 'silent', 'override' }, '<leader>ca', lsp.buf.code_action)
		vimp.vnoremap({ 'silent', 'override' }, '<leader>ca', lsp.buf.range_code_action)
		vimp.nnoremap({ 'silent', 'override' }, '<leader>l', lsp.buf.formatting)
		vimp.vnoremap({ 'silent', 'override' }, '<leader>l', lsp.buf.range_formatting)
	end)

	lsp_status.on_attach(client, bufnr)

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
			opts = lua_dev.setup({
				lspconfig = {
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
