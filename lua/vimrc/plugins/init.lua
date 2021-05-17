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

	return require'packer'.startup({
		function (use)
			use 'tpope/vim-sensible'
			use 'svermeulen/vimpeccable'
			use 'nvim-lua/plenary.nvim'
			use 'siduck76/nvim-base16.lua'
			use 'norcalli/nvim-colorizer.lua'
			use 'nvim-treesitter/nvim-treesitter'
			-- use 'neoclide/coc.nvim'
			use {'neovim/nvim-lspconfig', run = ':TSUpdate'}
			use 'kabouzeid/nvim-lspinstall'
			use 'hrsh7th/nvim-compe'
			use 'onsails/lspkind-nvim'
			use {
				'lewis6991/gitsigns.nvim',
				requires = {'nvim-lua/plenary.nvim'}
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
			use {'francoiscabrol/ranger.vim', requires = {'rbgrouleff/bclose.vim'}}
			use 'mfussenegger/nvim-dap'
			use 'jbyuki/one-small-step-for-vimkind'

			use {'wbthomason/packer.nvim', opt = true}
			use {'tweekmonster/startuptime.vim', opt = true}
		end,
		config = {
			display = {
				open_fn = require'packer.util'.float,
			},
		}
	})
end

local function init_packages()
	require'vimp'
	require'colorizer'.setup()
	require'bufferline'.setup()
	require'todo-comments'.setup()
	require'lspkind'.init()

	require'vimrc.plugins.gitsigns'
	require'vimrc.plugins.base16'
	require'vimrc.plugins.nvim-treesitter'
	require'vimrc.plugins.lspconfig'
	require'vimrc.plugins.lspsaga'
	require'vimrc.plugins.compe'
	require'vimrc.plugins.nvim-tree'
	require'vimrc.plugins.floaterm'
	require'vimrc.plugins.galaxyline'
	require'vimrc.plugins.ranger'
	require'vimrc.plugins.nvim-dap'
	require'vimrc.plugins.telescope'
	require'vimrc.plugins.nvim-comment'
	-- require'vimrc.plugins.coc'
end

function M.setup()
	bootstrap()

	init_packer()
	init_packages()
end

return M
