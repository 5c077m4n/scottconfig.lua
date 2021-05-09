local M = {}

local function bootstrap()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

	if fn.empty(fn.glob(install_path)) > 0 then
		local execute = vim.api.nvim_command
		local fn = vim.fn

		fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
		execute 'packadd packer.nvim'
	end
end

function M.initPackages()
	require'vimp'
	require'bufferline'
	require'galaxyline'
	require'colorizer'.setup()
	require'gitsigns'.setup()

	require'config-lsp'
	require'config-compe'
end

function M.setup()
	bootstrap()
	vim.cmd [[packadd packer.nvim]]

	return require'packer'.startup(
		function (use)
			use 'tpope/vim-sensible'
			use 'svermeulen/vimpeccable'
			use 'nvim-lua/plenary.nvim'
	
			use 'siduck76/nvim-base16.lua'
			use 'norcalli/nvim-colorizer.lua'
	
			use 'nvim-treesitter/nvim-treesitter'
			use 'neovim/nvim-lspconfig'
			use 'hrsh7th/nvim-compe'
	
			use 'lewis6991/gitsigns.nvim'
			use 'akinsho/nvim-bufferline.lua'
			use 'glepnir/galaxyline.nvim'
	
			use 'kyazdani42/nvim-tree.lua'
			use 'nvim-telescope/telescope.nvim'
			use 'nvim-telescope/telescope-media-files.nvim'
	
			use {'lukas-reineke/indent-blankline.nvim', branch = 'lua'}
	
			use {'wbthomason/packer.nvim', opt = true}
			use {'tweekmonster/startuptime.vim', opt = true}
		end,
		{
			display = {
				open_fn = require'packer.util'.float,
				border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
			}
		}
	)
end

return M
