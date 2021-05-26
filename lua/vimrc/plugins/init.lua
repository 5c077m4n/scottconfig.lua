local M = {}

local function bootstrap()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

	if fn.empty(fn.glob(install_path)) > 0 then
		local execute = vim.api.nvim_command
		local fn = vim.fn

		fn.system {'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path}
		execute 'packadd packer.nvim'
	end
end

local function init_packer()
	vim.cmd [[packadd packer.nvim]]

	return require'packer'.startup {
		function (use)
			-- General
			use 'tpope/vim-sensible'
			use 'svermeulen/vimpeccable'
			use 'nvim-lua/plenary.nvim'
			-- Theme
			use 'navarasu/onedark.nvim'
			use 'norcalli/nvim-colorizer.lua'
			use 'delphinus/vim-auto-cursorline'
			use 'folke/todo-comments.nvim'
			use 'glepnir/dashboard-nvim'
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
			-- File tree
			use 'kyazdani42/nvim-tree.lua'
			-- LSP
			use 'nvim-treesitter/nvim-treesitter'
			use {'neovim/nvim-lspconfig', run = ':TSUpdate'}
			use 'kabouzeid/nvim-lspinstall'
			use 'hrsh7th/nvim-compe'
			use 'onsails/lspkind-nvim'
			use 'ray-x/lsp_signature.nvim'
			use {'folke/trouble.nvim', requires = 'kyazdani42/nvim-web-devicons'}
			use 'hrsh7th/vim-vsnip'
			use 'rafamadriz/friendly-snippets'
			-- Git
			use 'tpope/vim-fugitive'
			use {'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim'}
			use {'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim'}
			-- JSON query
			use 'gennaro-tedesco/nvim-jqx'

			use 'folke/which-key.nvim'
			use 'akinsho/nvim-bufferline.lua'
			use {
				'nvim-telescope/telescope.nvim',
				requires = {
					'nvim-lua/popup.nvim',
					'nvim-lua/plenary.nvim',
					'sharkdp/fd',
					'BurntSushi/ripgrep',
				},
			}
			use 'nvim-telescope/telescope-media-files.nvim'
			use {'phaazon/hop.nvim', as = 'hop'}
			use 'voldikss/vim-floaterm'
			use 'mbbill/undotree'
			use 'terrortylor/nvim-comment'
			use {'francoiscabrol/ranger.vim', requires = 'rbgrouleff/bclose.vim'}
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
	}
end

local function init_packages()
	require'vimp'

	require'vimrc.plugins.git'
	require'vimrc.plugins.nvim-treesitter'
	require'vimrc.plugins.lspconfig'
	require'vimrc.plugins.compe'
	require'vimrc.plugins.nvim-tree'
	require'vimrc.plugins.terminal'
	require'vimrc.plugins.galaxyline'
	require'vimrc.plugins.ranger'
	require'vimrc.plugins.nvim-dap'
	require'vimrc.plugins.telescope'
	require'vimrc.plugins.nvim-comment'
	require'vimrc.plugins.trouble'
	require'vimrc.plugins.theme'
	require'vimrc.plugins.hop'
	require'vimrc.plugins.dashboard'
	require'vimrc.plugins.which-key'
end

function M.setup()
	bootstrap()

	init_packer()
	local status, err = pcall(init_packages)
	if not status then
		print(err)
	end
end

return M
