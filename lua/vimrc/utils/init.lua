local M = {}

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

function M.async_cmd(cmd, args)
	local uv = vim.loop

	local results = {}
	local stdout = uv.new_pipe(false)
	local stderr = uv.new_pipe(false)

	local function onread(_err, data)
		if data then
			table.insert(results, data)
		end
	end

	local handle
	handle = uv.spawn(
		cmd,
		{
			args = args,
			stdio = { nil, stdout, stderr },
		},
		vim.schedule_wrap(function()
			stdout:read_stop()
			stderr:read_stop()
			stdout:close()
			stderr:close()

			if handle and not handle:is_closing() then
				handle:close()
			end

			print(table.concat(results, '\n'))

			local count = #results
			for i = 0, count do
				results[i] = nil -- clear the table for the next search
			end
		end)
	)

	uv.read_start(stdout, onread)
	uv.read_start(stderr, onread)
end

return M
