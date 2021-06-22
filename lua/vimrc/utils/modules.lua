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
	vimp.unmap_all()
	M.unload_lua_namespace('vimrc')
	require'vimrc'
end

function M.update_vimrc()
	vim.fn.system [[git -C ~/.config/nvim pull --force]]
	print('Neovim config updated successfully!')
end

return M
