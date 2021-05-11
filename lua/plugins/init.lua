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

function M.setup()
	bootstrap()
	vim.cmd [[packadd packer.nvim]]

	return require'packer'.startup(
		function (use)
			use 'tpope/vim-sensible'
			use {
				'svermeulen/vimpeccable',
				config = function() require'vimp' end,
			}
			use 'nvim-lua/plenary.nvim'
			use {
				'siduck76/nvim-base16.lua',
				config = function() require'plugins.configs.base16' end
			}
			use {
				'norcalli/nvim-colorizer.lua',
				config = function() require'colorizer'.setup() end
			}
			use {
				'nvim-treesitter/nvim-treesitter',
				config = function() require'plugins.configs.nvim-treesitter' end,
			}
			use {
				'neovim/nvim-lspconfig',
				run = ':TSUpdate',
				config = function() require'plugins.configs.lspconfig' end
			}
			use {
				'glepnir/lspsaga.nvim',
				requires = {{'nvim-lspconfig'}},
				config = function() 
					require'plugins.configs.lspsaga'
					require'mappings.lspsaga'
				end,
			}
			use {
				'hrsh7th/nvim-compe',
				config = function()
					require'plugins.configs.compe'
					require'mappings.compe'
				end,
			}
			use {
				'lewis6991/gitsigns.nvim',
				config = function()
					require'gitsigns'.setup()
				end,
			}
			use {
				'akinsho/nvim-bufferline.lua',
				config = function()
					require'bufferline'.setup()
				end,
			}
			use {
				'kyazdani42/nvim-tree.lua',
				config = function()
					require'plugins.configs.nvim-tree'
					require'mappings.nvim-tree'
				end,
			}
			use {
				'nvim-telescope/telescope.nvim',
				requires = {
					{'nvim-lua/popup.nvim'},
					{'nvim-lua/plenary.nvim'},
					{'sharkdp/fd'},
					{'BurntSushi/ripgrep'},
				},
				config = function()
					require'mappings.telescope'
				end
			}
			use 'nvim-telescope/telescope-media-files.nvim'
			use 'hrsh7th/vim-vsnip'
	        	use 'rafamadriz/friendly-snippets'
			use {
				'voldikss/vim-floaterm',
				config = function()
					require'plugins.configs.floaterm'
					require'mappings.floaterm'
				end,
			}
			use {
				'mbbill/undotree',
				config = function()
					require'mappings.undotree'
				end,
			}
			use {
				'glepnir/galaxyline.nvim',
				branch = 'main',
				requires = {'kyazdani42/nvim-web-devicons', opt = true},
				config = function()
					require'plugins.configs.galaxyline'
				end
			}
			use {
				'lukas-reineke/indent-blankline.nvim',
				branch = 'lua',
				requires = {'kyazdani42/nvim-web-devicons', opt = true},
			}
			use {
				'francoiscabrol/ranger.vim',
				requires = {'rbgrouleff/bclose.vim'},
				config = function()
					require'plugins.configs.ranger'
					require'mappings.ranger'
				end,
			}
			use {
				'mfussenegger/nvim-dap',
				config = function()
					require'plugins.configs.nvim-dap'
					require'mappings.nvim-dap'
				end,
			}
	
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
