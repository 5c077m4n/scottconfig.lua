local null_ls = require('null-ls')

null_ls.setup({
	diagnostics_format = '[#{c}] #{m} (#{s})',
	sources = {
		-- lua
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.luacheck,
		--null_ls.builtins.diagnostics.selene,
		-- python
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.black,
		null_ls.builtins.diagnostics.mypy,
		-- typescript
		null_ls.builtins.code_actions.eslint.with({ prefer_local = 'node_modules/.bin' }),
		null_ls.builtins.diagnostics.eslint.with({ prefer_local = 'node_modules/.bin' }),
		null_ls.builtins.formatting.eslint.with({ prefer_local = 'node_modules/.bin' }),
		null_ls.builtins.formatting.prettier.with({ prefer_local = 'node_modules/.bin' }),
		-- deno
		--null_ls.builtins.formatting.deno_fmt,
		-- css
		null_ls.builtins.formatting.stylelint,
		-- shell
		null_ls.builtins.formatting.shellharden,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.code_actions.shellcheck,
		-- sql
		null_ls.builtins.formatting.sqlformat,
		-- rust
		null_ls.builtins.formatting.rustfmt.with({
			args = { '+nightly' },
		}),
		-- nix
		null_ls.builtins.diagnostics.deadnix,
		null_ls.builtins.code_actions.statix,
		null_ls.builtins.formatting.nixfmt,
		null_ls.builtins.formatting.nixpkgs_fmt,
		-- terraform
		null_ls.builtins.formatting.terraform_fmt,
		-- markdown
		null_ls.builtins.diagnostics.write_good,
		-- yaml
		null_ls.builtins.diagnostics.yamllint,
		-- misc
		null_ls.builtins.completion.spell,
		--null_ls.builtins.diagnostics.editorconfig_checker,
		--null_ls.builtins.code_actions.gitsigns,
	},
	should_attach = function(bufnr)
		return not vim.api.nvim_buf_get_name(bufnr):match('/node_modules/')
	end,
	update_in_insert = true,
	debounce = 200,
})
