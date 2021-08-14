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
		on_exit = function()
			print('Neovim config updated successfully!')
		end,
	})
end

return M
