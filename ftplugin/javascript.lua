vim.cmd [[packadd nvim-dap]]
vim.cmd [[DAPInstall.nvim]]

require'dap-install'.config('jsnode_dbg', {})
