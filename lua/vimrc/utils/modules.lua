local M = {}

function M.unload_lua_namespace(prefix)
	local prefix_with_dot = prefix .. '.'

	for module_name, _ in pairs(package.loaded) do
		if module_name == prefix or string.match(module_name, '^' .. prefix_with_dot) then
			package.loaded[module_name] = nil
		end
	end
end

function M.reload_vimrc()
	require('vimp').unmap_all()
	M.unload_lua_namespace('vimrc')
	require('vimrc')
	require('packer').compile()
end

function M.update_vimrc()
	vim.fn.jobstart({ 'git', [[-C="~/.config/nvim"]], 'pull', '--force' }, {
		on_exit = function(job_id, exit_code, event_type)
			if exit_code == 0 then
				print('Neovim config updated successfully!')
			else
				print('There was an error in updating the vimrc')
			end
		end,
	})
end

return M
