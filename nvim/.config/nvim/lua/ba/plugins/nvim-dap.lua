-- Setup all nvim-dap extension plugins

local dap = require("dap")

local dapui = require("dapui")
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

require("nvim-dap-virtual-text").setup {
	-- virt_text_win_col = 70
}

require("dap-python").setup("~/repositories/pyvirtualenvs/debugpy/bin/python")
table.insert(require("dap").configurations.python, {
	python = "/bin/python",
	type = "python",
	request = "launch",
	name = "Lauch with global python install, without virtualenv",
	program = "${file}",
})

-- Setup nvim-dap


local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "<F1>", "<Cmd>lua require'dap'.step_into()<CR>", opts)
vim.api.nvim_set_keymap("n", "<F2>", "<Cmd>lua require'dap'.step_over()<CR>", opts)
vim.api.nvim_set_keymap("n", "<F3>", "<Cmd>lua require'dap'.step_out()<CR>", opts)
vim.api.nvim_set_keymap("n", "<F4>", "<Cmd>lua require'dapui'.open()<CR>", opts)
vim.api.nvim_set_keymap("n", "<F5>", "<Cmd>lua require'dap'.continue()<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>b", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>B",
	"<Cmd>lua vim.ui.input({prompt = 'Breakpoint condition: '}, function(input) require'dap'.set_breakpoint(input) end)<CR>",
	opts
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>lp",
	"<Cmd>lua vim.ui.input({prompt = 'Log point message: '}, function(input) require'dap'.set_breakpoint(nil, nil, input) end)<CR>",
	-- "<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.ui.input({ prompt = 'Log point message: '}, function(input) return input end))<CR>",
	opts
)
vim.api.nvim_set_keymap("n", "<Leader>dr", "<Cmd>lua require'dap'.repl.open()<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>dl", "<Cmd>lua require'dap'.run_last()<CR>", opts)

-- C C++ Rust conf
dap.adapters.lldb = {
	type = "executable",
	command = "/bin/lldb-vscode", -- adjust as needed, must be absolute path
	name = "lldb",
}
dap.configurations.cpp = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
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
	{
		-- If you get an "Operation not permitted" error using this, try disabling YAMA:
		--  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
		name = "Attach to process",
		type = "lldb", -- Adjust this to match your adapter name (`dap.adapters.<name>`)
		request = "attach",
		pid = require("dap.utils").pick_process,
		args = {},
		env = function()
			local variables = {}
			for k, v in pairs(vim.fn.environ()) do
				table.insert(variables, string.format("%s=%s", k, v))
			end
			return variables
		end,
	},
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
