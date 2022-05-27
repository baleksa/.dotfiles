local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettier,
		-- Changed to pyslp which has these builtin
		-- null_ls.builtins.formatting.black,
		-- null_ls.builtins.formatting.isort,
		-- null_ls.builtins.diagnostics.flake8,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.code_actions.shellcheck,
	},
})

