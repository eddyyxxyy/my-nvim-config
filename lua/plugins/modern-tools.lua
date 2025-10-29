-- lua/plugins/modern-tools.lua
-- Plugins modernos para melhorar produtividade e experiência

return {
	-- Todo Comments: Destaca e gerencia TODOs, FIXMEs, etc
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("todo-comments").setup({
				signs = true,
				sign_priority = 8,
				keywords = {
					FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "CORRIGIR" } },
					TODO = { icon = " ", color = "info", alt = { "FAZER" } },
					HACK = { icon = " ", color = "warning" },
					WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX", "ATENÇÃO", "AVISO" } },
					PERF = { icon = " ", color = "default", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE", "OTIMIZAR" } },
					NOTE = { icon = " ", color = "hint", alt = { "INFO", "NOTA" } },
					TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED", "TESTE" } },
				},
				gui_style = {
					fg = "NONE",
					bg = "BOLD",
				},
				merge_keywords = true,
				highlight = {
					multiline = true,
					multiline_pattern = "^.",
					multiline_context = 10,
					before = "",
					keyword = "wide",
					after = "fg",
					pattern = [[.*<(KEYWORDS)\s*:]],
					comments_only = true,
					max_line_len = 400,
					exclude = {},
				},
				colors = {
					error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
					warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
					info = { "DiagnosticInfo", "#2563EB" },
					hint = { "DiagnosticHint", "#10B981" },
					default = { "Identifier", "#7C3AED" },
					test = { "Identifier", "#FF00FF" },
				},
				search = {
					command = "rg",
					args = {
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
					},
					pattern = [[\b(KEYWORDS):]],
				},
			})

			-- Keymaps
			vim.keymap.set("n", "]t", function()
				require("todo-comments").jump_next()
			end, { desc = "Próximo TODO" })
			vim.keymap.set("n", "[t", function()
				require("todo-comments").jump_prev()
			end, { desc = "TODO anterior" })
			vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Procurar TODOs" })
			vim.keymap.set("n", "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", { desc = "Procurar TODO/FIX" })
		end,
	},

	-- Trouble: Lista diagnósticos, referências, etc de forma elegante
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = { "Trouble", "TroubleToggle" },
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnósticos (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnósticos do Buffer (Trouble)" },
			{ "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Símbolos (Trouble)" },
			{ "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
		},
		opts = {
			modes = {
				preview_float = {
					mode = "diagnostics",
					preview = {
						type = "float",
						relative = "editor",
						border = "rounded",
						title = "Preview",
						title_pos = "center",
						position = { 0, -2 },
						size = { width = 0.3, height = 0.3 },
						zindex = 200,
					},
				},
			},
		},
	},

	-- Mini.nvim: Coleção de plugins minimalistas e rápidos
	-- Mini.pairs: Autopairs inteligente
	{
		"echasnovski/mini.pairs",
		version = false,
		event = "InsertEnter",
		config = function()
			require("mini.pairs").setup()
		end,
	},

	-- Mini.surround: Manipular pares (parênteses, aspas, tags, etc)
	{
		"echasnovski/mini.surround",
		version = false,
		keys = {
			{ "sa", mode = { "n", "v" }, desc = "Adicionar surround" },
			{ "sd", desc = "Deletar surround" },
			{ "sf", desc = "Encontrar surround (direita)" },
			{ "sF", desc = "Encontrar surround (esquerda)" },
			{ "sh", desc = "Destacar surround" },
			{ "sr", desc = "Substituir surround" },
			{ "sn", desc = "Atualizar MiniSurround.config.n_lines" },
		},
		config = function()
			require("mini.surround").setup({
				mappings = {
					add = "sa", -- Add surrounding in Normal and Visual modes
					delete = "sd", -- Delete surrounding
					find = "sf", -- Find surrounding (to the right)
					find_left = "sF", -- Find surrounding (to the left)
					highlight = "sh", -- Highlight surrounding
					replace = "sr", -- Replace surrounding
					update_n_lines = "sn", -- Update `n_lines`
				},
			})
		end,
	},

	-- Mini.ai: Text objects avançados (argumentos, parâmetros, etc)
	{
		"echasnovski/mini.ai",
		version = false,
		event = "VeryLazy",
		config = function()
			require("mini.ai").setup({
				n_lines = 500,
			})
		end,
	},

	-- Mini.bufremove: Remover buffers sem bagunçar layout
	{
		"echasnovski/mini.bufremove",
		version = false,
		keys = {
			{
				"<leader>q",
				function()
					require("mini.bufremove").delete(0, false)
				end,
				desc = "Fechar buffer atual",
			},
			{
				"<leader>bd",
				function()
					require("mini.bufremove").delete(0, false)
				end,
				desc = "Deletar buffer",
			},
			{
				"<leader>bD",
				function()
					require("mini.bufremove").delete(0, true)
				end,
				desc = "Deletar buffer (forçar)",
			},
		},
	},

	-- Mini.indentscope: Indicador visual de scope/indentação
	{
		"echasnovski/mini.indentscope",
		version = false,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("mini.indentscope").setup({
				symbol = "│",
				options = { try_as_border = true },
			})
		end,
	},

	-- Illuminate: Destaca palavras iguais sob o cursor
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("illuminate").configure({
				providers = {
					"lsp",
					"treesitter",
					"regex",
				},
				delay = 200,
				filetype_overrides = {},
				filetypes_denylist = {
					"dirbuf",
					"dirvish",
					"fugitive",
					"alpha",
					"neo-tree",
				},
				under_cursor = true,
				large_file_cutoff = 2000,
				large_file_overrides = nil,
				min_count_to_highlight = 1,
				case_insensitive_regex = false,
			})

			-- Keymaps para navegar entre referências destacadas
			-- Usando ]r e [r (r = reference) para evitar conflito com Treesitter ]] e [[
			vim.keymap.set("n", "]r", function()
				require("illuminate").goto_next_reference(false)
			end, { desc = "Próxima referência (illuminate)" })
			vim.keymap.set("n", "[r", function()
				require("illuminate").goto_prev_reference(false)
			end, { desc = "Referência anterior (illuminate)" })
		end,
	},

	-- Noice.nvim já está em plugins.lua, mas vamos garantir que está bem configurado

	-- Dressing: UI melhorada para vim.ui.select e vim.ui.input
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("dressing").setup({
				input = {
					enabled = true,
					default_prompt = "➤ ",
					win_options = {
						winblend = 0,
					},
				},
				select = {
					enabled = true,
					backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
					telescope = require("telescope.themes").get_dropdown(),
				},
			})
		end,
	},

	-- Better Escape: Sair do modo Insert de forma otimizada (Nova API)
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		opts = {
			-- Mapas para sair do Insert mode
			mappings = {
				i = {
					j = {
						k = "<Esc>",  -- jk → <Esc>
						j = "<Esc>",  -- jj → <Esc>
					},
				},
			},
			timeout = vim.o.timeoutlen, -- Tempo limite (ms)
			clear_empty_lines = false,  -- Não limpar linhas vazias
		},
	},

	-- Kulala: Cliente REST integrado (alternativa ao Postman)
	{
		"mistweaverco/kulala.nvim",
		ft = "http",
		keys = {
			{ "<leader>kr", "<cmd>lua require('kulala').run()<cr>", desc = "Executar requisição HTTP", ft = "http" },
			{ "<leader>kt", "<cmd>lua require('kulala').toggle_view()<cr>", desc = "Toggle view HTTP", ft = "http" },
			{ "<leader>ki", "<cmd>lua require('kulala').inspect()<cr>", desc = "Inspecionar requisição", ft = "http" },
		},
		opts = {},
	},
}

