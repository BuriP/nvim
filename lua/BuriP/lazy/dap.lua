return {
	{ "rcarriga/nvim-dap-ui" },
	{ "mfussenegger/nvim-dap-python" },
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"mfussenegger/nvim-dap-python",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
			"jayp0521/mason-nvim-dap.nvim",
		},
		config = function()
			-- Require nvim-dap and dap-python
			local dap = require("dap")
			local dap_python = require("dap-python")

			-- Configure dap-python
			dap_python.setup("/Users/burip/.virtualenvs/debugpy/bin/python3") -- You can specify the Python interpreter here if needed

			--Configurinig python adapter
			dap.adapters.python = {
				type = "executable",
				command = "/Users/burip/.local/share/nvim/mason/packages/debugpy/venv/bin/python3", -- Ensure it’s the right path
				args = { "-m", "debugpy.adapter" },
			}

			-- Example Python DAP configuration
			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					console = "integratedTerminal",
					env = {
						DJANGO_SETTINGS_MODULE = "paylogic.backoffice.settings",
					},
					pythonPath = function()
						-- Automatically use the virtual environment, if available, or fallback to system Python
						local venv_path = os.getenv("VIRTUAL_ENV")
						if venv_path then
							return venv_path .. "/bin/python3"
						else
							return "/usr/bin/python3" -- Adjust if your system's Python path is different
						end
					end,
				},
			}

			-- Go configuration (nvim-dap-go handles configurations automatically)
			dap.adapters.go = {
				type = "executable",
				port = "${port}",
				executable = {
					command = "dlv",
					args = { "dap", "-l", "127.0.0.1:${port}" },
				},
			}

			-- Keymaps
			vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
			vim.keymap.set("n", "<space>?", function()
				require("dapui").eval(nil, { enter = true })
			end)
			vim.keymap.set("n", "<space>dpc", dap.continue)
			vim.keymap.set("n", "<F2>", dap.step_into)
			vim.keymap.set("n", "<F3>", dap.step_over)
			vim.keymap.set("n", "<F4>", dap.step_out)
			vim.keymap.set("n", "<F5>", dap.step_back)
			vim.keymap.set("n", "<F13>", dap.restart)

			-- DAP UI auto open/close
			local ui = require("dapui")
			ui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				ui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				ui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				ui.close()
			end
		end,
	},
}
