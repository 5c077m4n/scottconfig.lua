local dap = require'dap'

-- Rust
dap.adapters.cpp = {
	type = 'executable',
	attach = {
		pidProperty = "pid",
		pidSelect = "ask"
	},
	command = 'lldb-vscode',
	env = {
		LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = 'YES'
	},
	name = "lldb"
}

-- JS
--[[
	To install node-debug2:

`	```bash
	git clone https://github.com/microsoft/vscode-node-debug2.git
	cd vscode-node-debug2
	npm install
	gulp build
	```
--]]
dap.adapters.node2 = {
	type = 'executable',
	command = 'node',
	args = {os.getenv('HOME') .. '/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js'},
}
dap.configurations.javascript = {
	{
		type = 'node2',
		request = 'launch',
		program = '${file}',
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = 'inspector',
		console = 'integratedTerminal',
	},
}
