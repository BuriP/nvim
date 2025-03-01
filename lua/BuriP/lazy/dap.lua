return {
	{
		{
			"mfussenegger/nvim-dap",
			dependencies = {
				"mfussenegger/nvim-dap-python",
				"nvim-neotest/nvim-nio",
				"rcarriga/nvim-dap-ui",
				"theHamsta/nvim-dap-virtual-text",
			},
			config = function()
				local dap = require("dap")
				local dapui = require("dapui")
				local dap_python = require("dap-python")

				require("dapui").setup({})
				dap.configurations.dapui_breakpoints = {}
				require("nvim-dap-virtual-text").setup({
					commented = true, -- Show virtual text alongside comment
				})

				dap_python.setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")

				vim.fn.sign_define("DapBreakpoint", {
					text = "",
					texthl = "DiagnosticSignError",
					linehl = "",
					numhl = "",
				})

				vim.fn.sign_define("DapBreakpointRejected", {
					text = "", -- or "❌"
					texthl = "DiagnosticSignError",
					linehl = "",
					numhl = "",
				})

				vim.fn.sign_define("DapStopped", {
					text = "", -- or "→"
					texthl = "DiagnosticSignWarn",
					linehl = "Visual",
					numhl = "DiagnosticSignWarn",
				})

				-- Automatically open/close DAP UI
				dap.listeners.after.event_initialized["dapui_config"] = function()
					dapui.open()
				end

				local opts = { noremap = true, silent = true }

				-- Toggle breakpoint
				vim.keymap.set("n", "<leader>dpb", function()
					dap.toggle_breakpoint()
				end, opts)

				-- Continue / Start
				vim.keymap.set("n", "<leader>dpc", function()
					dap.continue()
				end, opts)

				-- Step Over
				vim.keymap.set("n", "<leader>dpo", function()
					dap.step_over()
				end, opts)

				-- Step Into
				vim.keymap.set("n", "<leader>dpi", function()
					dap.step_into()
				end, opts)

				-- Step Out

				-- Keymap to terminate debugging
				vim.keymap.set("n", "<leader>dpq", function()
					require("dap").terminate()
				end, opts)

				-- Toggle DAP UI
				vim.keymap.set("n", "<leader>dpu", function()
					dapui.toggle()
				end, opts)
			end,
		},
	},

	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		config = function(_, opts)
			local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(path)
		end,
	},
}
