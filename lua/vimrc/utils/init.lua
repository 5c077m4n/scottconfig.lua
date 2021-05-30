local M = {}

function M.trim(s)
	return s:match'^%s*(.-)%s*$'
end

function M.run_in_modifiable_only(to_run)
	return function()
		if vim.bo.modifiable then
			if type(to_run) == 'function' then
				to_run()
			elseif type(to_run) == 'string' then
				vim.cmd(to_run)
			end
		else
			print('Please try again in a modifiable buffer')
		end
	end
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

function M.get_termcode(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.clean_extra_spaces()
	local save_cursor = vim.fn.getpos('.')
	local old_query = vim.fn.getreg('/')

	vim.cmd [[silent! %s/\s\+$//e]]
	vim.fn.setpos('.', save_cursor)
	vim.fn.setreg('/', old_query)
end

return M
