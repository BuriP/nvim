return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			view_options = {
				show_hidden = true,
			},
			float = {
				padding = 2,
				max_width = 50,
				max_height = 20,
				border = "rounded",
			},
			preview_split = "auto",
		})

		-- Opening a perent directory
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = " Open Parent Directory" })

		-- Open a parent direcory in floating win
		vim.keymap.set("n", "<space>-", require("oil").toggle_float)
	end,
}
