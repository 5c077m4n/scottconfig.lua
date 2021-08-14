local M = {}

function M.trim(s)
	return s:match('^%s*(.-)%s*$')
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

	vim.cmd([[silent! %s/\s\+$//e]])
	vim.fn.setpos('.', save_cursor)
	vim.fn.setreg('/', old_query)
end

function M.jump_to_last_visited()
	local line = vim.fn.line

	if line([['"]]) > 1 and line([['"]]) < line('$') then
		vim.cmd([[normal! g'"]])
	end
end

function M.yarn_install_if_missing(pkg_name)
	if not vim.fn.executable(pkg_name) then
		vim.fn.jobstart({ 'yarn', 'global', 'install', pkg_name }, {
			on_exit = function()
				print('[Yarn install] ' .. pkg_name .. 'installed successfully')
			end,
		})
	end
end

function _G.dump(...)
	local objects = vim.tbl_map(vim.inspect, { ... })
	print(unpack(objects))
	return ...
end

return M
