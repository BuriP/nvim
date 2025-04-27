return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
	},
	cmd = {
		"DBUI",
		"DBUIOpen",
		"DBUIClose",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	keys = {
		{ "<leader>dbt", "<cmd>DBUIToggle<CR>", desc = "Toggle Dadbod UI" },
		{ "<leader>dbc", "<cmd>DBUIClose<CR>", desc = "Close Dadbod UI" },
		{ "<leader>dbo", "<cmd>DBUIOpen<CR>", desc = "Open Dadbod UI" },
	},
	init = function()
		vim.g.db_ui_use_nerd_fonts = 1
	end,
}
