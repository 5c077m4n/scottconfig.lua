local nvim_lsp = require('lspconfig')
local lspinstall = require('lspinstall')
local lsp_sig = require('lsp_signature')
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
lsp_sig.setup({ bind = true, auto_close_after = 30, handler_opts = { border = 'single' } })

local function on_attach(client, bufnr)
	local lsp = vim.lsp
	local api = vim.api

	api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	lsp.handlers['textDocument/hover'] = lsp.with(lsp.handlers.hover, { border = 'single' })
	lsp.handlers['textDocument/signatureHelp'] = lsp.with(lsp.handlers.signature_help, { border = 'single' })

	vimp.add_buffer_maps(bufnr, function()
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
			lsp.diagnostic.goto_prev({ popup_opts = { border = 'single' } })
		end)
		vimp.nnoremap({ 'silent', 'override' }, 'g]', function()
			lsp.diagnostic.goto_next({ popup_opts = { border = 'single' } })
		end)
		vimp.nnoremap({ 'silent', 'override' }, '<leader>ca', lsp.buf.code_action)
		vimp.vnoremap({ 'silent', 'override' }, '<leader>ca', lsp.buf.range_code_action)
	end)

	lsp_status.on_attach(client, bufnr)

	which_key.register({
		['gD'] = 'Declaration',
		['gd'] = 'Definition',
		['gh'] = 'LSP Finder',
		['K'] = 'Show docs',
		['gi'] = 'Show implementations',
		['gr'] = 'Show refs',
		['<leader>rn'] = 'Param rename',
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
	lspinstall.setup()

	local servers = lspinstall.installed_servers()
	for _, server in pairs(servers) do
		local server_config = make_config()

		if server ~= 'rust' or server ~= 'rust_analyzer' then
			nvim_lsp[server].setup(server_config)
		end
	end

	if vim.opt.filetype:get() == 'lua' then
		local lua_config = make_config({
			cmd = { vim.env.HOME .. '/code/lua-language-server/bin/Linux/lua-language-server' },
			settings = {
				Lua = {
					telemetry = { enable = false },
				},
			},
		})
		local luadev_config = lua_dev.setup({ lspconfig = lua_config })
		nvim_lsp.sumneko_lua.setup(luadev_config)
	end

	if
		not (
			vim.fn.executable('prettier')
			and vim.fn.executable('eslint_d')
			and vim.fn.executable('diagnostic-languageserver')
		)
	then
		mod_utils.yarn_global_install({ 'prettier', 'eslint_d', 'diagnostic-languageserver' })
	end

	nvim_lsp.diagnosticls.setup({
		filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'scss', 'css', 'lua' },
		init_options = {
			filetypes = {
				javascript = 'eslint',
				typescript = 'eslint',
				javascriptreact = 'eslint',
				typescriptreact = 'eslint',
				lua = 'luacheck',
			},
			linters = {
				luacheck = {
					sourceName = 'luacheck',
					command = 'luacheck',
					rootPatterns = { '.luacheckrc1', '.stylua.toml' },
					debounce = 100,
					args = { '-' },
				},
				eslint = {
					sourceName = 'eslint',
					command = 'eslint_d',
					rootPatterns = {
						'.eslitrc.js',
						'.eslitrc.json',
						'package.json',
					},
					debounce = 100,
					args = {
						'--cache',
						'--stdin',
						'--stdin-filename',
						'%filepath',
						'--format',
						'json',
					},
					parseJson = {
						errorsRoot = '[0].messages',
						line = 'line',
						column = 'column',
						endLine = 'endLine',
						endColumn = 'endColumn',
						message = '${message} [${ruleId}]',
						security = 'severity',
					},
					securities = {
						[1] = 'warning',
						[2] = 'error',
					},
				},
			},
		},
	})
end

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
lspinstall.post_install_hook = function()
	setup_servers() -- reload installed servers
	vim.cmd([[bufdo e]])
end

setup_servers()
