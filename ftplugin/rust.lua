vim.cmd [[packadd nvim-dap]]
vim.cmd [[packadd DAPInstall.nvim]]

require'dap-install'.config('ccppr_lldb_dbg', {})
