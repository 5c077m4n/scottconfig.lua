local M = {}

local function bootstrap()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

	if fn.empty(fn.glob(install_path)) > 0 then
		vim.fn.system({
			'git',
			'clone',
			'https://github.com/wbthomason/packer.nvim',
			install_path,
		})
		vim.cmd([[packadd packer.nvim]])
	end
end

local function init_packer()
	vim.cmd([[packadd packer.nvim]])

	require('packer').startup({
		function(use)
			-- General
			use('tpope/vim-sensible')
			use('svermeulen/vimpeccable')
			use('nvim-lua/plenary.nvim')
			use({
				'rcarriga/nvim-notify',
				config = function()
					vim.notify = require('notify')
				end,
			})
			use({
				'nathom/filetype.nvim',
				config = function()
					require('filetype').setup({
						extensions = {
							tsx = 'typescriptreact',
							jsx = 'javascriptreact',
							toml = 'toml',
						},
						literal = {
							['.babelrc'] = 'json',
							['.swcrc'] = 'json',
						},
					})
				end,
			})
			-- Theme
			use({
				'projekt0n/github-nvim-theme',
				config = function()
					require('github-theme').setup({
						theme_style = 'dark_default',
						sidebars = { 'lazygit', 'terminal', 'packer' },
						colors = { hint = 'orange', error = '#ff0000' },
					})
				end,
			})
			use({
				'norcalli/nvim-colorizer.lua',
				config = function()
					require('colorizer').setup()
				end,
			})
			use({
				'folke/todo-comments.nvim',
				config = function()
					require('todo-comments').setup()
				end,
			})
			use({
				'feline-nvim/feline.nvim',
				requires = { 'kyazdani42/nvim-web-devicons' },
				config = function()
					require('feline').setup({ preset = 'noicon' })
				end,
			})
			use({
				'akinsho/nvim-bufferline.lua',
				config = function()
					require('bufferline').setup({
						options = {
							numbers = 'both',
							offsets = {
								{
									filetype = 'NvimTree',
									text = 'File Explorer',
									highlight = 'Directory',
									text_align = 'left',
								},
							},
							diagnostics = 'nvim_lsp',
							diagnostics_indicator = function(count, _level, _diagnostics_dict, _context)
								return '(' .. count .. ')'
							end,
						},
					})
				end,
				disable = vim.fn.has('gui_vimr') == 1,
			})
			use({
				'onsails/lspkind-nvim',
				config = function()
					require('lspkind').init() -- Icons in autocomplete popup
				end,
				event = 'BufReadPost',
			})
			-- File tree
			use({
				'kyazdani42/nvim-tree.lua',
				config = function()
					require('vimrc.plugins.nvim-tree')
				end,
			})
			-- Treesitter
			use({
				'nvim-treesitter/nvim-treesitter',
				config = function()
					require('vimrc.plugins.nvim-treesitter')
				end,
			})
			-- LSP
			use({
				'neovim/nvim-lspconfig',
				requires = {
					'nvim-lua/lsp-status.nvim',
				},
				run = ':TSUpdate',
				config = function()
					require('vimrc.plugins.lspconfig')
				end,
			})
			use({
				'williamboman/nvim-lsp-installer',
				requires = { 'neovim/nvim-lspconfig' },
			})
			use({
				'folke/trouble.nvim',
				requires = 'kyazdani42/nvim-web-devicons',
				config = function()
					require('vimrc.plugins.trouble')
				end,
			})
			use('folke/lua-dev.nvim')
			use({
				'simrat39/rust-tools.nvim',
				requires = {
					'neovim/nvim-lspconfig',
					'nvim-lua/popup.nvim',
					'nvim-lua/plenary.nvim',
					'nvim-telescope/telescope.nvim',
					'mfussenegger/nvim-dap',
				},
				ft = { 'rust' },
				config = function()
					require('rust-tools').setup({
						server = {
							settings = {
								['rust-analyzer'] = {
									assist = {
										importGranularity = 'module',
										importPrefix = 'by_self',
									},
									cargo = {
										loadOutDirsFromCheck = true,
									},
									procMacro = {
										enable = true,
									},
								},
							},
						},
					})
				end,
				disable = true,
			})
			use({
				'jose-elias-alvarez/null-ls.nvim',
				requires = { 'nvim-lua/plenary.nvim' },
				config = function()
					require('vimrc.plugins.null-ls')
				end,
			})
			-- Code snippets
			use({
				'hrsh7th/nvim-compe',
				requires = { 'hrsh7th/vim-vsnip', 'rafamadriz/friendly-snippets' },
				config = function()
					require('vimrc.plugins.compe')
				end,
			})
			-- Terminal
			use({
				'voldikss/vim-floaterm',
				config = function()
					require('vimrc.plugins.terminal')
				end,
			})
			-- Code workflow
			use({
				'phaazon/hop.nvim',
				as = 'hop',
				keys = { 'F' },
				config = function()
					require('vimrc.plugins.hop')
				end,
			})
			use({
				'francoiscabrol/ranger.vim',
				requires = 'rbgrouleff/bclose.vim',
				setup = function()
					require('vimrc.plugins.ranger')
				end,
			})
			use('folke/which-key.nvim')
			use({
				'5c077m4n/surround-nvim-mirror',
				config = function()
					require('surround').setup({
						prefix = 'S',
						mappings_style = 'sandwich',
						pairs = {
							nestable = { { '(', ')' }, { '[', ']' }, { '{', '}' }, { '<', '>' } },
							linear = { { [[']], [[']] }, { [["]], [["]] }, { [[`]], [[`]] } },
						},
						brackets = { '(', '{', '[', '<' },
					})
				end,
			})
			use({
				'windwp/nvim-autopairs',
				event = 'InsertEnter',
				config = function()
					require('nvim-autopairs').setup()
					require('nvim-autopairs.completion.compe').setup({
						map_cr = true, --  map <CR> on insert mode
						map_complete = true, -- it will auto insert `(` after select function or method item
					})
				end,
			})
			use({
				'terrortylor/nvim-comment',
				config = function()
					require('vimrc.plugins.nvim-comment')
				end,
			})
			-- Git
			use({
				'tpope/vim-fugitive',
				config = function()
					require('vimrc.plugins.git-fugitive')
				end,
			})
			use({
				'sindrets/diffview.nvim',
				requires = { 'kyazdani42/nvim-web-devicons', opt = true },
				cmd = 'DiffviewOpen',
				config = function()
					require('vimrc.plugins.diffview')
				end,
			})
			use({ 'kdheepak/lazygit.nvim', cmd = 'LazyGit', branch = 'main' })
			use({
				'lewis6991/gitsigns.nvim',
				requires = 'nvim-lua/plenary.nvim',
				config = function()
					require('vimrc.plugins.gitsigns')
				end,
			})
			-- Telescope
			use({
				'nvim-telescope/telescope.nvim',
				requires = {
					'nvim-lua/popup.nvim',
					'nvim-lua/plenary.nvim',
					'sharkdp/fd',
					'BurntSushi/ripgrep',
				},
				config = function()
					require('vimrc.plugins.telescope')
				end,
			})
			use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
			-- Session
			use({
				'rmagatti/auto-session',
				config = function()
					require('vimrc.plugins.auto-session')
				end,
			})
			-- Debugging
			use({ 'nvim-telescope/telescope-dap.nvim', disable = true })
			use({ 'mfussenegger/nvim-dap', ft = { 'javascript', 'lua', 'rust' }, disable = true })
			use({
				'Pocco81/DAPInstall.nvim',
				requires = 'mfussenegger/nvim-dap',
				ft = { 'javascript', 'lua', 'rust' },
				config = function()
					local dap_install = require('dap-install')

					dap_install.setup()
					dap_install.config('ccppr_lldb_dbg', {})
				end,
				disable = true,
			})
			use({
				'rcarriga/nvim-dap-ui',
				requires = 'mfussenegger/nvim-dap',
				ft = { 'javascript', 'lua', 'rust' },
				config = function()
					require('dapui').setup()
				end,
				disable = true,
			})
			use({
				'jbyuki/one-small-step-for-vimkind',
				requires = 'mfussenegger/nvim-dap',
				ft = { 'javascript', 'lua', 'rust' },
				disable = true,
			})

			-- Optional
			use({ 'wbthomason/packer.nvim', opt = true })
			use({ 'tweekmonster/startuptime.vim', opt = true })
		end,
		config = { display = { open_fn = require('packer.util').float } },
	})
end

function M.setup()
	bootstrap()
	init_packer()
end

return M
