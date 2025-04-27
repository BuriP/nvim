return {
	"obsidian-nvim/obsidian.nvim",
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
		"folke/snacks.nvim",
		"OXY2DEV/markview.nvim",
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

			-- [NEW] Add default daily_notes settings
			daily_notes = {
				folder = "Daily",
				date_format = "%Y-%m-%d",
				alias_format = "%B %-d, %Y",
				default_tags = { "daily-notes" },
				template = nil, -- you override templates per workspace, so it's fine to leave nil globally
			},

			templates = {
				folder = "templates",
			},

			-- [UPDATED] completion to explicitly disable nvim_cmp
			completion = {
				nvim_cmp = false,
				blink = true,
			},

			picker = {
				name = "snacks.pick",
			},

			mappings = {
				["gf"] = {
					action = function()
						return require("obsidian").util.gf_passthrough()
					end,
					opts = { noremap = false, expr = true, buffer = true },
				},
				["<leader>ch"] = {
					action = function()
						return require("obsidian").util.toggle_checkbox()
					end,
					opts = { buffer = true },
				},
				["<cr>"] = {
					action = function()
						return require("obsidian").util.smart_action()
					end,
					opts = { buffer = true, expr = true },
				},
			},

			-- [NEW] Sort results like recommended
			sort_by = "modified",
			sort_reversed = true,

			-- [NEW] Open notes in current window
			open_notes_in = "current",

			-- [NEW] Note ID format (timestamp-title)
			note_id_func = function(title)
				local suffix = ""
				if title ~= nil then
					suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
				else
					for _ = 1, 4 do
						suffix = suffix .. string.char(math.random(65, 90))
					end
				end
				return tostring(os.time()) .. "-" .. suffix
			end,

			-- [NEW] Attachments configuration
			attachments = {
				img_folder = "assets/imgs",
				img_name_func = function()
					return string.format("%s-", os.time())
				end,
			},

			-- [NEW] UI enhancements (checkbox icons, bullet points)
			ui = {
				enable = true,
				update_debounce = 200,
				max_file_length = 5000,
				checkboxes = {
					[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
					["x"] = { char = "", hl_group = "ObsidianDone" },
				},
				bullets = { char = "•", hl_group = "ObsidianBullet" },
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
			desc = "Search  obsidian workspaces",
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
