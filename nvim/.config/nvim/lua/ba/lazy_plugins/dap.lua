local M = {
	"mfussenegger/nvim-dap",
	dependencies = {
		"mfussenegger/nvim-dap-python",
		"leoluz/nvim-dap-go",

		"jayp0521/mason-nvim-dap.nvim",

		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
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
			"firefox",
			"javadbg",
			"kotlin",
			"python",
		},
		automatic_setup = false,
	})
	---
	-- Setup
	---
	local dap, dapui = require("dap"), require("dapui")

	-- Python - debugpy
	require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")

	-- Go - delve
	-- require("dap-go").setup()

	---
	-- adapters
	---
	dap.adapters.lldb = {
		type = "executable",
		command = "/usr/sbin/lldb-vscode", -- adjust as needed, must be absolute path
		name = "lldb",
	}

	---
	-- configurations
	---
	-- CPP
	dap.configurations.cpp = {
		{
			name = "Launch",
			type = "lldb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: " .. vim.fn.getcwd() .. "/".. "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			args = {},
			-- 💀
			-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
			--
			--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
			--
			-- Otherwise you might get the following error:
			--
			--    Error on launch: Failed to attach to the target process
			--
			-- But you should be aware of the implications:
			-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
			-- runInTerminal = false,
			env = function()
				local variables = {}
				for k, v in pairs(vim.fn.environ()) do
					table.insert(variables, string.format("%s=%s", k, v))
				end
				return variables
			end,
		},
	}
	-- C
	dap.configurations.c = dap.configurations.cpp
	-- Rust
	-- You can use this or rust-tools
	dap.configurations.rust = dap.configurations.cpp
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
	vim.keymap.set("n", "<F4>", function()
		require("dapui").open()
	end)
	vim.keymap.set("n", "<F5>", function()
		require("dap").continue()
	end)
	vim.keymap.set("n", "<F10>", function()
		require("dap").step_over()
	end)
	vim.keymap.set("n", "<F11>", function()
		require("dap").step_into()
	end)
	vim.keymap.set("n", "<F12>", function()
		require("dap").step_out()
	end)
	vim.keymap.set("n", "<Leader>b", function()
		require("dap").toggle_breakpoint()
	end)
	vim.keymap.set("n", "<Leader>B", function()
		require("dap").set_breakpoint()
	end)
	vim.keymap.set("n", "<Leader>lp", function()
		require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
	end)
	vim.keymap.set("n", "<Leader>dr", function()
		require("dap").repl.open()
	end)
	vim.keymap.set("n", "<Leader>dl", function()
		require("dap").run_last()
	end)
	vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
		require("dap.ui.widgets").hover()
	end)
	vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
		require("dap.ui.widgets").preview()
	end)
	vim.keymap.set("n", "<Leader>df", function()
		local widgets = require("dap.ui.widgets")
		widgets.centered_float(widgets.frames)
	end)
	vim.keymap.set("n", "<Leader>ds", function()
		local widgets = require("dap.ui.widgets")
		widgets.centered_float(widgets.scopes)
	end)
end

return M
-- -- Setup all nvim-dap extension plugins
--
-- local dap = require("dap")
--
-- local dapui = require("dapui")
-- dapui.setup()
-- dap.listeners.after.event_initialized["dapui_config"] = function()
--   dapui.open()
-- end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close()
-- end
--
-- require("nvim-dap-virtual-text").setup {
-- 	-- virt_text_win_col = 70
-- }
--
--
-- -- Setup nvim-dap
--
--
-- local opts = { noremap = true, silent = true }
--
--
-- -- C C++ Rust conf
-- dap.adapters.lldb = {
-- 	type = "executable",
-- 	command = "/bin/lldb-vscode", -- adjust as needed, must be absolute path
-- 	name = "lldb",require("dapui").setup()
-- }
-- dap.configurations.cpp = {
-- 	{
-- 		name = "Launch",
-- 		type = "lldb",
-- 		request = "launch",
-- 		program = function()
-- 			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
-- 		end,
-- 		cwd = "${workspaceFolder}",
-- 		stopOnEntry = false,
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
-- 		env = function()
-- 			local variables = {}
-- 			for k, v in pairs(vim.fn.environ()) do
-- 				table.insert(variables, string.format("%s=%s", k, v))
-- 			end
-- 			return variables
-- 		end,
-- 	},
-- 	{
-- 		-- If you get an "Operation not permitted" error using this, try disabling YAMA:
-- 		--  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
-- 		name = "Attach to process",
-- 		type = "lldb", -- Adjust this to match your adapter name (`dap.adapters.<name>`)
-- 		request = "attach",
-- 		pid = require("dap.utils").pick_process,
-- 		args = {},
-- 		env = function()
-- 			local variables = {}
-- 			for k, v in pairs(vim.fn.environ()) do
-- 				table.insert(variables, string.format("%s=%s", k, v))
-- 			end
-- 			return variables
-- 		end,
-- 	},
-- }
-- dap.configurations.c = dap.configurations.cpp
-- dap.configurations.rust = dap.configurations.cpp
