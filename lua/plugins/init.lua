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
	require'bufferline'.setup()
	require'galaxyline'
	require'colorizer'.setup()
	require'gitsigns'.setup()

	require'treesitter'
	require'mappings'
	require'plugins.configs.compe'
	require'plugins.configs.nvim-tree'
	require'plugins.configs.floaterm'
	require'plugins.configs.lspconfig'
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
			use 'kyazdani42/nvim-tree.lua'
			use 'nvim-telescope/telescope.nvim'
			use 'nvim-telescope/telescope-media-files.nvim'
			use 'hrsh7th/vim-vsnip'
        	use 'rafamadriz/friendly-snippets'
			use 'voldikss/vim-floaterm'
			use 'mbbill/undotree'
			use {'glepnir/galaxyline.nvim', branch = 'main'}
			use {'lukas-reineke/indent-blankline.nvim', branch = 'lua', requires = {'kyazdani42/nvim-web-devicons', opt = true}}
	
			use {'wbthomason/packer.nvim', opt = true}
			use {'tweekmonster/startuptime.vim', opt = true}
		end,
		{
			display = {
				open_fn = require'packer.util'.float
			}
		}
	)
end

return M
