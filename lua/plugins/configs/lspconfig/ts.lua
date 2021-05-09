local nvim_lsp = require'lspconfig'

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
	vimp.map_command('LspDef', function() vim.lsp.buf.definition() end)
	vimp.map_command('LspFormatting', function() vim.lsp.buf.formatting() end)
	vimp.map_command('LspCodeAction', function() vim.lsp.buf.code_action() end)
	vimp.map_command('LspHover', function() vim.lsp.buf.hover() end)
	vimp.map_command('LspRename', function() vim.lsp.buf.rename() end)
	vimp.map_command('LspOrganize', function() lsp_organize_imports() end)
	vimp.map_command('LspRefs', function() vim.lsp.buf.references() end)
	vimp.map_command('LspTypeDef', function() vim.lsp.buf.type_definition() end)
	vimp.map_command('LspImplementation', function() vim.lsp.buf.implementation() end)
	vimp.map_command('LspDiagPrev', function() vim.lsp.diagnostic.goto_prev() end)
	vimp.map_command('LspDiagNext', function() vim.lsp.diagnostic.goto_next() end)
	vimp.map_command('LspDiagLine', function() vim.lsp.diagnostic.show_line_diagnostics() end)
	vimp.map_command('LspSignatureHelp', function() vim.lsp.buf.signature_help() end)

	vimp.add_buffer_maps(bufnr, function()
		vimp.nnoremap({'silent'}, 'gd', ':LspDef<CR>')
		vimp.nnoremap({'silent'}, 'gr', ':LspRename<CR>')
		vimp.nnoremap({'silent'}, 'gR', ':LspRefs<CR>')
		vimp.nnoremap({'silent'}, 'gy', ':LspTypeDef<CR>')
		vimp.nnoremap({'silent'}, 'K', ':LspHover<CR>')
		vimp.nnoremap({'silent'}, 'gs', ':LspOrganize<CR>')
		vimp.nnoremap({'silent'}, '[a', ':LspDiagPrev<CR>')
		vimp.nnoremap({'silent'}, ']a', ':LspDiagNext<CR>')
		vimp.nnoremap({'silent'}, 'ga', ':LspCodeAction<CR>')
		vimp.nnoremap({'silent'}, '<Leader>a', ':LspDiagLine<CR>')
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
