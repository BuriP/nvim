return {
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				-- List of parser names
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

				-- Autoinstall languages that are not installed
				auto_install = true,

				highlight = {
					enable = true,
					additional_vim_regex_highlighting = { "ruby" },
				},

				indent = { enable = true, disable = { "ruby", "markdown" } },
			})

			-- Register custom language 'templ'
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.templ = {
				install_info = {
					url = "https://github.com/vrischmann/tree-sitter-templ.git",
					files = { "src/parser.c", "src/scanner.c" },
					branch = "master",
				},
				filetype = "templ",
			}

			vim.treesitter.language.register("templ", "templ")
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
	{
		"RRethy/nvim-treesitter-textsubjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter-textsubjects").configure({

				prev_selection = ",",
				keysmaps = {
					["<leader>to"] = "textsubjects-smart",
					["<leader>too"] = "textsubjects-container-outer",
					["i;"] = "textsubjects-container-inner",
				},
			})
		end,
	},
}
