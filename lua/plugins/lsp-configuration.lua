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
				"ts_ls",
				"vue_ls",
				"cssls",
				"gopls",
				"intelephense",
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
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				if client.name == "tsserver" then
					client.server_capabilities.document_formatting = false
					client.server_capabilities.document_range_formatting = false
				end
			end

			local servers = { "lua_ls", "ts_ls", "vue_ls", "cssls", "gopls", "intelephense" }
			for _, server_name in ipairs(servers) do
				local server_config = {
					on_attach = on_attach,
					capabilities = capabilities,
				}

				if server_name == "ts_ls" then
					server_config.filetypes =
						{ "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" }
				end

				lspconfig[server_name].setup(server_config)
			end
		end,
	},
}
