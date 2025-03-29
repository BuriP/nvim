return {
	"sindrets/diffview.nvim",
	config = function()
		require("diffview").setup({
			use_icons = true,

			-- Configure default arguments for each command
			default_args = {
				-- Whenever you run `:DiffviewOpen` with no arguments, it will do:
				-- `:DiffviewOpen master..HEAD`
				DiffviewOpen = { "master...HEAD" },
			},

			-- Example hook (not mandatory). Valid hooks include: diff_buf_read, diff_buf_win_enter, view_opened, etc.
			hooks = {
				diff_buf_read = function(bufnr)
					-- (Optional) example of custom buffer settings for diff buffers
					vim.api.nvim_buf_set_option(bufnr, "buflisted", false)
				end,
			},

			-- Example layout settings (not mandatory)
			view = {
				merge_tool = {
					layout = "diff3_mixed", -- or "diff2_horizontal", etc.
				},
			},
		})
	end,
}
