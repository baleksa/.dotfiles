local M = {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v2.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		{
			-- only needed if you want to use the commands with "_with_window_picker" suffix
			"s1n7ax/nvim-window-picker",
			version = "v1.*",
			config = function()
				require("window-picker").setup({
					autoselect_one = true,
					include_current = false,
					filter_rules = {
						-- filter using buffer options
						bo = {
							-- if the file type is one of following, the window will be ignored
							filetype = { "neo-tree", "neo-tree-popup", "notify" },

							-- if the buffer type is one of following, the window will be ignored
							buftype = { "terminal", "quickfix" },
						},
					},
					other_win_hl_color = "#e35e4f",
				})
			end,
		},
	},
	cond = function()
		return vim.g.file_explorer == "neo_tree"
	end,
}

function M.config()
	-- Disable netrw
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1

	-- Unless you are still migrating, remove the deprecated commands from v1.x
	vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

	-- Link some of the highlights if a colorscheme doesn't support neo-tree but
	-- supports nvim-tree
	vim.cmd([[
		highlight! link NeoTreeDirectoryIcon NvimTreeFolderIcon
		highlight! link NeoTreeDirectoryName NvimTreeFolderName
		highlight! link NeoTreeSymbolicLinkTarget NvimTreeSymlink
		highlight! link NeoTreeRootName NvimTreeRootFolder
		highlight! link NeoTreeDirectoryName NvimTreeOpenedFolderName
		highlight! link NeoTreeFileNameOpened NvimTreeOpenedFile
	]])

	require("neo-tree").setup({
		close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
		popup_border_style = "single",
		sort_case_insensitive = false, -- used when sorting files and directories in the tree
		event_handlers = {
			{
				event = "file_opened",
				handler = function()
					require("neo-tree").close_all()
				end,
			},
			{
				event = "neo_tree_buffer_enter",
				handler = function()
					-- This effectively hides the cursor
					vim.cmd("highlight! Cursor blend=100")
				end,
			},
			{
				event = "neo_tree_buffer_leave",
				handler = function()
					-- Make this whatever your current Cursor highlight group is.
					vim.cmd("highlight! Cursor blend=0")
				end,
			},
		},
		default_component_configs = {
			container = {
				enable_character_fade = true,
			},
			icon = {
				folder_empty = "",
				default = "",
				highlight = "NeoTreeFileIcon",
			},
			modified = {
				symbol = "[+]",
				highlight = "NeoTreeModified",
			},
			name = {
				use_git_status_colors = true,
			},
			git_status = {
				symbols = {
					added = "",
					modified = "",
					untracked = "?",
					ignored = "",
					unstaged = "",
					staged = "",
					conflict = "",
				},
			},
		},
		window = {
			width = 30,
			mappings = {
				["<space>"] = "none",
				["-"] = "none",
				["l"] = "open_with_window_picker",
				["L"] = "vsplit_with_window_picker",
				["s"] = "split_with_window_picker",
				["h"] = "close_node",
				["H"] = "close_all_nodes",
				["a"] = {
					"add",
					-- some commands may take optional config options, see `:h neo-tree-mappings` for details
					config = {
						show_path = "none", -- "none", "relative", "absolute"
					},
				},
			},
		},
		nesting_rules = {},
		filesystem = {
			commands = {
				run_command = function(state)
					local node = state.tree:get_node()
					local path = node:get_id()
					vim.api.nvim_input(": " .. path .. "<Home>")
				end,
			},
			filtered_items = {
				hide_dotfiles = false,
				force_visible_in_empty_folder = true,
				hide_by_name = {
					--"node_modules"
				},
				hide_by_pattern = { -- uses glob style patterns
					--"*.meta",
					--"*/src/*/tsconfig.json",
				},
				always_show = { -- remains visible even if other settings would normally hide it
					".gitignored",
				},
				never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
					--".DS_Store",
					--"thumbs.db"
				},
				never_show_by_pattern = { -- uses glob style patterns
					--".null-ls_*",
				},
			},
			follow_current_file = false, -- This will find and focus the file in the active buffer every
			-- time the current file is changed while the tree is open.
			hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
			-- in whatever position is specified in window.position
			-- "open_current",  -- netrw disabled, opening a directory opens within the
			-- window like netrw would, regardless of window.position
			-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
			use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
			-- instead of relying on nvim autocmd events.
			window = {
				mappings = {
					["u"] = "navigate_up",
					["i"] = "run_command",
				},
			},
		},
		buffers = {
			follow_current_file = true, -- This will find and focus the file in the active buffer every
			-- time the current file is changed while the tree is open.
		},
	})

	vim.keymap.set("n", "-", "<cmd>NeoTreeRevealToggle<cr>")
	vim.keymap.set("n", "<leader>-", "<cmd>NeoTreeFloatToggle<cr>")
end

return M
