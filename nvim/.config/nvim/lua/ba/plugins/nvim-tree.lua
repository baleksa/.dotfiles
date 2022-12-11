-- disable netrw (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Needed to fix nvim-tree openning on the right side
vim.opt.splitright = true

-- Open file explorer
vim.keymap.set("n", "-", "<cmd>NvimTreeToggle<CR>", { silent = true })
-- Open file explorer and position cursor on file thats opened
vim.keymap.set("n", "<leader>-", "<cmd>NvimTreeFindFile<CR>", { silent = true })

-- Autoclose is turned off because it doesn't work nicely with other plugins and features
-- vim.api.nvim_create_autocmd("BufEnter", {
--   group = vim.api.nvim_create_augroup("NvimTreeClose", {clear = true}),
--   pattern = "NvimTree_*",
--   callback = function()
--     local layout = vim.api.nvim_call_function("winlayout", {})
--     if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" and layout[3] == nil then vim.cmd("confirm quit") end
--   end
-- })

local lib = require("nvim-tree.lib")
local view = require("nvim-tree.view")
-- Helper functions
local function collapse_all()
	require("nvim-tree.actions.tree-modifiers.collapse-all").fn()
end

local function edit_or_open()
	-- open as vsplit on current node
	local action = "edit"
	local node = lib.get_node_at_cursor()

	-- Just copy what's done normally with vsplit
	if node.link_to and not node.nodes then
		require("nvim-tree.actions.node.open-file").fn(action, node.link_to)
		view.close() -- Close the tree if file was opened
	elseif node.nodes ~= nil then
		lib.expand_or_collapse(node)
	else
		require("nvim-tree.actions.node.open-file").fn(action, node.absolute_path)
		view.close() -- Close the tree if file was opened
	end
end

local function vsplit_preview()
	-- open as vsplit on current node
	local action = "vsplit"
	local node = lib.get_node_at_cursor()

	-- Just copy what's done normally with vsplit
	if node.link_to and not node.nodes then
		require("nvim-tree.actions.node.open-file").fn(action, node.link_to)
	elseif node.nodes ~= nil then
		lib.expand_or_collapse(node)
	else
		require("nvim-tree.actions.node.open-file").fn(action, node.absolute_path)
	end

	-- Finally refocus on tree if it was lost
	view.focus()
end

require("nvim-tree").setup({ -- Call setup function
	hijack_cursor = true,
	disable_netrw = true,
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	view = {
		mappings = {
			list = {
				{ key = "l", action = "edit", action_cb = edit_or_open },
				{ key = "L", action = "vsplit_preview", action_cb = vsplit_preview },
				{ key = "h", action = "close_node" },
				{ key = "H", action = "collapse_all", action_cb = collapse_all },
			},
		},
	},
	renderer = {
		highlight_git = true,
		indent_markers = {
			enable = true,
		},
		icons = {
			glyphs = {
				git = {
					unstaged = "x",
					staged = "+",
					unmerged = "",
					renamed = "➜",
					untracked = "?",
					deleted = "",
					ignored = "",
				},
			},
			show = {
				folder_arrow = false,
			},
		},
	},
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
})
