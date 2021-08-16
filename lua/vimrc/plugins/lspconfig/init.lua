local nvim_lsp = require('lspconfig')
local lspinstall = require('lspinstall')
local lsp_sig = require('lsp_signature')
local lua_dev = require('lua-dev')
local telescope_builtin = require('telescope.builtin')
local saga = require('lspsaga')
local lsp_status = require('lsp-status')
local which_key = require('which-key')

local mod_utils = require('vimrc.utils.modules')

saga.init_lsp_saga({
	code_action_keys = { exec = '<CR>', quit = { 'q', '<Esc>' } },
	rename_action_keys = { exec = '<CR>', quit = { '<C-c>', '<Esc>' } },
	rename_prompt_prefix = '>',
	finder_action_keys = {
		open = '<CR>',
		vsplit = '<C-v>',
		split = '<C-h>',
		scroll_down = '<C-f>',
		scroll_up = '<C-b>',
		quit = { 'q', '<Esc>' },
	},
	code_action_prompt = {
		enable = true,
		sign = false,
		sign_priority = 20,
		virtual_text = true,
	},
})
lsp_status.register_progress()
lsp_status.config({
	status_symbol = '',
	indicator_errors = 'E',
	indicator_warnings = 'W',
	indicator_info = 'i',
	indicator_hint = '?',
	indicator_ok = '✓',
})

local function on_attach(client, bufnr)
	local lsp = vim.lsp

	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	lsp_sig.on_attach({ bind = true, handler_opts = { border = 'single' } })

	vimp.add_buffer_maps(bufnr, function()
		vimp.nnoremap({ 'silent', 'override' }, 'gd', telescope_builtin.lsp_definitions)
		vimp.nnoremap({ 'silent', 'override' }, 'gD', telescope_builtin.lsp_dynamic_workspace_symbols)
		vimp.nnoremap({ 'silent', 'override' }, 'gs', telescope_builtin.lsp_document_symbols)
		vimp.nnoremap({ 'silent', 'override' }, 'gS', telescope_builtin.lsp_workspace_symbols)
		vimp.nnoremap({ 'silent', 'override' }, 'gh', require('lspsaga.provider').lsp_finder)
		vimp.nnoremap({ 'silent', 'override' }, 'K', require('lspsaga.hover').render_hover_doc)
		vimp.nnoremap({ 'silent', 'override' }, '<C-f>', function()
			require('lspsaga.action').smart_scroll_with_saga(1)
		end)
		vimp.nnoremap({ 'silent', 'override' }, '<C-b>', function()
			require('lspsaga.action').smart_scroll_with_saga(-1)
		end)
		vimp.nnoremap({ 'silent', 'override' }, 'gi', telescope_builtin.lsp_implementations)
		vimp.nnoremap({ 'silent', 'override' }, '<leader>gD', lsp.buf.type_definition)
		vimp.nnoremap({ 'silent', 'override' }, '<leader>rn', require('lspsaga.rename').rename)
		vimp.nnoremap({ 'silent', 'override' }, 'gr', telescope_builtin.lsp_references)
		vimp.nnoremap({ 'silent', 'override' }, 'g[', lsp.diagnostic.goto_prev)
		vimp.nnoremap({ 'silent', 'override' }, 'g]', lsp.diagnostic.goto_next)
		vimp.nnoremap({ 'silent', 'override' }, '<leader>ca', require('lspsaga.codeaction').code_action)
		vimp.vnoremap({ 'silent', 'override' }, '<leader>ca', require('lspsaga.codeaction').range_code_action)
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

local function setup_servers()
	local config = {
		on_attach = on_attach,
		capabilities = lsp_status.capabilities,
		flags = { debounce_text_changes = 150 },
	}

	lspinstall.setup()

	local servers = lspinstall.installed_servers()
	for _, server in pairs(servers) do
		local server_config = { unpack(config) }

		if server == 'rust_analyzer' then
			server_config.cmd = { 'rust-analyzer' }
		end

		nvim_lsp[server].setup(server_config)
	end

	local lua_config = {
		unpack(config),
		cmd = { vim.env.HOME .. '/code/lua-language-server/bin/Linux/lua-language-server' },
		settings = {
			Lua = {
				telemetry = { enable = false },
			},
		},
	}
	local luadev_config = lua_dev.setup({ lspconfig = lua_config })
	nvim_lsp.sumneko_lua.setup(luadev_config)

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
		filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'scss', 'css' },
		init_options = {
			filetypes = {
				javascript = 'eslint',
				typescript = 'eslint',
				javascriptreact = 'eslint',
				typescriptreact = 'eslint',
			},
			linters = {
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
						[2] = 'error',
						[1] = 'warning',
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
