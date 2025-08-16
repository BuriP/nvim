return {
	{
		"neovim/nvim-lspconfig",

		dependencies = {
			{
				"mason-org/mason.nvim",
				build = ":MasonUpdate",
				config = true,
			},

			{
				"mason-org/mason-lspconfig.nvim",
				opts = {
					ensure_installed = {
						"clangd",
						"ruff",
						"gopls",
						"basedpyright",
						"rust_analyzer",
						"lua_ls",
					},
					automatic_enable = true,
				},
			},

			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			{ "folke/neodev.nvim", opts = {} },
			{ "saghen/blink.cmp", opts = {} },
			{ "folke/lazydev.nvim" },
		},

		config = function()
			local function on_attach(client, buf)
				local function map(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
				end

				map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename")
				map("n", "<leader>ca", vim.lsp.buf.code_action, "LSP: Code Action")
				map("n", "K", vim.lsp.buf.hover, "LSP: Hover")

				vim.diagnostic.config({ virtual_text = false, virtual_lines = { current_line = true } })

				if client.server_capabilities.documentHighlightProvider then
					local hl = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = buf,
						group = hl,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = buf,
						group = hl,
						callback = vim.lsp.buf.clear_references,
					})
					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(ev)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = ev.buf })
						end,
					})
				end

				if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
					map("n", "<leader>th", function()
						local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = buf })
						vim.lsp.inlay_hint.enable(buf, not enabled)
					end, "Toggle Inlay Hints")
				end
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(ev)
					on_attach(vim.lsp.get_client_by_id(ev.data.client_id), ev.buf)
				end,
			})

			local capabilities = require("blink.cmp").get_lsp_capabilities()
			vim.lsp.completion.enable(false)

			local servers = {
				clangd = {},
				gopls = {},
				basedpyright = {
					root_markers = {
						".git",
						"setup.py",
						"setup.cfg",
						"Pipfile",
						"pyrightconfig.json",
					},
					settings = {
						basedpyright = {
							analysis = {
								typeCheckingMode = "standard", -- or "off" if you want no type checking
								reportNoOverloadImplementation = "hint",
								reportOptionalIterable = "hint",
								reportOptionalCall = "hint",
								reportDeprecated = "warning",
								reportUnknownParameterType = "warning",
								reportUnknownArgumentType = "warning",
								reportMissingTypeArgument = "warning",
								reportmissingParameterType = "warning",
								reportAssertAlwaysTrue = "warning",
								reportIncompleteStub = "hint",
								reportAny = "warning",
								reportUnsafeMultipleInheritance = "warning",
								reportUnusedParameter = "hint",
								deprecateTypingAliases = "hint",
								reportMissingTypeStubs = "hint",
								logLevel = "Information",
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								stubPath = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "python-type-stubs"),
							},
						},
					},
				},
				rust_analyzer = {},
				lua_ls = {
					settings = {
						Lua = {
							completion = { callSnippet = "Replace" },
							diagnostics = { disable = { "missing-fields" } },
						},
					},
				},
			}

			local ensure = vim.tbl_keys(servers)
			vim.list_extend(ensure, { "stylua", "ruff", "rust_analyzer", "basedpyright" })

			require("mason-tool-installer").setup({ ensure_installed = ensure })

			for name, cfg in pairs(servers) do
				vim.lsp.config(
					name,
					vim.tbl_deep_extend("force", cfg, {
						on_attach = on_attach,
						capabilities = capabilities,
					})
				)
			end
		end,
	},
}
