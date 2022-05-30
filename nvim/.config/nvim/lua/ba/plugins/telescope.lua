require("telescope").setup({
-- 	defaults = {
-- 		mappings = {
-- 			i = {
-- 				["<C-u>"] = false,
-- 				["<C-d>"] = false,
-- 			},
-- 		},
-- 	},
	pickers = {
		find_files = {
			find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({
			}),
		},
	},
})

require("telescope").load_extension("fzf")
-- require("telescope").load_extension("ui-select")

