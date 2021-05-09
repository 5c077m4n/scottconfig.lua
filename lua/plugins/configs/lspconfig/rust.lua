local lspconfig = require'lspconfig'

lspconfig.rust_analyzer.setup {
	cmd = {'rust-analyzer'},
    filetypes = {'rust'},
    root_dir = lspconfig.utils.root_pattern('Cargo.toml', 'rust-project.json'),
    settings = {
    	['rust-analyzer'] = {}
    }
}
