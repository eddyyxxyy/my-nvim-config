return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			ensure_installed = {
				"lua_ls",
				"vtsls",      -- TypeScript/JavaScript (VTSLS) + Vue (via @vue/typescript-plugin)
				"cssls",
				"gopls",
				"intelephense",
				"pyright",
				"eslint",
				"tailwindcss",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			local on_attach = function(client, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("keep", { desc = "LSP Hover" }, opts))
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("keep", { desc = "LSP Go to Definition" }, opts))
				vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, vim.tbl_extend("keep", { desc = "LSP References" }, opts))
				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("keep", { desc = "Code Action" }, opts))
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("keep", { desc = "Rename Symbol" }, opts))

				-- Avoid formatting conflicts: use external formatter instead of TS servers
				if client.name == "tsserver" or client.name == "vtsls" then
					if client.server_capabilities then
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentRangeFormattingProvider = false
					end
				end

				-- Auto apply ESLint fixAll on save when eslint LSP is attached
				if client.name == "eslint" then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							local params = vim.lsp.util.make_range_params()
							params.context = { only = { "source.fixAll.eslint" } }
							local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 500)
							for _, res in pairs(result or {}) do
								for _, action in pairs(res.result or {}) do
									if action.edit or type(action.command) == "table" then
										vim.lsp.buf.execute_command(action.command)
									else
										vim.lsp.buf.code_action({ context = { only = { "source.fixAll.eslint" } }, apply = true })
									end
								end
							end
						end,
					})
				end
			end

			local servers = { "lua_ls", "vtsls", "cssls", "gopls", "intelephense", "pyright", "eslint", "tailwindcss" }

			if vim.lsp and vim.lsp.enable and vim.lsp.config then
				-- Neovim 0.11+ API (no lspconfig deprecation)
				vim.lsp.config('*', {
					on_attach = on_attach,
					capabilities = capabilities,
				})

				vim.lsp.config('vtsls', {
					filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" },
					settings = {
						typescript = {
							tsserver = {
								-- Para Vue, use o plugin oficial @vue/typescript-plugin se presente no projeto
								-- Adicione em devDependencies e no tsconfig (veja README)
								-- globalPlugins pode ser configurado aqui se necessário
							},
						},
					},
				})

				vim.lsp.config('tailwindcss', {
					filetypes = { "astro", "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte", "css" },
					settings = {
						tailwindCSS = {
							experimental = {
								classRegex = {
									"tw`([^`]*)`",
									"tw\\.[^`]+`([^`]*)`",
									"class=\"([^\"]*)\"",
									"className=\"([^\"]*)\"",
								},
							},
						},
					},
				})

				for _, name in ipairs(servers) do
					vim.lsp.enable(name)
				end
			else
				-- Fallback para versões antigas usando lspconfig
				local lspconfig = require("lspconfig")
				for _, server_name in ipairs(servers) do
					local server_config = {
						on_attach = on_attach,
						capabilities = capabilities,
					}

					if server_name == "vtsls" then
						server_config.filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" }
					end

					if server_name == "tailwindcss" then
						local util = require("lspconfig").util
						server_config.filetypes = { "astro", "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte", "css" }
						server_config.root_dir = util.root_pattern(
							"tailwind.config.js",
							"tailwind.config.cjs",
							"tailwind.config.ts",
							"postcss.config.js",
							"postcss.config.cjs",
							"postcss.config.ts"
						)
						server_config.settings = {
							tailwindCSS = {
								experimental = {
									classRegex = { "tw`([^`]*)`", "tw\\.[^`]+`([^`]*)`", "class=\"([^\"]*)\"", "className=\"([^\"]*)\"" },
								},
							},
						}
					end

					lspconfig[server_name].setup(server_config)
				end
			end
		end,
	},
}
