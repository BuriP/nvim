return {
	"sindrets/diffview.nvim",
	config = function()
		require("diffview").setup({
			use_icons = true,

			default_args = {
				DiffviewOpen = { "master...HEAD" },
			},

			hooks = {
				diff_buf_read = function(bufnr)
					vim.api.nvim_buf_set_option(bufnr, "buflisted", false)
				end,
			},

			view = {
				merge_tool = {
					layout = "diff3_mixed",
				},
			},
		})
	end,
}
