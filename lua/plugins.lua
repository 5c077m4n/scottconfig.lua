local M = {}

function M.bootstrap()
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
	return require'packer'.startup(
		function (use)
			use 'wbthomason/packer.nvim'
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

	        use {'tweekmonster/startuptime.vim', opt = true}
		end,
		{
			display = {
				border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' }
			}
	    }
	)
end

return M
