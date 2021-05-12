local nvim_lsp = require'lspconfig'
local utils = require'utils'

local root_pattern = nvim_lsp.util.root_pattern

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		'documentation',
		'detail',
		'additionalTextEdits',
	}
}

local function format_async(err, _, result, _, bufnr)
	if err ~= nil or result == nil then return end
	if not vim.api.nvim_buf_get_option(bufnr, 'modified') then
		local view = vim.fn.winsaveview()

		vim.lsp.util.apply_text_edits(result, bufnr)
		vim.fn.winrestview(view)

		if bufnr == vim.api.nvim_get_current_buf() then
			vim.api.nvim_command('noautocmd :update')
		end
	end
end
vim.lsp.handlers['textDocument/formatting'] = format_async

function _G.lsp_organize_imports()
	local params = {
		command = '_typescript.organizeImports',
		arguments = {vim.api.nvim_buf_get_name(0)},
		title = ''
	}
	vim.lsp.buf.execute_command(params)
end

nvim_lsp.tsserver.setup {
	on_attach = function(client)
		client.resolved_capabilities.document_formatting = false

		if not vim.fn.executable('tsc') or not vim.fn.executable('typescript-language-server') then
			if vim.fn.executable('yarn') then
				local is_exec_success, _ = pcall(os.execute('yarn global add typescript typescript-language-server'))
				if not is_exec_success then
					print('The tsserver dependencies could not be installed')
				end
			elseif vim.fn.executable('npm') then
				local is_exec_success, _ = pcall(os.execute('npm install --global typescript typescript-language-server'))
				if not is_exec_success then
					print('The tsserver dependencies could not be installed')
				end
			else 
				error('The tsserver dependencies could not be installed')
			end
		end
	end,
	cmd = { 'typescript-language-server', '--stdio' },
	filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
	root_dir = root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git'),
}

local filetypes = {
	javascirpt = 'eslint',
	javascirptreact = 'eslint',
	typescript = 'eslint',
	typescriptreact = 'eslint',
}
local linters = {
	eslint = {
		sourceName = 'eslint',
		command = 'eslint_d',
		rootPatterns = {'.eslintrc.js', 'package.json'},
		debounce = 100,
		args = {'--stdin', '--stdin-filename', '%filepath', '--format', 'json'},
		parseJson = {
			errorsRoot = '[0].messages',
			line = 'line',
			column = 'column',
			endLine = 'endLine',
			endColumn = 'endColumn',
			message = '${message} [${ruleId}]',
			security = 'severity',
		},
		securities = {[2] = 'error', [1] = 'warning'}
	}
}
local formatters = {
	prettier = {command = 'prettier', args = {'--stdin-filepath', '%filepath'}}
}
local formatFiletypes = {
	javascript = 'prettier',
	javascriptreact = 'prettier',
	typescript = 'prettier',
	typescriptreact = 'prettier'
}

nvim_lsp.diagnosticls.setup {
	filetypes = vim.tbl_keys(filetypes),
	init_options = {
		filetypes = filetypes,
		linters = linters,
		formatters = formatters,
		formatFiletypes = formatFiletypes
	}
}

local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path..'/bin/'..utils.system_name()..'/lua-language-server'

nvim_lsp.sumneko_lua.setup {
	cmd = {sumneko_binary, '-E', sumneko_root_path .. '/main.lua'},
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
				path = vim.split(package.path, ';'),
			},
			diagnostics = {
				globals = {'vim'},
			},
			workspace = {
				library = {
					[vim.fn.expand('$VIMRUNTIME/lua')] = true,
					[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
				},
			},
			telemetry = {
				enable = false,
			},
		},
	},
}

nvim_lsp.rust_analyzer.setup {
	cmd = {'rust-analyzer'},
	filetypes = {'rust'},
	root_dir = root_pattern('Cargo.toml', 'rust-project.json'),
	settings = {
		['rust-analyzer'] = {}
	}
}

nvim_lsp.html.setup {
	capabilities = capabilities,
	on_attach = function()
		if not vim.fn.executable('vscode-html-languageserver-bin') then
			if vim.fn.executable('yarn') then
				local is_exec_success, _ = pcall(os.execute('yarn global add vscode-html-languageserver-bin'))
				if not is_exec_success then
					print('The HTML language server dependencies could not be installed')
				end
			elseif vim.fn.executable('npm') then
				local is_exec_success, _ = pcall(os.execute('npm install --global vscode-html-languageserver-bin'))
				if not is_exec_success then
					print('The HTML language server dependencies could not be installed')
				end
			else 
				error('The HTML language server dependencies could not be installed')
			end
		end
	end
}

nvim_lsp.cssls.setup {
	capabilities = capabilities,
	on_attach = function()
		if not vim.fn.executable('vscode-css-languageserver-bin') then
			if vim.fn.executable('yarn') then
				local is_exec_success, _ = pcall(os.execute('yarn global add vscode-css-languageserver-bin'))
				if not is_exec_success then
					print('The CSS language server dependencies could not be installed')
				end
			elseif vim.fn.executable('npm') then
				local is_exec_success, _ = pcall(os.execute('npm install --global vscode-css-languageserver-bin'))
				if not is_exec_success then
					print('The CSS language server dependencies could not be installed')
				end
			else 
				error('The CSS language server dependencies could not be installed')
			end
		end
	end
}

require'lspconfig'.vimls.setup {
	capabilities = capabilities,
	on_attach = function()
		if not vim.fn.executable('vim-language-server') then
			if vim.fn.executable('yarn') then
				local is_exec_success, _ = pcall(os.execute('yarn global add vim-language-server'))
				if not is_exec_success then
					print('The vimls dependencies could not be installed')
				end
			elseif vim.fn.executable('npm') then
				local is_exec_success, _ = pcall(os.execute('npm install --global vim-language-server'))
				if not is_exec_success then
					print('The vimls dependencies could not be installed')
				end
			else 
				error('The vimls dependencies could not be installed')
			end
		end
	end,
}
