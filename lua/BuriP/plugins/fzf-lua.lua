return {
	--extra comment
	"ibhagwan/fzf-lua",
	enabled = true,
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font }, -- icons support
	},
	config = function()
		require("fzf-lua").setup({
			winopts = {
				height = 0.75, -- window height
				width = 0.70, -- window width
				row = 0.35, -- window row position (0=top, 1=bottom)
				col = 0.50, -- window col position (0=left, 1=right)
				border = "rounded",
				title_pos = "center",
				backdrop = 70, -- 0 to 100
				preview = {
					layout = "flex",
					vertical = "up:45%", -- preview window below results
					horizontal = "right:40%", -- right|left:size
					hidden = "nohidden",
				},
			},
			-- Additional fzf CLI opts
			fzf_opts = {
				["--prompt"] = "Query: ❯ ",
				["--info"] = "inline",
				["--layout"] = "reverse", -- matches telescope’s default “descending” style
			},
			fzf_colors = true,
		})

		local fzf = require("fzf-lua")

		--GENERAL SEARCH--
		vim.keymap.set("n", "<leader>sg", function()
			fzf.live_grep({
				fzf_opts = {
					["--tiebreak"] = "begin,length", -- prefix/exact first; shorter wins tie
					-- ["--nth"]   = "1",             -- uncomment if you want matching to favor the symbol name
					-- ["--case"]  = "smart",
				},
			})
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
		vim.keymap.set("n", "<leader>sf", function()
			fzf.files()
		end, { desc = "[S]earch [F]iles (fzf-lua)" })

		vim.keymap.set("n", "<leader>sf", function()
			fzf.files()
		end, { desc = "[S]earch [F]iles (fzf-lua)" })

		--LSP SEARCH--
		vim.keymap.set("n", "<leader>sws", function()
			fzf.lsp_live_workspace_symbols({
				async_or_timeout = true,
			})
		end, { desc = "[S]earch [W]orkspace symbols (fzf-lua)" })

		local TYPES = { Class = true, Interface = true, Struct = true, Enum = true, TypeParameter = true }

		vim.keymap.set("n", "<leader>st", function()
			require("fzf-lua").lsp_live_workspace_symbols({
				prompt = "Types ❯ ",

				-- keep only type-like symbols
				regex_filter = function(item)
					return TYPES[item.kind]
				end,

				-- exact first, then everything else ordered by SHORTER length
				-- transform "Event" -> "^Event$|Event" (exact OR general)
				fzf_opts = {
					["--bind"] = "change:transform-query:printf '^%%s$|%%s' {q} {q}",
					["--tiebreak"] = "length,index", -- shorter first; keep stable order after
					["--nth"] = "2..", -- match on the symbol name column only
				},
			})
		end, { desc = "[S]earch [T]ypes (workspace)" })

		vim.keymap.set("n", "<leader>ca", function()
			fzf.lsp_code_actions()
		end, { desc = "[C]ode [A]ctions" })

		vim.keymap.set("n", "<leader>stag", function()
			fzf.tags_live_grep()
		end, { desc = "[S]earch [T]ags" })

		vim.keymap.set("n", "gr", function()
			fzf.lsp_references()
		end, { desc = "[G]rep [R]eferences" })

		vim.keymap.set("n", "gd", function()
			fzf.lsp_definitions()
		end, { desc = "[G]rep [D]efinition" })

		vim.keymap.set("n", "gde", function()
			fzf.lsp_declarations()
		end, { desc = "[G]rep [D][E]clarations" })

		vim.keymap.set("n", "<leader>go", function()
			fzf.global()
		end, { desc = "[S]earch [G]lobal" })

		--GIT--

		vim.keymap.set("n", "<leader>gbl", function()
			fzf.git_blame()
		end, { desc = "[G]earch [B][L]ame " }) --git files

		vim.keymap.set("n", "<leader>gdf", function()
			fzf.git_diff()
		end, { desc = "[G]earch [D]iff" }) --git files

		vim.keymap.set("n", "<leader>svc", function()
			fzf.git_commits()
		end, { desc = "[S]earch [V]ersion [C]ommits" }) --git files

		vim.keymap.set("n", "<leader>svb", function()
			fzf.git_branches()
		end, { desc = "[S]earch [V]ersion [B]ranches" }) --git files

		--BUFFER--
		vim.keymap.set("n", "<leader>sw", function()
			fzf.grep_cword()
		end, { desc = "[S]earch current [W]ord (fzf-lua)" })

		vim.keymap.set("n", "<leader><leader>", function()
			fzf.buffers()
		end, { desc = "[ ] Find existing buffers (fzf-lua)" })

		--COLORS--
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

		--TMUX--
		vim.keymap.set("n", "<leader>stm", function()
			fzf.tmux_buffers()
		end, { desc = "[S]earch [T]mux buffers (fzf-lua)" })

		--MISC--
		vim.keymap.set("n", "<leader>shi", function()
			fzf.search_history()
		end, { desc = "[S]earch [H][I]story  (fzf-lua)" })

		vim.keymap.set("n", "<leader>shi", function()
			fzf.search_history()
		end, { desc = "[S]earch [H][I]story  (fzf-lua)" })

		vim.keymap.set("n", "<leader>scb", function()
			fzf.combine()
		end, { desc = "[S]earch [C]om[B]ine  (fzf-lua)" })

		vim.keymap.set("n", "<leader>sll", function()
			fzf.spellcheck()
		end, { desc = "[S]pell [C]heck  (fzf-lua)" })

		vim.keymap.set("n", "<leader>sh", function()
			fzf.help_tags()
		end, { desc = "[S]earch [H]elp (fzf-lua)" })
		vim.keymap.set("n", "<leader>ss", function()
			fzf.builtin()
		end, { desc = "[S]earch [B]uiltin fzf-lua" })

		vim.keymap.set("n", "<leader>su", function()
			fzf.spell_suggest()
		end, { desc = "[S]earch S[U]ggestions" })

		vim.keymap.set("n", "<leader>sk", function()
			fzf.keymaps()
		end, { desc = "[S]earch [K]ey[M]aps" })

		vim.keymap.set("n", "<leader>stg", function()
			fzf.tags()
		end, { desc = "[S]earch [T]a[g]s" })

		vim.keymap.set("n", "<leader>sch", function()
			fzf.changes()
		end, { desc = "[S]earch [C][H]anges" })

		vim.keymap.set("n", "<leader>sh", function()
			fzf.help_tags()
		end, { desc = "[S]earch [H]elp tags" })

		vim.keymap.set("n", "<leader>sman", function()
			fzf.manpages()
		end, { desc = "[S]earch [MAN]" })

		vim.keymap.set("n", "<leader>sco", function()
			fzf.commands()
		end, { desc = "[S]earch [C][O]mmands" })

		vim.keymap.set("n", "<leader>sau", function()
			fzf.commands()
		end, { desc = "[S]earch [A][U]tocmds" })
	end,
}
