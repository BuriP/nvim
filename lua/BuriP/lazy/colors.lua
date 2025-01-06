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

	{ -- You can easily change to a different colorscheme.
		-- Change the name of the colorscheme plugin below, and then
		-- change the command in the config to whatever the name of that colorscheme is.
		--
		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
		"folke/tokyonight.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			-- Load the colorscheme here.
			-- Like many other themes, this one has different styles, and you could load
			-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
			vim.cmd.colorscheme("gruvbox-material")

			-- You can configure highlights by doing something like:
			vim.cmd.highlight("Comment gui=none")
			vim.cmd.highlight("Normal  guibg=none")
			vim.cmd.highlight("Normal ctermbg=none")
			vim.cmd.highlight("NonText guibg=none")
			vim.cmd.highlight("NonText cterm=none")
		end,
	},
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "neanias/everforest-nvim", name = "everforest", version = false, lazy = false, priority = 1000 },
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ... },
	{ "rebelot/kanagawa.nvim", name = "kanagawa", priority = 1000 },
	{ "sainnhe/gruvbox-material", name = "gruvbox-material", priority = 1000 },
}
