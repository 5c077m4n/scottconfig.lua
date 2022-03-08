local M = {}

local function bootstrap()
	local fn = vim.fn
	local install_path = fn.stdpath 'data' .. '/site/pack/packer/opt/packer.nvim'

	if fn.empty(fn.glob(install_path)) > 0 then
		vim.fn.system {
			'git',
			'clone',
			'https://github.com/wbthomason/packer.nvim',
			install_path,
		}
		vim.cmd [[packadd packer.nvim]]
	end
end

local function init_packer()
	vim.cmd [[packadd packer.nvim]]

	return require('packer').startup {
		function(use)
			-- General
			use 'tpope/vim-sensible'
			use 'svermeulen/vimpeccable'
			use 'nvim-lua/plenary.nvim'
			-- Theme
			use 'rafamadriz/neon'
			use 'norcalli/nvim-colorizer.lua'
			use 'folke/todo-comments.nvim'
			use {
				'glepnir/galaxyline.nvim',
				branch = 'main',
				requires = { 'kyazdani42/nvim-web-devicons', opt = true },
			}
			use 'akinsho/nvim-bufferline.lua'
			use 'onsails/lspkind-nvim'
			-- File tree
			use 'kyazdani42/nvim-tree.lua'
			-- LSP
			use 'nvim-treesitter/nvim-treesitter'
			use { 'neovim/nvim-lspconfig', run = ':TSUpdate' }
			use 'kabouzeid/nvim-lspinstall'
			use 'ray-x/lsp_signature.nvim'
			use { 'folke/trouble.nvim', requires = 'kyazdani42/nvim-web-devicons' }
			use 'glepnir/lspsaga.nvim'
			use 'nvim-lua/lsp-status.nvim'
			-- Code snippets
			use {
				'hrsh7th/nvim-compe',
				requires = { 'hrsh7th/vim-vsnip', 'rafamadriz/friendly-snippets' },
				opt = true,
			}
			-- Terminal
			use 'voldikss/vim-floaterm'
			-- Code workflow
			use { 'phaazon/hop.nvim', as = 'hop' }
			use { 'francoiscabrol/ranger.vim', requires = 'rbgrouleff/bclose.vim' }
			use 'folke/which-key.nvim'
			use 'blackCauldron7/surround.nvim'
			use 'terrortylor/nvim-comment'
			use 'mhartington/formatter.nvim'
			-- Git
			use 'tpope/vim-fugitive'
			use {
				'sindrets/diffview.nvim',
				requires = { 'kyazdani42/nvim-web-devicons', opt = true },
			}
			use 'kdheepak/lazygit.nvim'
			use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' }
			-- JSON query
			use 'gennaro-tedesco/nvim-jqx'
			-- Telescope
			use {
				'nvim-telescope/telescope.nvim',
				requires = {
					'nvim-lua/popup.nvim',
					'nvim-lua/plenary.nvim',
					'sharkdp/fd',
					'BurntSushi/ripgrep',
				},
			}
			use {
				'rmagatti/session-lens',
				requires = { 'rmagatti/auto-session', 'nvim-telescope/telescope.nvim' },
			}
			use {
				'nvim-telescope/telescope-media-files.nvim',
				requires = 'nvim-telescope/telescope.nvim',
			}
			-- use 'nvim-telescope/telescope-dap.nvim'
			-- Debugging
			use { 'mfussenegger/nvim-dap', opt = true }
			use {
				'Pocco81/DAPInstall.nvim',
				requires = 'mfussenegger/nvim-dap',
				opt = true,
			}
			use { 'rcarriga/nvim-dap-ui', requires = 'mfussenegger/nvim-dap', opt = true }
			use {
				'jbyuki/one-small-step-for-vimkind',
				requires = 'mfussenegger/nvim-dap',
				opt = true,
			}
			-- Optional
			use { 'wbthomason/packer.nvim', opt = true }
			use { 'tweekmonster/startuptime.vim', opt = true }
		end,
		config = { display = { open_fn = require('packer.util').float } },
	}
end

local function init_packages()
	require 'vimp'

	require 'vimrc.plugins.git'
	require 'vimrc.plugins.nvim-treesitter'
	require 'vimrc.plugins.lspconfig'
	require 'vimrc.plugins.compe'
	require 'vimrc.plugins.nvim-tree'
	require 'vimrc.plugins.terminal'
	require 'vimrc.plugins.galaxyline'
	require 'vimrc.plugins.ranger'
	require 'vimrc.plugins.telescope'
	require 'vimrc.plugins.nvim-comment'
	require 'vimrc.plugins.trouble'
	require 'vimrc.plugins.theme'
	require 'vimrc.plugins.hop'
	require 'vimrc.plugins.which-key'
	require 'vimrc.plugins.session'
	require 'vimrc.plugins.format'
end

function M.setup()
	bootstrap()

	init_packer()
	local success, err = pcall(init_packages)
	if not success then
		print(err)
	end
end

return M
