--[[
  plugins.lua
  Plugins principais: formatação, notificações, statusline, which-key, DAP, etc.
  Plugins modulares estão organizados em lua/plugins/*.lua
--]]

return {
	-- ========================================================================
	-- FORMATAÇÃO DE CÓDIGO
	-- ========================================================================
	-- Conform.nvim: Formatação assíncrona com suporte a múltiplos formatadores
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			notify_on_error = false,
			-- Formata automaticamente ao salvar
			format_on_save = function(bufnr)
				return { timeout_ms = 500, lsp_fallback = true }
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				vue = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				scss = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				go = { "goimports" },
				php = { "php_cs_fixer" },
				c = { "clang_format" },
				cpp = { "clang_format" },
			},
		},
	},

	-- ========================================================================
	-- NOTIFICAÇÕES E MENSAGENS
	-- ========================================================================
	-- Noice.nvim: UI moderna para cmdline, mensagens e notificações
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
		opts = {
			lsp = {
				progress = { enabled = true },
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
		},
	},

	-- ========================================================================
	-- STATUS LINE
	-- ========================================================================
	-- Lualine: Statusline elegante com tema sincronizado
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = { 
			options = { 
				theme = "tokyonight", -- Tema sincronizado automaticamente
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
		},
	},

	-- ========================================================================
	-- PLUGINS MODULARES
	-- ========================================================================
	-- Git: Movido para lua/plugins/git.lua (gitsigns, fugitive, diffview, lazygit, conflicts)
	-- Terminal: Movido para lua/plugins/terminal.lua (toggleterm + REPLs)
	-- Themes: Movido para lua/plugins/themes.lua (Tokyo Night + alternativas)
	-- Modern Tools: Movido para lua/plugins/modern-tools.lua (todo-comments, trouble, mini, etc)

	-- ========================================================================
	-- GUIAS E HELPERS
	-- ========================================================================
	-- Indent Blankline: Guias visuais de indentação
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

	-- Which-key: Guia interativo de keymaps (Traduzido para Português)
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			local wk = require("which-key")
			wk.setup({
				preset = "modern",
				plugins = {
					marks = true,       -- Mostra marks (m + letra)
					registers = true,   -- Mostra registros (" + letra)
					spelling = {
						enabled = true,
						suggestions = 20, -- Número de sugestões ortográficas
					},
					presets = {
						operators = true,
						motions = true,
						text_objects = true,
						windows = true,
						nav = true,
						z = true,
						g = true,
					},
				},
				win = {
					border = "rounded",
					padding = { 1, 2 },
				},
				layout = {
					height = { min = 4, max = 25 },
					width = { min = 20, max = 50 },
					spacing = 3,
					align = "left",
				},
			})
			
			-- Registrar grupos e descrições traduzidas
			if wk.add then
				wk.add({
					-- Grupos principais
					{ "<leader>f", group = "🔍 Buscar" },
					{ "<leader>c", group = "💻 Código" },
					{ "<leader>g", group = "🌿 Git" },
					{ "<leader>h", group = "📦 Git Hunks" },
					{ "<leader>t", group = "🧪 Terminal/Testes" },
					{ "<leader>d", group = "🐛 Debug/Diagnóstico" },
					{ "<leader>s", group = "📐 Splits/Janelas" },
					{ "<leader>b", group = "📄 Buffers" },
					{ "<leader>e", group = "📂 Explorador" },
					{ "<leader>x", group = "⚠️  Trouble/Problemas" },
					{ "<leader>l", group = "📍 LSP/Location" },
					{ "<leader>k", group = "🌐 HTTP/REST" },
					{ "<leader><tab>", group = "📑 Tabs" },
					
					-- Descrições detalhadas de ações comuns
					{ "<leader>w", desc = "💾 Salvar arquivo" },
					{ "<leader>W", desc = "💾 Salvar todos" },
					{ "<leader>q", desc = "✖️  Fechar buffer" },
					{ "<leader>Q", desc = "🚪 Sair do Neovim" },
					{ "<leader>x", desc = "💾 Salvar e sair" },
					
					-- Buscar (Telescope)
					{ "<leader>ff", desc = "Arquivos" },
					{ "<leader>fg", desc = "Texto (Grep)" },
					{ "<leader>fo", desc = "Explorador de pasta" },
					{ "<leader>fb", desc = "Buffers" },
					{ "<leader>fh", desc = "Ajuda" },
					{ "<leader>fc", desc = "Comandos" },
					{ "<leader>fk", desc = "Keymaps" },
					{ "<leader>fm", desc = "Marks" },
					{ "<leader>fr", desc = "Recentes" },
					{ "<leader>fw", desc = "Palavra sob cursor" },
					{ "<leader>ft", desc = "TODOs" },
					{ "<leader>fT", desc = "TODO/FIX" },
					
					-- Git
					{ "<leader>gs", desc = "Status" },
					{ "<leader>gc", desc = "Commit" },
					{ "<leader>gp", desc = "Push" },
					{ "<leader>gP", desc = "Pull" },
					{ "<leader>gb", desc = "Blame" },
					{ "<leader>gd", desc = "Diff Split" },
					{ "<leader>gl", desc = "Log" },
					{ "<leader>gg", desc = "LazyGit" },
					{ "<leader>gG", desc = "LazyGit (arquivo)" },
					{ "<leader>gv", desc = "Diffview Abrir" },
					{ "<leader>gV", desc = "Diffview Fechar" },
					{ "<leader>gh", desc = "Histórico arquivo" },
					{ "<leader>gH", desc = "Histórico projeto" },
					{ "<leader>gf", desc = "Formatar buffer" },
					{ "<leader>gr", desc = "Referências LSP" },
					
					-- Git Hunks
					{ "<leader>hs", desc = "Stage hunk" },
					{ "<leader>hr", desc = "Reset hunk" },
					{ "<leader>hS", desc = "Stage buffer" },
					{ "<leader>hu", desc = "Undo stage" },
					{ "<leader>hR", desc = "Reset buffer" },
					{ "<leader>hp", desc = "Preview hunk" },
					{ "<leader>hb", desc = "Blame linha" },
					{ "<leader>hd", desc = "Diff arquivo" },
					{ "<leader>hD", desc = "Diff último commit" },
					
					-- Código (LSP)
					{ "<leader>ca", desc = "Code Action" },
					{ "<leader>cr", desc = "Rename" },
					{ "<leader>cs", desc = "Símbolos (Trouble)" },
					{ "<leader>cl", desc = "LSP Info (Trouble)" },
					{ "<leader>ch", desc = "Limpar busca" },
					
					-- Conflitos Git
					{ "<leader>co", desc = "Escolher nosso" },
					{ "<leader>ct", desc = "Escolher deles" },
					{ "<leader>cb", desc = "Escolher ambos" },
					{ "<leader>c0", desc = "Escolher nenhum" },
					{ "<leader>cq", desc = "Listar conflitos" },
					
					-- Debug
					{ "<leader>db", desc = "Toggle Breakpoint" },
					{ "<leader>dB", desc = "Breakpoint Condicional" },
					{ "<leader>dr", desc = "REPL" },
					{ "<leader>dl", desc = "Location list diagnósticos" },
					{ "<leader>dq", desc = "Quickfix diagnósticos" },
					{ "<leader>de", desc = "Diagnóstico flutuante" },
					
					-- Splits/Janelas
					{ "<leader>sv", desc = "Split vertical" },
					{ "<leader>sh", desc = "Split horizontal" },
					{ "<leader>se", desc = "Igualar tamanhos" },
					{ "<leader>sc", desc = "Fechar split" },
					{ "<leader>so", desc = "Manter apenas atual" },
					
					-- Buffers
					{ "<leader>bd", desc = "Deletar buffer" },
					{ "<leader>bD", desc = "Deletar (forçar)" },
					{ "<leader>bw", desc = "Fechar janela" },
					
					-- Explorador
					{ "<leader>e", desc = "Toggle explorador" },
					{ "<leader>ec", desc = "Fechar explorador" },
					{ "<leader>eb", desc = "Buffers (Neo-tree)" },
					{ "<leader>eg", desc = "Git Status (Neo-tree)" },
					
					-- Trouble
					{ "<leader>xx", desc = "Diagnósticos" },
					{ "<leader>xX", desc = "Diagnósticos buffer" },
					{ "<leader>xL", desc = "Location List" },
					{ "<leader>xQ", desc = "Quickfix List" },
					
					-- LSP
					{ "<leader>li", desc = "LSP Info" },
					{ "<leader>lr", desc = "LSP Restart" },
					{ "<leader>ll", desc = "LSP Log" },
					{ "<leader>lo", desc = "Location list abrir" },
					{ "<leader>lc", desc = "Location list fechar" },
					
					-- Testes
					{ "<leader>tn", desc = "Rodar teste próximo" },
					{ "<leader>tF", desc = "Rodar testes arquivo" },
					{ "<leader>to", desc = "Painel de testes" },
					{ "<leader>ts", desc = "Sumário testes" },
					{ "<leader>tb", desc = "Toggle blame" },
					{ "<leader>td", desc = "Toggle deletados" },
					
					-- Tabs
					{ "<leader><tab>n", desc = "Nova tab" },
					{ "<leader><tab>c", desc = "Fechar tab" },
					{ "<leader><tab>]", desc = "Próxima tab" },
					{ "<leader><tab>[", desc = "Tab anterior" },
					{ "<leader><tab>o", desc = "Fechar outras" },
					
					-- HTTP/REST (Kulala)
					{ "<leader>kr", desc = "Executar requisição" },
					{ "<leader>kt", desc = "Toggle view" },
					{ "<leader>ki", desc = "Inspecionar" },
					
					-- Outros
					{ "<leader>R", desc = "Recarregar config" },
					{ "<leader>X", desc = "Tornar executável" },
					{ "<leader>s", desc = "Substituir palavra" },
					{ "<leader>y", desc = "Copiar (clipboard)" },
					{ "<leader>Y", desc = "Copiar linha (clipboard)" },
					{ "<leader>p", desc = "Colar (clipboard)" },
					{ "<leader>P", desc = "Colar antes (clipboard)" },
					{ "<leader>d", desc = "Deletar (sem copiar)" },
					
					-- Movimentos especiais
					{ "]d", desc = "Próximo diagnóstico" },
					{ "[d", desc = "Diagnóstico anterior" },
					{ "]c", desc = "Próximo hunk" },
					{ "[c", desc = "Hunk anterior" },
					{ "]t", desc = "Próximo TODO" },
					{ "[t", desc = "TODO anterior" },
					{ "]q", desc = "Próximo quickfix" },
					{ "[q", desc = "Quickfix anterior" },
					{ "]l", desc = "Próximo location" },
					{ "[l", desc = "Location anterior" },
					{ "]x", desc = "Próximo conflito" },
					{ "[x", desc = "Conflito anterior" },
					{ "]r", desc = "Próxima referência" },
					{ "[r", desc = "Referência anterior" },
					{ "]m", desc = "Próxima função" },
					{ "[m", desc = "Função anterior" },
					{ "]]", desc = "Próxima classe" },
					{ "[[", desc = "Classe anterior" },
					
					-- LSP básico
					{ "gd", desc = "Ir para definição" },
					{ "K", desc = "Hover/Documentação" },
					{ "<leader>rn", desc = "Renomear símbolo" },
				})
			else
				-- Fallback para versões antigas do which-key
				wk.register({
					f = { name = "🔍 Buscar" },
					c = { name = "💻 Código" },
					g = { name = "🌿 Git" },
					h = { name = "📦 Git Hunks" },
					t = { name = "🧪 Terminal/Testes" },
					d = { name = "🐛 Debug/Diagnóstico" },
					s = { name = "📐 Splits/Janelas" },
					b = { name = "📄 Buffers" },
					e = { name = "📂 Explorador" },
					x = { name = "⚠️  Trouble/Problemas" },
					l = { name = "📍 LSP/Location" },
					k = { name = "🌐 HTTP/REST" },
					["<tab>"] = { name = "📑 Tabs" },
				}, { prefix = "<leader>" })
			end
		end,
	},

	-- ========================================================================
	-- COMENTÁRIOS E UTILITIES
	-- ========================================================================
	-- Comment.nvim: Comentar/descomentar código com gcc, gc, gbc
	{ "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },

	-- Vim Startuptime: Profiling do tempo de inicialização (:StartupTime)
	{ "dstein64/vim-startuptime", cmd = "StartupTime" },

	-- ========================================================================
	-- DEBUGGING (DAP - Debug Adapter Protocol)
	-- ========================================================================
	-- nvim-dap: Suporte a debugging com breakpoints, step over/into/out
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"jay-babu/mason-nvim-dap.nvim",
		},
		keys = {
			{ "<F5>", desc = "Debug: Iniciar/Continuar" },
			{ "<F10>", desc = "Debug: Step Over" },
			{ "<F11>", desc = "Debug: Step Into" },
			{ "<F12>", desc = "Debug: Step Out" },
			{ "<leader>db", desc = "Debug: Toggle Breakpoint" },
			{ "<leader>dB", desc = "Debug: Breakpoint Condicional" },
			{ "<leader>dr", desc = "Debug: Abrir REPL" },
			{ "<leader>dl", desc = "Debug: Executar último" },
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			
			-- Setup Mason para DAP adapters
			require("mason-nvim-dap").setup({ 
				ensure_installed = { "python" }, 
				automatic_installation = true 
			})
			
			-- Setup DAP UI
			dapui.setup()
			
			-- Abrir/fechar UI automaticamente
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
			
			-- Keymaps
			vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Iniciar/Continuar" })
			vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
			vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
			vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>dB", function()
				dap.set_breakpoint(vim.fn.input("Condição do breakpoint: "))
			end, { desc = "Debug: Breakpoint Condicional" })
			vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Debug: Abrir REPL" })
			vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Debug: Executar último" })
		end,
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/nvim-nio",
			"nvim-neotest/neotest-jest",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-jest")({ jestCommand = "npm test --" }),
				},
			})
		end,
	},

	-- Autopairs movido para lua/plugins/modern-tools.lua (usando mini.pairs)

	-- Seamless tmux navigation
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},
}
-- Dashboard movido para lua/plugins/dashboard.lua
