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
			indent = { enabled = true },
			input = { enabled = true },
			lazygit = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scroll = {
				enabled = true,
				animate = {
					easing = "linear",
				},
			},
			scope = {
				enabled = true,
				tresitter = {
					enabled = true,
					blocks = { enabled = true },
				},
				-- Optionally, define a filter if required:
				-- filter = function(scope) return scope end,
			},
			scratch = { enabled = true },
			statuscolumn = { enabled = true },
			terminal = { enabled = true },
			words = {
				enabled = true,
				modes = { "n" },
			},
		},
		keys = { -- Terminal Toggle and others
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
