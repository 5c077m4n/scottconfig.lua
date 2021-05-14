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

local function init_packer()
	vim.cmd [[packadd packer.nvim]]

	return require'packer'.startup(
		function (use)
			use 'tpope/vim-sensible'
			use 'svermeulen/vimpeccable'
			use 'nvim-lua/plenary.nvim'
			use 'siduck76/nvim-base16.lua'
			use 'norcalli/nvim-colorizer.lua'
			use 'nvim-treesitter/nvim-treesitter'
			use {
				'neovim/nvim-lspconfig',
				run = ':TSUpdate',
			}
			use {
				'glepnir/lspsaga.nvim',
				requires = {{'nvim-lspconfig'}},
			}
			use 'hrsh7th/nvim-compe'
			use {
				'lewis6991/gitsigns.nvim',
				requires = {
					'nvim-lua/plenary.nvim'
				}
			}
			use 'akinsho/nvim-bufferline.lua'
			use 'kyazdani42/nvim-tree.lua'
			use {
				'nvim-telescope/telescope.nvim',
				requires = {
					{'nvim-lua/popup.nvim'},
					{'nvim-lua/plenary.nvim'},
					{'sharkdp/fd'},
					{'BurntSushi/ripgrep'},
				},
			}
			use 'nvim-telescope/telescope-media-files.nvim'
			use 'hrsh7th/vim-vsnip'
			use 'rafamadriz/friendly-snippets'
			use 'voldikss/vim-floaterm'
			use 'mbbill/undotree'
			use 'terrortylor/nvim-comment'
			use 'folke/todo-comments.nvim'
			use {
				'glepnir/galaxyline.nvim',
				branch = 'main',
				requires = {'kyazdani42/nvim-web-devicons', opt = true},
			}
			use {
				'lukas-reineke/indent-blankline.nvim',
				branch = 'lua',
				requires = {'kyazdani42/nvim-web-devicons', opt = true},
			}
			use {
				'francoiscabrol/ranger.vim',
				requires = {'rbgrouleff/bclose.vim'},
			}
			use 'mfussenegger/nvim-dap'
			use 'jbyuki/one-small-step-for-vimkind'
	
			use {'wbthomason/packer.nvim', opt = true}
			use {'tweekmonster/startuptime.vim', opt = true}
		end,
		{
			display = {open_fn = require'packer.util'.float}
		}
	)
end

local function init_packages()
	require'vimp'
	require'colorizer'.setup() 
	require'bufferline'.setup()
	require'todo-comments'.setup()

	require'plugins.configs.gitsigns'
	require'plugins.configs.base16' 
	require'plugins.configs.nvim-treesitter'
	require'plugins.configs.lspconfig' 
	require'plugins.configs.lspsaga'
	require'plugins.configs.compe'
	require'plugins.configs.nvim-tree'
	require'plugins.configs.floaterm'
	require'plugins.configs.galaxyline' 
	require'plugins.configs.ranger'
	require'plugins.configs.nvim-dap'
	require'plugins.configs.telescope'
	require'plugins.configs.nvim-comment'

	require'mappings.lspsaga'
	require'mappings.compe'
	require'mappings.nvim-tree'
	require'mappings.telescope' 
	require'mappings.floaterm'
	require'mappings.undotree'
	require'mappings.ranger'
	require'mappings.nvim-dap'
end

function M.setup()
	bootstrap()

	init_packer()
	init_packages()
end

return M
