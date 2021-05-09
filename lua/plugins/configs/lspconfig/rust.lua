local root_pattern = require'nvim_lsp'.util.root_pattern

require'lspconfig'.rust_analyzer.setup {
	cmd = {'rust-analyzer'},
    filetypes = {'rust'},
    root_dir = root_pattern('Cargo.toml', 'rust-project.json'),
    settings = {
    	['rust-analyzer'] = {}
    }
}
