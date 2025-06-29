return {
	{
		"Vigemus/iron.nvim",
		cmd = {
			"IronRepl",
			"IronFocus",
			"IronHide",
			"IronRestart",
			"IronSend",
			"IronSendMotion",
			"IronSendVisual",
			"IronSendFile",
			"IronSendLine",
			"IronSendParagraph",
			"IronSendUntilCursor",
			"IronMarkMotion",
			"IronMarkVisual",
			"IronRemoveMark",
			"IronClear",
		},
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<space>rt", "<cmd>IronRepl<cr>", desc = "Toggle REPL window" },
			{ "<space>rr", "<cmd>IronRestart<cr>", desc = "Restart the REPL" },
			{ "<space>rf", "<cmd>IronFocus<cr>", desc = "Focus the REPL" },
			{ "<space>rh", "<cmd>IronHide<cr>", desc = "Hide the REPL" },

			{ "<space>rsm", "<cmd>IronSendMotion<cr>", desc = "Send motion to REPL" },
			{ "<space>rsv", "<cmd>IronSendVisual<cr>", mode = "v", desc = "Send visual selection to REPL" },
			{ "<space>rsf", "<cmd>IronSendFile<cr>", desc = "Send entire file to REPL" },
			{ "<space>rsl", "<cmd>IronSendLine<cr>", desc = "Send current line to REPL" },
			{ "<space>rsp", "<cmd>IronSendParagraph<cr>", desc = "Send paragraph to REPL" },
			{ "<space>rsc", "<cmd>IronSendUntilCursor<cr>", desc = "Send from start until cursor" },

			{ "<space>sm", "<cmd>IronMarkMotion<cr>", desc = "Mark motion for later" },
			{ "<space>mc", "<cmd>IronMarkVisual<cr>", mode = "v", desc = "Mark visual region" },
			{ "<space>md", "<cmd>IronRemoveMark<cr>", desc = "Remove existing mark" },

			{ "<space>rsb", "<cmd>IronSendCodeBlock<cr>", desc = "Send code block under cursor" },
			{ "<space>rsn", "<cmd>IronSendCodeBlockAndMove<cr>", desc = "Send code block and move on" },

			{ "<space>s<cr>", "<cmd>IronCR<cr>", desc = "Send carriage return" },
			{ "<space>s<space>", "<cmd>IronInterrupt<cr>", desc = "Interrupt the REPL" },
			{ "<space>rq", "<cmd>IronExit<cr>", desc = "Exit the REPL" },
			{ "<space>rcl", "<cmd>IronClear<cr>", desc = "Clear REPL buffer" },
		},
		config = function()
			local iron = require("iron.core")
			local view = require("iron.view")
			local common = require("iron.fts.common")

			iron.setup({
				config = {
					scratch_repl = true,
					repl_definition = {
						sh = {
							command = { "zsh" },
						},
						python = {
							command = { "python3" },
							format = common.bracketed_paste_python,
							block_dividers = { "# %%", "#%%" },
						},
					},
					repl_filetype = function(_, ft)
						return ft
					end,
					repl_open_cmd = view.bottom(40),
				},
				keymaps = nil, -- we're using 'keys' in lazy.nvim already
				highlight = {
					italic = true,
				},
				ignore_blank_lines = true,
			})
		end,
	},
}
