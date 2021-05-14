local M = {}

function M.get_coc_extensions()
	local is_dir = vim.fn.isdirectory
	local is_exec = vim.fn.executable
	local filetype = vim.bo.filetype

	local node_mods = 'node_modules'
	local coc_ext = {'coc-lists'}

	if is_dir(node_mods) and is_dir(node_mods .. '/eslint') or is_exec('eslint') then
		table.insert(coc_ext, 'coc-eslint')
	end
	if is_dir(node_mods) and is_dir(node_mods .. '/prettier') or is_exec('prettier') then
		table.insert(coc_ext, 'coc-prettier')
	end

	if filetype == 'json' then
		table.insert(coc_ext, 'coc-json')
	elseif ({
		typescript = true,
		typescriptreact = true,
		javascript = true,
		javascriptreact = true,
	})[filetype] then
		table.insert(coc_ext, 'coc-tsserver')
		table.insert(coc_ext, 'coc-jest')
		table.insert(coc_ext, 'coc-react-refactor')
		table.insert(coc_ext, 'coc-sql')
	elseif filetype == 'html' then
		table.insert(coc_ext, 'coc-html')
		table.insert(coc_ext, 'coc-css')
	elseif ({
		css = true,
		scss = true,
		sass = true,
		less = true,
	})[filetype] then
		table.insert(coc_ext, 'coc-css')
	elseif ({
		yaml = true,
		yml = true,
	})[filetype] then
		table.insert(coc_ext, 'coc-yaml')
	elseif ({
		sh = true,
		shell = true,
	})[filetype] then
		table.insert(coc_ext, 'coc-sh')
	elseif filetype == 'sql' then
		table.insert(coc_ext, 'coc-sql')
	elseif filetype == 'rust' then
		table.insert(coc_ext, 'coc-rust-analyzer')
	elseif filetype == 'toml' then
		table.insert(coc_ext, 'coc-toml')
	elseif filetype == 'svg' then
		table.insert(coc_ext, 'coc-svg')
	elseif filetype == 'vim' then
		table.insert(coc_ext, 'coc-vim')
	elseif filetype == 'lua' then
		table.insert(coc_ext, 'coc-lua')
	end

	return coc_ext
end

return M
