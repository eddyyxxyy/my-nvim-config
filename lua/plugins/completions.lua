-- lua/plugins/completions.lua
-- Autocompletar inteligente com nvim-cmp e snippets

return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- Fonte LSP
			"hrsh7th/cmp-buffer", -- Fonte: texto do buffer
			"hrsh7th/cmp-path", -- Fonte: caminhos do sistema de arquivos
			-- LuaSnip: Engine de snippets com jsregexp para transformações LSP
			{
				"L3MON4D3/LuaSnip",
				build = "make install_jsregexp", -- Compila jsregexp automaticamente
				version = "v2.*",
			},
			"saadparwaiz1/cmp_luasnip", -- Integração LuaSnip
			"rafamadriz/friendly-snippets", -- Coleção de snippets
			"roobert/tailwindcss-colorizer-cmp.nvim", -- Cores Tailwind no completar
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			
			-- Carregar snippets do VS Code
			require("luasnip.loaders.from_vscode").lazy_load()
			
			-- Configurar colorização de Tailwind
			local format_kinds = require("tailwindcss-colorizer-cmp").formatter
			require("tailwindcss-colorizer-cmp").setup({})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = format_kinds,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(), -- Abrir completar
					["<C-e>"] = cmp.mapping.abort(), -- Fechar
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirmar seleção
					["<C-f>"] = cmp.mapping.scroll_docs(4), -- Scroll documentação para baixo
					["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Scroll documentação para cima
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				-- Fontes de completar (ordem de prioridade)
				sources = cmp.config.sources({
					{ name = "nvim_lsp", priority = 1000 }, -- LSP
					{ name = "luasnip", priority = 750 }, -- Snippets
					{ name = "buffer", priority = 500 }, -- Texto do buffer
					{ name = "path", priority = 250 }, -- Caminhos de arquivos
				}),
				-- Performance
				performance = {
					debounce = 60,
					throttle = 30,
					fetching_timeout = 500,
				},
			})
		end,
	},
}
