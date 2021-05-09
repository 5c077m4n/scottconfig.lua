local M = {}

function M.trim(s)
	return s:match '^%s*(.-)%s*$'
end

function M.system_name()
	if vim.fn.has('mac') == 1 then
		return 'macOS'
	elseif vim.fn.has('unix') == 1 then
		return 'Linux'
	elseif vim.fn.has('win32') == 1 then
		return 'Windows'
	end
end

function M.unload_lua_namespace(prefix)
	local prefix_with_dot = prefix .. '.'

	for key, value in pairs(package.loaded) do
		if key == prefix or key:sub(1, #prefix_with_dot) == prefix_with_dot then
			package.loaded[key] = nil
		end
	end
end

function M.check_back_space()
	local col = vim.fn.col('.') - 1
	if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
		return true
	else
		return false
	end
end

return M
