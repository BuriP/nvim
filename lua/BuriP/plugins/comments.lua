return {
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim", "ibhagwan/fzf-lua" },
		opts = { signs = false },
		cmd = { "TodoFzfLua" },
		keys = {
			{ "<leader>std", "<cmd>TodoFzfLua<cr>", desc = "Todo (fzf-lua)" },
			{
				"<leader>sTd",
				"<cmd>TodoFzfLua keywords=TODO,FIX,FIXME,WARN,WARNING<cr>",
				desc = "Todo/Fix/Fixme (fzf-lua)",
			},
		},
	},
}
