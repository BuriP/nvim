return {
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets", "L3MON4D3/LuaSnip" },

		version = "*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "default" },
			snippets = { preset = "luasnip" },

			appearance = {
				-- Sets the fallback highlight groups to nvim-cmp's highlight groups
				-- Useful for when your theme doesn't support blink.cmp
				-- Will be removed in a future release
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono",
			},
			completion = {
				-- 'prefix' will fuzzy match on the text before the cursor
				-- 'full' will fuzzy match on the text before _and_ after the cursor
				keyword = { range = "full" },

				-- NOTE: some LSPs may add auto brackets themselves anyway
				accept = { auto_brackets = { enabled = true } },

				-- Don't select by default, auto insert on selection
				list = { selection = { preselect = false, auto_insert = false } },
				-- or set either per mode via a function

				menu = {
					-- Don't automatically show the completion menu
					auto_show = true,

					border = "rounded",
					-- nvim-cmp style menu
					draw = {

						treesitter = { "lsp" },
						columns = {
							{ "kind_icon", "kind" },
							{ "label", gap = 1 },
							{ "source_name" },
						},
						components = {
							label = {
								text = function(ctx)
									return require("colorful-menu").blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
							kind_icon = {
								text = function(ctx)
									local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
									return kind_icon
								end,
								-- (optional) use highlights from mini.icons
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
							kind = {
								-- (optional) use highlights from mini.icons
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
						},
					},
				},

				-- Show documentation when selecting a completion item
				documentation = { auto_show = true, auto_show_delay_ms = 500 },

				-- Display a preview of the selected item on the current line
				ghost_text = {
					enabled = true,
					show_without_selection = true,
					show_with_selection = true,
					show_with_menu = false,
				},
			},
			fuzzy = {
				implementation = "rust",
				frecency = {
					enabled = true,
				},
				use_proximity = true,
				sorts = { "score", "sort_text", "label", "kind" },
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				per_filetype = {
					sql = { "dadbod", "snippets", "buffer" },
					mysql = { "dadbod", "snippets", "buffer" },
				},
				providers = {
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
					-- completions to be relative to your current working directory rather than the default
					path = {
						opts = {
							get_cwd = function(_)
								return vim.fn.getcwd()
							end,
						},
					},
				},
			},
			signature = { enabled = true },
			cmdline = {
				completion = {
					menu = {
						auto_show = true,
					},
				},
			},
			term = {
				enabled = true,
				keymap = { preset = "inherit" }, -- Inherits from top level `keymap` config when not set
				completion = {
					menu = { auto_show = true },
					-- Displays a preview of the selected item on the current line
					ghost_text = { enabled = true },
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
