local M = {
	"mfussenegger/nvim-dap",
	dependencies = {
		"mfussenegger/nvim-dap-python",
		"leoluz/nvim-dap-go",
		"jbyuki/one-small-step-for-vimkind",

		"jayp0521/mason-nvim-dap.nvim",

		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"suketa/nvim-dap-ruby",
	},
}
function M.config()
	---
	-- Install with mason-nvim-dap
	---
	-- mason needs to be setup before setting up mason_dap. lsp-zero calls mason.
	-- setup() after checking if its already setup, so this call is safe.
	require("mason").setup()

	local mason_dap = require("mason-nvim-dap")
	mason_dap.setup({
		ensure_installed = {
			"bash",
			"codelldb",
			"delve",
			"javadbg",
			"kotlin",
			"python",
		},
		automatic_setup = true,
		handlers = {
		-- function(source_name)
		-- 	-- all sources with no handler get passed here
		--
		-- 	-- Keep original functionality of `automatic_setup = true`
		-- 	require("mason-nvim-dap.automatic_setup")(source_name)
		-- end,
		python = function(_)
			require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")
		end,
		delve = function(_)
			require("dap-go").setup()
		end,
		},
	})

	require("dap-ruby").setup()

	---
	-- Setup
	---
	local dap, dapui = require("dap"), require("dapui")
	--
	-- -- Python - debugpy
	--
	-- -- Go - delve
	--
	-- ---
	-- -- adapters
	-- ---
	-- dap.adapters.lldb = {
	-- 	type = "executable",
	-- 	command = "/usr/sbin/lldb-vscode", -- adjust as needed, must be absolute path
	-- 	name = "lldb",
	-- }
	-- dap.adapters.nlua = function(callback, config)
	-- 	callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
	-- end
	-- ---
	-- -- configurations
	-- ---
	-- -- Lua
	-- dap.configurations.lua = {
	-- 	{
	-- 		type = "nlua",
	-- 		request = "attach",
	-- 		name = "Attach to running Neovim instance",
	-- 	},
	-- }
	-- -- CPP
	-- dap.configurations.cpp = {
	-- 	{
	-- 		name = "Launch",
	-- 		type = "lldb",
	-- 		request = "launch",
	-- 		program = function()
	-- 			return vim.fn.input({
	-- 				prompt = "Path to executable: " .. vim.fn.getcwd() .. "/",
	-- 				completion = "file",
	-- 			})
	-- 		end,
	-- 		cwd = "${workspaceFolder}",
	-- 		stopOnEntry = false,
	-- 		showDisassembly = "never",
	-- 		args = {},
	-- 		-- 💀
	-- 		-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
	-- 		--
	-- 		--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
	-- 		--
	-- 		-- Otherwise you might get the following error:
	-- 		--
	-- 		--    Error on launch: Failed to attach to the target process
	-- 		--
	-- 		-- But you should be aware of the implications:
	-- 		-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
	-- 		-- runInTerminal = false,
	-- 	},
	-- }
	---
	-- nvim-dap-ui
	---
	dapui.setup()
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end

	---
	-- Keymaps
	---
	require("which-key").register({
		d = {
			name = "DAP",
			R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
			E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
			e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
			C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
			t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
			l = { "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", "Log point" },
			U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
			["sb"] = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
			c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
			h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
			s = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
			i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
			o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
			u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
			p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
			r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
			q = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
		},
	}, { prefix = "<leader>" })
end

return M
