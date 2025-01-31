return {
	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			{ "j-hui/fidget.nvim", opts = {} },
			-- used for completion, annotations and signatures of Neovim apis
			{ "folke/neodev.nvim", opts = {} },
			{ "saghen/blink.cmp", opts = {} },
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local buf = event.buf

					-- Jump to the definition of the word under your cursor
					vim.keymap.set("n", "gD", function()
						require("fzf-lua").lsp_definitions()
					end, { buffer = buf, desc = "LSP: [G]oto [D]efinition" })

					-- Find references for the word under your cursor
					vim.keymap.set("n", "gr", function()
						require("fzf-lua").lsp_references()
					end, { buffer = buf, desc = "LSP: [G]oto [R]eferences" })

					-- Jump to the implementation of the word under your cursor
					vim.keymap.set("n", "gI", function()
						require("fzf-lua").lsp_implementations()
					end, { buffer = buf, desc = "LSP: [G]oto [I]mplementation" })

					-- Jump to the type of the word under your cursor
					vim.keymap.set("n", "<leader>gtd", function()
						require("fzf-lua").lsp_typedefs()
					end, { buffer = buf, desc = "LSP: Type [D]efinition" })

					-- Fuzzy-find all symbols in the current document
					vim.keymap.set("n", "<leader>ds", function()
						require("fzf-lua").lsp_document_symbols()
					end, { buffer = buf, desc = "LSP: [D]ocument [S]ymbols" })

					-- Fuzzy-find all symbols in the current workspace
					vim.keymap.set("n", "<leader>ws", function()
						require("fzf-lua").lsp_live_workspace_symbols()
					end, { buffer = buf, desc = "LSP: [W]orkspace [S]ymbols" })

					-- Rename the variable under your cursor
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = buf, desc = "LSP: [R]e[n]ame" })

					-- Execute a code action
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {
						buffer = buf,
						desc = "LSP: [C]ode [A]ction",
					})

					-- Hover documentation
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buf, desc = "LSP: Hover Documentation" })

					-- Goto Declaration
					vim.keymap.set(
						"n",
						"gd",
						vim.lsp.buf.declaration,
						{ buffer = buf, desc = "LSP: [G]oto [D]eclaration" }
					)

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					-- vim.notify("Attached LSP: " .. client.name .. "\nConfig:\n" .. vim.inspect(client.config))

					if client and client.server_capabilities.documentHighlightProvider then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})
						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
						vim.keymap.set("n", "<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end)
					end
				end,
			})

			-- Get enhanced LSP capabilities from blink.cmp instead of cmp_nvim_lsp.
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			local servers = {
				clangd = {},
				gopls = {},
				basedpyright = {
					settings = {
						basedpyright = {
							analysis = {
								typeCheckingMode = "standard", -- or "off" if you want no type checking
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
							},
						},
					},
				},
				rust_analyzer = {},
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							diagnostics = { disable = { "missing-fields" } },
						},
					},
				},
			}

			require("mason").setup()

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, { "stylua", "black", "rust_analyzer" })
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
}
