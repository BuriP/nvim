return {
	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim", "folke/snacks.nvim" },
		opts = { signs = false },
		keys = {
			{
				"<leader>std",
				function()
					Snacks.picker.todo_comments()
				end,
				desc = "Todo",
			},
			{
				"<leader>sTd",
				function()
					Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME", "WARN", "WARNING" } })
				end,
				desc = "Todo/Fix/Fixme",
			},
		},
	},
}
