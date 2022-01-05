local null_ls = require('null-ls')

null_ls.setup({
	diagnostics_format = '[#{c}] #{m} (#{s})',
	sources = {
		-- lua
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.luacheck,
		null_ls.builtins.diagnostics.selene,
		-- python
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.black,
		null_ls.builtins.diagnostics.mypy,
		-- typescript
		null_ls.builtins.formatting.eslint_d,
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.code_actions.eslint_d,
		null_ls.builtins.formatting.prettier,
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
		null_ls.builtins.formatting.rustfmt,
		-- terraform
		null_ls.builtins.formatting.terraform_fmt,
		-- markdown
		null_ls.builtins.diagnostics.write_good,
		-- yaml
		null_ls.builtins.diagnostics.yamllint,
		-- misc
		null_ls.builtins.completion.spell,
		null_ls.builtins.diagnostics.editorconfig_checker,
		--null_ls.builtins.code_actions.gitsigns,
	},
	update_in_insert = true,
	debounce = 200,
})
