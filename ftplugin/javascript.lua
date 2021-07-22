vim.cmd [[packadd nvim-dap]]
vim.cmd [[packadd nvim-dap-ui]]
vim.cmd [[packadd DAPInstall.nvim]]

local dap_install = require 'dap-install'

dap_install.setup()
dap_install.config('ccppr_lldb_dbg', {})

require('dapui').setup()
