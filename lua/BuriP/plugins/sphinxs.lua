return {
	"stsewd/sphinx.nvim",

	build = ":UpdateRemotePlugins",

	ft = { "rst" }, -- reStructuredText
	-- If you mostly write docs inside a Sphinx project you can also trigger on a
	-- event = "BufReadPre",
	-- pattern = "*.rst",

	dependencies = {
		-- completion for :ref:, :doc:, etc.
		-- you only need one completion engine; pick yours ↓
		"hrsh7th/nvim-cmp", -- for nvim-cmp sources

		-- fuzzy–finder helpers
		"junegunn/fzf",
		"junegunn/fzf.vim", -- classic fzf

		-- syntax highlighting / injections
		{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	},

	-- 5.  Your custom config (keys, globals, etc.)
	config = function()
		-- Example globals — only set what you need.
		vim.g.sphinx_default_role = "any" -- default: 'any'
		vim.g.sphinx_include_intersphinx_data = 1 -- enable :ref: to external projects
		-- vim.g.sphinx_always_use_scoped_targets = 1     -- always prefix role target

		-- Keymaps for the fzf/telescope helpers (example)
		vim.keymap.set("n", "<leader>pf", ":SphinxFiles<CR>", { desc = "Sphinx files" })
		vim.keymap.set("n", "<leader>pr", ":SphinxRefs<CR>", { desc = "Sphinx refs" })
	end,
}
