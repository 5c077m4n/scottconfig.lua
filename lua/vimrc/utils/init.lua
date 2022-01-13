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
	vim.cmd([[silent! %s/\s\+$//]])
end

function M.jump_to_last_visited()
	local line = vim.fn.line

	if line([['"]]) > 1 and line([['"]]) < line('$') then
		vim.cmd([[normal! g'"]])
	end
end

function M.async_cmd(cmd, args)
	local uv = vim.loop

	local results_stdout = {}
	local results_stderr = {}
	local stdout = uv.new_pipe(false)
	local stderr = uv.new_pipe(false)

	local function on_read(_err, data)
		if data then
			if type(data) == 'string' then
				vim.list_extend(results_stdout, vim.split(data, '\n', true))
			else
				table.insert(results_stdout, data)
			end
		end
	end
	local function on_error(_err, data)
		if data then
			if type(data) == 'string' then
				vim.list_extend(results_stderr, vim.split(data, '\n', true))
			else
				table.insert(results_stderr, data)
			end
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

			if not vim.tbl_isempty(results_stdout) then
				vim.notify(results_stdout, vim.lsp.log_levels.INFO)
			end
			if not vim.tbl_isempty(results_stderr) then
				vim.notify(results_stderr, vim.lsp.log_levels.ERROR)
			end

			-- clear the stdout table for the next search
			for i = 0, #results_stdout do
				results_stdout[i] = nil
			end
			-- clear the stderr table for the next search
			for i = 0, #results_stderr do
				results_stderr[i] = nil
			end
		end)
	)

	uv.read_start(stdout, on_read)
	uv.read_start(stderr, on_read) -- on_error
end

return M
