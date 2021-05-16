local M = {}

function M.unload_lua_namespace(prefix)
	local prefix_with_dot = prefix .. '.'

	for key, value in pairs(package.loaded) do
		if key == prefix or key:sub(1, #prefix_with_dot) == prefix_with_dot then
			package.loaded[key] = nil
		end
	end
end

return M
