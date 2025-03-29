return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	-- *event = {
	--	"BufReadPre ~/obsidian/**/*.md",
	--	"BufNewFile ~/obsidian/**/*.md",
	--},
	ft = "markdown",

	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"saghen/blink.cmp", -- example completion plugin
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("obsidian").setup({

			workspaces = {
				{
					name = "personal",
					path = vim.fn.expand("~/obsidian/personal"),
					overrides = {
						daily_notes = {
							folder = "Daily",
							template = "personal_day_template.md",
						},
					},
				},
				{
					name = "work",
					path = vim.fn.expand("~/obsidian/work"),
					overrides = {
						daily_notes = {
							folder = "Daily",
							template = "work_day_template.md",
						},
					},
				},
			},
			templates = {
				folder = "templates",
			},
			mappings = {
				-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
				["gf"] = {
					action = function()
						return require("obsidian").util.gf_passthrough()
					end,
					opts = { noremap = false, expr = true, buffer = true },
				},
				-- Toggle check-boxes.
				["<leader>ch"] = {
					action = function()
						return require("obsidian").util.toggle_checkbox()
					end,
					opts = { buffer = true },
				},
				-- Smart action depending on context, either follow link or toggle checkbox.
				["<cr>"] = {
					action = function()
						return require("obsidian").util.smart_action()
					end,
					opts = { buffer = true, expr = true },
				},
			},
		})
	end,
	keys = {
		{
			"<leader>obm",
			function()
				vim.cmd("ObsidianTomorrow")
			end,
			desc = "Open  Tomorrow daily note",
		},
		{
			"<leader>obh",
			function()
				vim.cmd("ObsidianToday")
			end,
			desc = "Open  Today daily note",
		},
		{
			"<leader>obw",
			function()
				vim.cmd("ObsidianWorkspace")
			end,
			desc = "Open workspaces",
		},
		{
			"<leader>sow",
			function()
				vim.cmd("ObsidianQuickSwitch")
			end,
			desc = "Search workspaces",
		},
		{
			"<leader>sog",
			function()
				vim.cmd("ObsidianSearch")
			end,
			desc = "Search Obsidian grep",
		},
	},
}
