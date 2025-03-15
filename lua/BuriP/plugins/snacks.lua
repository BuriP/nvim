return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			animate = {
				easing = "linear",
				fps = 60,
			},
			bigfile = { enabled = true },
			dashboard = {
				sections = {
					{
						header = [[
███████████                        ███  ███████████ 
░░███░░░░░███                      ░░░  ░░███░░░░░███
 ░███    ░███ █████ ████ ████████  ████  ░███    ░███
 ░██████████ ░░███ ░███ ░░███░░███░░███  ░██████████ 
 ░███░░░░░███ ░███ ░███  ░███ ░░░  ░███  ░███░░░░░░  
 ░███    ░███ ░███ ░███  ░███      ░███  ░███        
 ███████████  ░░████████ █████     █████ █████       
░░░░░░░░░░░    ░░░░░░░░ ░░░░░     ░░░░░ ░░░░░        
                                                     
                                                     
						]],
					},
					{
						pane = 2,
						section = "terminal",
						cmd = "chafa ~/wallpapers/bar_coffee.jpeg --format symbols --symbols all ; sleep .1",
						height = 20,
						padding = 1,
					},
					{
						pane = 2,
						icon = " ",
						title = "Git Status",
						section = "terminal",
						enabled = function()
							return Snacks.git.get_root() ~= nil
						end,
						cmd = "git status --short --branch --renames",
						height = 5,
						padding = 1,
						ttl = 5 * 60,
						indent = 3,
					},
					{
						{ section = "keys", gap = 1, padding = 1 },
						{ section = "startup" },
					},
				},
			},
			indent = { enabled = true },
			image = { enabled = true },
			input = { enabled = true },
			lazygit = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scroll = {
				enabled = true,
				animate = {
					easing = "linear",
				},
			},
			scope = {
				enabled = true,
				tresitter = {
					enabled = true,
					blocks = { enabled = true },
				},
			},
			scratch = { enabled = true },
			statuscolumn = { enabled = true },
			terminal = { enabled = true },
			words = {
				enabled = false,
				modes = { "n" },
			},
			picker = {
				matcher = {
					fuzzy = true,
					filename_bonus = true,
					file_pos = true,
					smartcase = true,
					ignorecase = false,
					frecency = true,
					history_bonus = true,
				},
				sort = {
					-- default sort is by score, text length and index
					fields = { "score:desc", "#text", "idx" },
				},
				layout = "dropdown",
			},
		},
		keys = {
			{
				"<leader>ssu",
				function()
					Snacks.picker.spelling()
				end,
				desc = "Search Spelling Suggestions",
			},
			{
				"<leader>te",
				function()
					Snacks.terminal()
				end,
				desc = "Toggle Terminal",
			},
			{
				"<leader>scr",
				function()
					Snacks.scratch()
				end,
				desc = "Toggle Scratch Buffer",
			},
			{
				"<leader>ssc",
				function()
					Snacks.scratch.select()
				end,
				desc = "Search Scratch Buffer",
			},
			{
				"<leader>lg",
				function()
					Snacks.lazygit()
				end,
				desc = "Lazygit",
			},
			{
				"<leader>nod",
				function()
					Snacks.notifier.hide()
				end,
				desc = "Dismiss All Notifications",
			},
			-- Top Pickers & Explorer
			{
				"<leader>sf",
				function()
					Snacks.picker.smart()
				end,
				desc = "[S]earch [F]iles Smart",
			},
			{
				"<leader><leader>",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>sch",
				function()
					Snacks.picker.command_history()
				end,
				desc = "[S]earch [C]ommand [H]istory",
			},
			{
				"<leader>no",
				function()
					Snacks.picker.notifications()
				end,
				desc = "Notification History",
			},
			{
				"<leader>sex",
				function()
					Snacks.explorer()
				end,
				desc = "File Explorer",
			},
			-- find
			{
				"<leader>sbu",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>sn",
				function()
					Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
				end,
				desc = "Find Config File",
			},
			{
				"<leader>ff",
				function()
					Snacks.picker.files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>spr",
				function()
					Snacks.picker.projects()
				end,
				desc = "Projects",
			},
			{
				"<leader>sr",
				function()
					Snacks.picker.recent()
				end,
				desc = "[S]earch [R]ecent",
			},
			-- git
			{
				"<leader>gbr",
				function()
					Snacks.picker.git_branches({
						all = true,
					})
				end,
				desc = "[G]it [B][R]anches",
			},
			{
				"<leader>gl",
				function()
					Snacks.picker.git_log()
				end,
				desc = "Git Log",
			},
			{
				"<leader>gL",
				function()
					Snacks.picker.git_log_line()
				end,
				desc = "Git Log Line",
			},
			{
				"<leader>gtu",
				function()
					Snacks.picker.git_status()
				end,
				desc = "[G]it [S][T]atus",
			},
			{
				"<leader>gdf",
				function()
					Snacks.picker.git_diff()
				end,
				desc = "Git Diff (Hunks)",
			},
			{
				"<leader>gf",
				function()
					Snacks.picker.git_log_file()
				end,
				desc = "Git Log File",
			},
			-- Grep
			{
				"<leader>sb",
				function()
					Snacks.picker.lines()
				end,
				desc = "Buffer Lines",
			},
			{
				"<leader>sB",
				function()
					Snacks.picker.grep_buffers()
				end,
				desc = "Grep Open Buffers",
			},
			{
				"<leader>sg",
				function()
					Snacks.picker.grep()
				end,
				desc = "Grep",
			},
			{
				"<leader>sw",
				function()
					Snacks.picker.grep_word()
				end,
				desc = "Visual selection or word",
				mode = { "n", "x" },
			},
			-- search
			{
				'<leader>s"',
				function()
					Snacks.picker.registers()
				end,
				desc = "Registers",
			},
			{
				"<leader>s/",
				function()
					Snacks.picker.search_history()
				end,
				desc = "Search History",
			},
			{
				"<leader>sli",
				function()
					Snacks.picker.lines()
				end,
				desc = "Buffer Lines",
			},
			{
				"<leader>sdi",
				function()
					Snacks.picker.diagnostics()
				end,
				desc = "Diagnostics",
			},
			{
				"<leader>sDb",
				function()
					Snacks.picker.diagnostics_buffer()
				end,
				desc = "Buffer Diagnostics",
			},
			{
				"<leader>sh",
				function()
					Snacks.picker.help()
				end,
				desc = "Help Pages",
			},
			{
				"<leader>sH",
				function()
					Snacks.picker.highlights()
				end,
				desc = "Highlights",
			},
			{
				"<leader>si",
				function()
					Snacks.picker.icons()
				end,
				desc = "Icons",
			},
			{
				"<leader>sj",
				function()
					Snacks.picker.jumps()
				end,
				desc = "Jumps",
			},
			{
				"<leader>sk",
				function()
					Snacks.picker.keymaps()
				end,
				desc = "Keymaps",
			},
			{
				"<leader>sll",
				function()
					Snacks.picker.loclist()
				end,
				desc = "Location List",
			},
			{
				"<leader>sM",
				function()
					Snacks.picker.marks()
				end,
				desc = "Marks",
			},
			{
				"<leader>sm",
				function()
					Snacks.picker.man()
				end,
				desc = "Man Pages",
			},
			{
				"<leader>sp",
				function()
					Snacks.picker.lazy()
				end,
				desc = "Search for Plugin Spec",
			},
			{
				"<leader>sq",
				function()
					Snacks.picker.qflist()
				end,
				desc = "Quickfix List",
			},
			{
				"<leader>sr",
				function()
					Snacks.picker.resume()
				end,
				desc = "Resume",
			},
			{
				"<leader>su",
				function()
					Snacks.picker.undo()
				end,
				desc = " Search Undo History",
			},
			{
				"<leader>scs",
				function()
					Snacks.picker.colorschemes({
						confirm = function(picker, item)
							picker:close()
							if item then
								picker.preview.state.colorscheme = vim.cmd("colorscheme " .. item.text)
								vim.cmd("colorscheme " .. item.text)
							end
						end,
					})
				end,
				desc = "Search Colorschemes",
			},
			-- LSP
			{
				"<leader>sts",
				function()
					Snacks.picker.lsp_workspace_symbols({
						filter = { default = { "Class", "Enum", "Struct", "Trait" } },
					})
				end,
				desc = "Search Type Symbols",
			},
			{
				"gd",
				function()
					Snacks.picker.lsp_definitions()
				end,
				desc = "Goto Definition",
			},
			{
				"gD",
				function()
					Snacks.picker.lsp_declarations()
				end,
				desc = "Goto Declaration",
			},
			{
				"gr",
				function()
					Snacks.picker.lsp_references()
				end,
				nowait = true,
				desc = "References",
			},
			{
				"gI",
				function()
					Snacks.picker.lsp_implementations()
				end,
				desc = "Goto Implementation",
			},
			{
				"gy",
				function()
					Snacks.picker.lsp_type_definitions()
				end,
				desc = "Goto T[y]pe Definition",
			},
			{
				"<leader>sds",
				function()
					Snacks.picker.lsp_symbols()
				end,
				desc = "LSP Symbols",
			},
			{
				"<leader>sws",
				function()
					Snacks.picker.lsp_workspace_symbols()
				end,
				desc = "LSP Workspace Symbols",
			},
		},
	},
}
