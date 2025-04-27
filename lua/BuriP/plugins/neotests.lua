return {
	"nvim-neotest/neotest",
	dependencies = {
		-- core deps
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/nvim-nio",

		"nvim-neotest/neotest-python", -- PyTest / unittest
		"nvim-neotest/neotest-go", -- go test
		"rouge8/neotest-rust", -- cargo-nextest
	},

	config = function()
		local neotest = require("neotest")

		neotest.setup({

			adapters = {
				require("neotest-python")({
					dap = { justMyCode = false },
					runner = "pytest", -- falls back automatically
					args = { "--log-level", "DEBUG" },
					-- python = ".venv/bin/python",
				}), -- :contentReference[oaicite:0]{index=0}

				require("neotest-go")({
					recursive_run = true, -- run ./... when root dir given
					args = { "-count=1" }, -- disable caching for CI-like runs
					-- experimental = { test_table = true },
				}), -- :contentReference[oaicite:1]{index=1}

				require("neotest-rust")({
					args = { "--no-capture" }, -- print stdout as tests run
					-- dap_adapter = "lldb",            -- or "codelldb" (default)
				}), -- :contentReference[oaicite:2]{index=2}
			},
		})

		local map = vim.keymap.set
		local opts = { noremap = true, silent = true }

		-- Run the test that’s under the cursor
		map("n", "<leader>tn", function()
			require("neotest").run.run()
		end, vim.tbl_extend("force", opts, { desc = "NeoTest: Run Nearest 🧪" }))

		-- Run all tests in the current file
		map("n", "<leader>tf", function()
			require("neotest").run.run(vim.fn.expand("%"))
		end, vim.tbl_extend("force", opts, { desc = "NeoTest: Run File" }))

		-- Toggle the side-panel test tree
		map(
			"n",
			"<leader>ts",
			require("neotest").summary.toggle,
			vim.tbl_extend("force", opts, { desc = "NeoTest: Toggle Summary" })
		)

		-- Open the rich output window for the last run
		map(
			"n",
			"<leader>to",
			require("neotest").output.open,
			vim.tbl_extend("force", opts, { desc = "NeoTest: Open Output" })
		)
	end,
}
