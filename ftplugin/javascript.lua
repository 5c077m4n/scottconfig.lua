vim.cmd [[packadd nvim-dap]]
vim.cmd [[packadd DAPInstall.nvim]]

require'dap-install'.config('jsnode_dbg', {})
