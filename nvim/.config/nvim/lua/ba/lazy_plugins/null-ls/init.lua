local M = {
	-- null-ls
	"jose-elias-alvarez/null-ls.nvim",

	dependencies = {
		"jayp0521/mason-null-ls.nvim",
	},
}

M.config = function()

	local ltcc = require("ba.lazy_plugins.null-ls.ltcc")
	local function is_spelllang_en()
		return vim.list_contains(vim.opt_local.spelllang:get(), "en")
	end

	local null_ls = require("null-ls")
	local ca = null_ls.builtins.code_actions
	local diag = null_ls.builtins.diagnostics
	local fmt = null_ls.builtins.formatting
	local sources = {
		-- Don't run cspell from null-ls, run it manually if needed
		-- ca.cspell.with({
		-- 	extra_args = { "-u", "-c", os.getenv("HOME") .. "/.config/cspell.json" },
		-- }),
		-- diag.cspell.with({
		-- 	extra_args = { "-u", "-c", os.getenv("HOME") .. "/.config/cspell.json" },
		-- }),
		-- Diagnostics
		ltcc.diagnostics,
		-- Code actions
		ltcc.code_actions,
		ca.gitsigns,
		-- Formatting
		fmt.yq,
		-- Lua
		fmt.stylua,
		-- Ruby
		diag.reek, -- Complements rubocop
		-- diag.standardrb,
		-- fmt.standardrb,
		diag.erb_lint, -- .erb
		fmt.htmlbeautifier, -- .erb
		-- Shell
		fmt.shfmt,
		fmt.shellharden,
		ca.shellcheck,
		-- Fish
		diag.fish,
		fmt.fish_indent,
		-- JavaScript
		diag.standardjs,
		fmt.standardjs,
		fmt.prettierd.with({
			filetypes = {
				"vue",
				"css",
				"scss",
				"less",
				"html",
				"json",
				"jsonc",
				"yaml",
				-- "markdown",
				-- "markdown.mdx",
				"graphql",
				"handlebars",
			},
		}),
		-- Markdown
		diag.mdl,
		fmt.mdformat.with({
			extra_args = { "--wrap", "80" },
		}),
		-- Writing,
		diag.alex.with({
			condition = is_spelllang_en,
		}),
		-- Proselint, because it has bugs in
		-- handling cache files and because it
		-- prints errors on stdout instead of
		-- stderr, returns invalid json to
		-- null-ls which expects valid json
		-- and can't parse stupid error
		-- messages. In order to fix that I
		-- commented out all print() statements
		-- in proselint's code
		diag.proselint.with({
			condition = is_spelllang_en,
		}),
		diag.write_good.with({
			extra_args = { "--no-passive" },
			condition = is_spelllang_en,
		}),
		ca.proselint.with({
			condition = is_spelllang_en,
		}),
		ca.ltrs.with({
			condition = is_spelllang_en,
		}),
		null_ls.builtins.hover.dictionary.with({
			condition = is_spelllang_en,
		}),
	}

	null_ls.setup({
		debug = true,
		sources = sources,
		diagnostics_format = "#{m} [#{s}]",
	})

	-- Fixed by setting offsetEncoding for clangd
	-- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
	--
	-- Ignore clients with different offset_encodings notification
	--
	-- local notify = vim.notify
	-- vim.notify = function(msg, ...)
	-- 	if msg:match("warning: multiple different client offset_encodings") then
	-- 		return
	-- 	end
	--
	-- 	notify(msg, ...)
	-- end

	require("mason-null-ls").setup({
		ensure_installed = {},
		automatic_installation = true,
		automatic_setup = false,
	})
end
return M
