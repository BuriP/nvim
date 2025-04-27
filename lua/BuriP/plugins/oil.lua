return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			default_file_explorer = true, -- [NEW] automatically take over directories

			view_options = {
				show_hidden = true,
			},

			float = {
				padding = 2,
				max_width = 50,
				max_height = 20,
				border = "rounded",
				preview_split = "auto", -- [MOVED] must be inside float, not top-level
			},

			buf_options = {
				buflisted = false,
				bufhidden = "hide",
			},

			win_options = {
				wrap = false,
				signcolumn = "no",
				cursorcolumn = false,
				foldcolumn = "0",
				spell = false,
				list = false,
				conceallevel = 3,
				concealcursor = "nvic",
			},

			keymaps = {
				["g?"] = { "actions.show_help", mode = "n" },
				["<CR>"] = "actions.select",
				["<C-s>"] = { "actions.select", opts = { vertical = true } },
				["<C-h>"] = { "actions.select", opts = { horizontal = true } },
				["<C-t>"] = { "actions.select", opts = { tab = true } },
				["<C-p>"] = "actions.preview",
				["<C-c>"] = { "actions.close", mode = "n" },
				["<C-l>"] = "actions.refresh",
				["-"] = { "actions.parent", mode = "n" },
				["_"] = { "actions.open_cwd", mode = "n" },
				["`"] = { "actions.cd", mode = "n" },
				["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
				["gs"] = { "actions.change_sort", mode = "n" },
				["gx"] = "actions.open_external",
				["g."] = { "actions.toggle_hidden", mode = "n" },
				["g\\"] = { "actions.toggle_trash", mode = "n" },
			},

			use_default_keymaps = true, -- [NEW] being explicit is good practice

			lsp_file_methods = {
				enabled = true,
				timeout_ms = 1000,
				autosave_changes = false,
			},

			cleanup_delay_ms = 2000, -- [NEW] auto clean hidden oil buffers after 2s

			delete_to_trash = false, -- [OPTIONAL] set to true if you want to use trash instead of permanent delete
		})

		-- Open parent directory
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open Parent Directory" })

		-- Open parent directory in float
		vim.keymap.set("n", "<space>-", require("oil").toggle_float)
	end,
}
