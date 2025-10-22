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
			-- Formata automaticamente ao salvar (exceto C/C++)
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				return { timeout_ms = 500, lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype] }
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

	-- Which-key: Guia interativo de keymaps
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			local wk = require("which-key")
			wk.setup({
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
			})
			
			if wk.add then
				wk.add({
					{ "<leader>f", group = "Buscar" },
					{ "<leader>c", group = "Code" },
					{ "<leader>g", group = "Git" },
					{ "<leader>h", group = "Git Hunks" },
					{ "<leader>t", group = "Terminal/Test" },
					{ "<leader>d", group = "Debug/Diagnóstico" },
					{ "<leader>s", group = "Split/Window" },
					{ "<leader>b", group = "Buffer" },
					{ "<leader>e", group = "Explorer" },
					{ "<leader>x", group = "Trouble/Quickfix" },
					{ "<leader>q", group = "Quit/Quickfix" },
					{ "<leader>l", group = "Location List" },
					{ "<leader><tab>", group = "Tabs" },
				})
			else
				wk.register({
					f = { name = "+buscar" },
					t = { name = "+terminal/test" },
					d = { name = "+debug/diagnóstico" },
					g = { name = "+git" },
					h = { name = "+git hunks" },
					c = { name = "+code" },
					s = { name = "+split/window" },
					b = { name = "+buffer" },
					e = { name = "+explorer" },
					x = { name = "+trouble/quickfix" },
					q = { name = "+quit/quickfix" },
					l = { name = "+location list" },
					["<tab>"] = { name = "+tabs" },
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
