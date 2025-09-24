return {
	-- Formatting with fallback chains and format-on-save
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			notify_on_error = false,
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

	-- Better notifications
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

	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = { options = { theme = "gruvbox-material" } },
	},

	-- Git signs
	{ "lewis6991/gitsigns.nvim", event = { "BufReadPre", "BufNewFile" }, opts = {} },

	-- Git commands (fugitive)
	{ "tpope/vim-fugitive", cmd = { "Git", "G" } },

	-- Indentation guides
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

	-- Which-key helper
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			local wk = require("which-key")
			wk.setup({})
			if wk.add then
				wk.add({
					{ "<leader>f", group = "find" },
					{ "<leader>t", group = "test/terminal" },
					{ "<leader>d", group = "debug" },
					{ "<leader>g", group = "git" },
					{ "<leader>c", group = "code" },
					{ "<leader>s", group = "split/window" },
					{ "<leader>b", group = "buffer" },
					{ "<leader>e", group = "explorer" },
				})
			else
				wk.register({
					f = { name = "+find" },
					t = { name = "+test/terminal" },
					d = { name = "+debug" },
					g = { name = "+git" },
					c = { name = "+code" },
				}, { prefix = "<leader>" })
			end
		end,
	},

	-- Comments
	{ "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },

	-- Toggleable terminal
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = { open_mapping = [[<C-\\>]], direction = "horizontal", shade_terminals = true, size = 18 },
	},

	-- Dashboard
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")
			dashboard.section.header.val = {
				"",
				"   Neovim",
				"",
			}
			dashboard.section.buttons.val = {
				dashboard.button("f", "  Encontrar Arquivos", ":Telescope find_files<CR>"),
				dashboard.button(
					"o",
					"  Encontrar Pastas",
					":Telescope file_browser path=%:p:h select_buffer=true<CR>"
				),
				dashboard.button("g", "  Live Grep", ":Telescope live_grep<CR>"),
				dashboard.button("n", "  Novo Arquivo", ":ene | startinsert<CR>"),
				dashboard.button("r", "  Recente", ":Telescope oldfiles<CR>"),
				dashboard.button("t", "  Terminal", ":ToggleTerm<CR>"),
				dashboard.button("q", "  Sair", ":qa<CR>"),
			}
			dashboard.section.footer.val = "Startup otimizado com lazy.nvim"
			alpha.setup(dashboard.config)
		end,
	},

	-- Startup profiling
	{ "dstein64/vim-startuptime", cmd = "StartupTime" },

	-- DAP and Neotest
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			require("mason-nvim-dap").setup({ ensure_installed = { "python" }, automatic_installation = true })
			dapui.setup()
			dap.listeners.after.event_initialized["dapui"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui"] = function()
				dapui.close()
			end
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

	-- Autopairs integrated with cmp
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local npairs = require("nvim-autopairs")
			npairs.setup({})
			local cmp = require("cmp")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	-- Seamless tmux navigation
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},
}
