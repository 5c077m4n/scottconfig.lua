local nvim_lsp = require'lspconfig'
local utils = require'utils'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

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

local function on_attach(client, bufnr)
	vimp.map_command('LspDef', vim.lsp.buf.definition)
	vimp.map_command('LspFormatting', vim.lsp.buf.formatting)
	vimp.map_command('LspCodeAction', vim.lsp.buf.code_action)
	vimp.map_command('LspHover', vim.lsp.buf.hover)
	vimp.map_command('LspRename', vim.lsp.buf.rename)
	vimp.map_command('LspOrganize', lsp_organize_imports)
	vimp.map_command('LspRefs', vim.lsp.buf.references)
	vimp.map_command('LspTypeDef', vim.lsp.buf.type_definition)
	vimp.map_command('LspImplementation', vim.lsp.buf.implementation)
	vimp.map_command('LspDiagPrev', vim.lsp.diagnostic.goto_prev)
	vimp.map_command('LspDiagNext', vim.lsp.diagnostic.goto_next)
	vimp.map_command('LspDiagLine', vim.lsp.diagnostic.show_line_diagnostics)
	vimp.map_command('LspSignatureHelp', vim.lsp.buf.signature_help)

	vimp.add_buffer_maps(bufnr, function()
		vimp.nnoremap({'silent'}, 'gd', ':LspDef<CR>')
		vimp.nnoremap({'silent'}, 'gr', ':LspRefs<CR>')
		vimp.nnoremap({'silent'}, 'gy', ':LspTypeDef<CR>')
		vimp.nnoremap({'silent'}, 'gs', ':LspOrganize<CR>')
		vimp.nnoremap({'silent'}, 'g[', ':LspDiagPrev<CR>')
		vimp.nnoremap({'silent'}, 'g]', ':LspDiagNext<CR>')
		vimp.nnoremap({'silent'}, 'K', ':LspHover<CR>')
		vimp.nnoremap({'silent'}, '<leader>rn', ':LspRename<CR>')
		vimp.nnoremap({'silent'}, '<leader>ca', ':LspCodeAction<CR>')
		vimp.nnoremap({'silent'}, '<leader>a', ':LspDiagLine<CR>')
		vimp.inoremap({'silent'}, '<C-x><C-x>', ':LspSignatureHelp<CR>')
	end)

	if client.resolved_capabilities.document_formatting then
		vim.api.nvim_exec([[
		augroup LspAutocommands
			autocmd! * <buffer>
			autocmd BufWritePost <buffer> LspFormatting
		augroup END
		]], true)
	end
end

nvim_lsp.tsserver.setup {
	on_attach = function(client)
		client.resolved_capabilities.document_formatting = false
		on_attach(client)
	end
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
			security = 'severity'
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
	on_attach = on_attach,
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
  on_attach=on_attach,
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
	on_attach=on_attach,
    filetypes = {'rust'},
    root_dir = nvim_lsp.util.root_pattern('Cargo.toml', 'rust-project.json'),
    settings = {
    	['rust-analyzer'] = {}
    }
}

nvim_lsp.html.setup {
	on_attach=on_attach,
	capabilities = capabilities,
}

nvim_lsp.cssls.setup {
	on_attach=on_attach,
	capabilities = capabilities,
}
