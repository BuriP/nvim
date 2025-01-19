return {
	{
		"folke/trouble.nvim",
		config = function()
			-- 1. Prettier LSP Diagnostics (Neovim built-in)
			require("trouble").setup({
				-- Use your custom modes or just rely on existing built-ins
				modes = {
					test = {
						mode = "diagnostics",
						preview = {
							type = "split",
							relative = "win",
							position = "right",
							size = 0.4,
						},
					},
				},
				-- Make the Trouble diagnostics themselves “prettier”
				icons = true, -- use devicons for files
				fold_open = "", -- icon used for open folds
				fold_closed = "", -- icon used for closed folds
				signs = {
					error = "",
					warning = "",
					hint = "",
					information = "",
					other = "﫠",
				},
				use_diagnostic_signs = true, -- if set to true, Trouble uses the signs defined in LSP or above
				position = "bottom",
				height = 10,
			})

			-- 4. Keybindings with vim.keymap.set()

			-- Toggle Trouble entirely (your existing binding)
			vim.keymap.set("n", "<leader>tt", function()
				require("trouble").toggle()
			end, { desc = "Toggle Trouble" })

			-- Jump to next/previous diagnostic in Trouble (your existing bindings)
			vim.keymap.set("n", "[t", function()
				require("trouble").next({ skip_groups = true, jump = true })
			end, { desc = "Next trouble item" })

			vim.keymap.set("n", "]t", function()
				require("trouble").previous({ skip_groups = true, jump = true })
			end, { desc = "Previous trouble item" })

			-- Show/Toggle Workspace Diagnostics
			-- "diagnostics" mode in Trouble shows workspace diagnostics
			vim.keymap.set("n", "<leader>twd", function()
				require("trouble").toggle("diagnostics")
			end, { desc = "Toggle Workspace Diagnostics (Trouble)" })

			-- Show/Toggle Type Definitions (lsp_type_definitions)
			vim.keymap.set("n", "<leader>ttd", function()
				require("trouble").toggle("lsp_type_definitions")
			end, { desc = "Toggle Type Definitions (Trouble)" })
		end,
	},
}
