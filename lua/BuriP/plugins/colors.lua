return {
	--RosePine here below
	{
		"rose-pine/neovim",
		lazy = false,
		priority = 1000,
		opts = {},
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_background = true,
				styles = {
					italic = false,
				},
			})
		end,
	},

	{
		"folke/tokyonight.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			vim.cmd.colorscheme("everforest")
		end,
	},
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "neanias/everforest-nvim", name = "everforest", version = false, lazy = false, priority = 1000 },
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ... },
	{ "rebelot/kanagawa.nvim", name = "kanagawa", priority = 1000 },
	{ "sainnhe/gruvbox-material", name = "gruvbox-material", priority = 1000 },
}
