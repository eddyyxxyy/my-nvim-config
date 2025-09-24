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
		config = function(_, opts)
			local conform = require("conform")
			conform.setup(opts)
			vim.keymap.set({ "n", "v" }, "<leader>gf", function()
				conform.format({ lsp_fallback = true, async = false, timeout_ms = 500 })
			end, { desc = "Format buffer/range" })
		end,
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
		config = function(_, opts)
			require("toggleterm").setup(opts)
			vim.keymap.set({ "n", "t" }, "<C-\\>", function()
				require("toggleterm").toggle(1)
			end, { desc = "Toggle terminal (Ctrl+\\)" })
			vim.keymap.set({ "n", "t" }, "<leader>tt", function()
				require("toggleterm").toggle(1)
			end, { desc = "Toggle terminal (leader)" })
			vim.keymap.set({ "n", "t" }, "<leader>tb", function()
				vim.cmd("ToggleTerm direction=horizontal")
			end, { desc = "Toggle terminal bottom (horizontal)" })
			vim.keymap.set({ "n", "t" }, "<leader>tr", function()
				vim.cmd("ToggleTerm direction=vertical size=80")
			end, { desc = "Toggle terminal right (vertical)" })
			vim.keymap.set({ "n", "t" }, "<leader>tF", function()
				vim.cmd("ToggleTerm direction=float")
			end, { desc = "Toggle terminal float" })
		end,
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
				dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
				dashboard.button("o", "  Open folder", ":Telescope file_browser path=%:p:h select_buffer=true<CR>"),
				dashboard.button("g", "  Live grep", ":Telescope live_grep<CR>"),
				dashboard.button("n", "  New file", ":ene | startinsert<CR>"),
				dashboard.button("r", "  Recent", ":Telescope oldfiles<CR>"),
				dashboard.button("t", "  Terminal", ":ToggleTerm<CR>"),
				dashboard.button("q", "  Quit", ":qa<CR>"),
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

			vim.keymap.set("n", "<F5>", function()
				dap.continue()
			end, { desc = "DAP Continue" })
			vim.keymap.set("n", "<F10>", function()
				dap.step_over()
			end, { desc = "DAP Step Over" })
			vim.keymap.set("n", "<F11>", function()
				dap.step_into()
			end, { desc = "DAP Step Into" })
			vim.keymap.set("n", "<F12>", function()
				dap.step_out()
			end, { desc = "DAP Step Out" })
			vim.keymap.set("n", "<leader>db", function()
				dap.toggle_breakpoint()
			end, { desc = "DAP Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>dB", function()
				dap.set_breakpoint()
			end, { desc = "DAP Set Breakpoint" })
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
			vim.keymap.set("n", "<leader>tn", function()
				require("neotest").run.run()
			end, { desc = "Run nearest test" })
			vim.keymap.set("n", "<leader>tf", function()
				require("neotest").run.run(vim.fn.expand("%"))
			end, { desc = "Run file tests" })
			vim.keymap.set("n", "<leader>to", function()
				require("neotest").output_panel.toggle()
			end, { desc = "Toggle test output" })
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
