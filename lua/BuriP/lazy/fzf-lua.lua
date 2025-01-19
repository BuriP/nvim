return {
	--extra comment
	"ibhagwan/fzf-lua",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font }, -- icons support
	},
	opts = function()
		require("fzf-lua").setup({
			winopts = {
				height = 0.80,
				width = 0.60,
				border = "rounded",
				backdrop = 0, -- 0 to 100
				preview = {
					layout = "flex",
					vertical = "up:45%", -- preview window below results
					hidden = "nohidden",
				},
			},
			-- Additional fzf CLI opts
			fzf_opts = {
				["--prompt"] = "❯ ",
				["--info"] = "inline",
				["--layout"] = "reverse", -- matches telescope’s default “descending” style
			},
			fzf_colors = true,
		})

		local fzf = require("fzf-lua")

		vim.keymap.set("n", "<leader>sh", function()
			fzf.help_tags()
		end, { desc = "[S]earch [H]elp (fzf-lua)" })

		vim.keymap.set("n", "<leader>sf", function()
			fzf.files()
		end, { desc = "[S]earch [F]iles (fzf-lua)" })

		vim.keymap.set("n", "<leader>svc", function()
			fzf.git_commits()
		end, { desc = "[S]earch [V]ersion [C]ommits" }) --git files

		vim.keymap.set("n", "<leader>svb", function()
			fzf.git_branches()
		end, { desc = "[S]earch [V]ersion [B]ranches" }) --git files

		vim.keymap.set("n", "<leader>ss", function()
			fzf.builtin()
		end, { desc = "[S]earch [S]elect fzf-lua" })

		vim.keymap.set("n", "<leader>su", function()
			fzf.spell_suggest()
		end, { desc = "[S]earch S[U]ggestions" })

		vim.keymap.set("n", "<leader>skm", function()
			fzf.keymaps()
		end, { desc = "[S]earch [K]ey[M]aps" })

		vim.keymap.set("n", "<leader>stg", function()
			fzf.tags()
		end, { desc = "[S]earch [T]a[g]s" })

		vim.keymap.set("n", "<leader>sw", function()
			fzf.grep_cword()
		end, { desc = "[S]earch current [W]ord (fzf-lua)" })

		vim.keymap.set("n", "<leader>sg", function()
			fzf.live_grep_glob()
		end, { desc = "[S]earch by [G]rep (fzf-lua)" })

		vim.keymap.set("n", "<leader>sdw", function()
			fzf.lsp_workspace_diagnostics()
		end, { desc = "[S]earch [D]iagnostics [W]orkspace (fzf-lua)" })

		vim.keymap.set("n", "<leader>sdd", function()
			fzf.diagnostics_document()
		end, { desc = "[S]earch [D]iagnostics [D]ocument (fzf-lua)" })

		vim.keymap.set("n", "<leader>sr", function()
			fzf.resume()
		end, { desc = "[S]earch [R]esume (fzf-lua)" })

		vim.keymap.set("n", "<leader>s.", function()
			fzf.oldfiles()
		end, { desc = '[S]earch Recent Files ("." for repeat) (fzf-lua)' })

		vim.keymap.set("n", "<leader><leader>", function()
			fzf.buffers()
		end, { desc = "[ ] Find existing buffers (fzf-lua)" })

		vim.keymap.set("n", "<leader>scs", function()
			fzf.colorschemes()
		end, { desc = "[S]earch [C]olor [S]cheme" })

		vim.keymap.set("n", "<leader>sch", function()
			fzf.changes()
		end, { desc = "[S]earch [C][h]anges" })

		vim.keymap.set("n", "<leader>sn", function()
			fzf.files({
				prompt = "Neovim Config❯ ",
				cwd = vim.fn.stdpath("config"),
			})
		end, { desc = "[S]earch [N]eovim files (fzf-lua)" })
	end,
}
