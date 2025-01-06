return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			animate = { enabled = true },
			bigfile = { enabled = false },
			dashboard = { enabled = true },
			indent = { enabled = false },
			input = { enabled = true },
			lazygit = { enable = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scroll = {
				{
					enabled = true,
					animate = {
						easing = "linear",
					},
				},
			},
			scope = {
				{
					enabled = true,
					tresitter = {
						enabled = true,
						blocks = { enabled = true },
					},
				},
			},
			scratch = { enabled = true },
			statuscolumn = { enabled = true },
			terminal = { enabled = true },
			words = { { enabled = true, notify_jump = true, modes = { "n" } } },
		},
		keys = { -- Terminal Toggle
			{
				"<leader>te",
				function()
					Snacks.terminal()
				end,
				desc = "Toggle Terminal",
			},
			{
				"<leader>scr",
				function()
					Snacks.scratch()
				end,
				desc = "Toggle Scratch Buffer",
			},
			{
				"<leader>lg",
				function()
					Snacks.lazygit()
				end,
				desc = "Lazygit",
			},
			{
				"<leader>dno",
				function()
					Snacks.notifier.hide()
				end,
				desc = "Dismiss All Notifications",
			},
		},
	},
}
