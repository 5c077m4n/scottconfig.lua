local null_ls = require('null-ls')

null_ls.setup({
	diagnostics_format = "[#{c}] #{m} (#{s})",
	sources = {
		-- python
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.black,
		null_ls.builtins.diagnostics.mypy,
		-- typescript
		-- null_ls.builtins.formatting.deno_fmt,
		null_ls.builtins.formatting.eslint_d,
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.code_actions.eslint_d,
		null_ls.builtins.formatting.prettier,
		-- css
		null_ls.builtins.formatting.stylelint,
		-- shell
		null_ls.builtins.formatting.shellharden,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.code_actions.shellcheck,
		-- sql
		null_ls.builtins.formatting.sqlformat,
		-- terraform
		null_ls.builtins.formatting.terraform_fmt,
		-- markdown
		null_ls.builtins.diagnostics.write_good,
		-- misc
		null_ls.builtins.completion.spell,
		null_ls.builtins.diagnostics.editorconfig_checker,
		-- null_ls.builtins.code_actions.gitsigns,
	},
})
null_ls.disable({
	filetypes = { 'lua', 'rust' }
})
