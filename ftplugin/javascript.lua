vim.cmd [[packadd nvim-dap]]
vim.cmd [[packadd nvim-dap-ui]]
vim.cmd [[packadd DAPInstall.nvim]]

require('dap-install').config('jsnode_dbg', {})
require('dapui').setup()
