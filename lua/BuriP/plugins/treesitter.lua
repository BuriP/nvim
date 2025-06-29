return {
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({
				ensure_installed = {
					"vimdoc",
					"javascript",
					"lua",
					"rust",
					"go",
					"jsdoc",
					"python",
					"zig",
				},
				sync_install = false,

				auto_install = true,

				highlight = {
					enable = true,
					additional_vim_regex_highlighting = { "ruby" },
				},

				indent = { enable = true, disable = { "ruby", "markdown" } },
			})
		end,
	},

	-- This is for TressiterContext
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("treesitter-context").setup({
				enable = true,
			})
		end,
	},
}
