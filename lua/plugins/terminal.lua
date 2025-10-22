-- lua/plugins/terminal.lua
-- Configuração completa do terminal integrado com comandos úteis

return {
	-- ToggleTerm: Terminal integrado com múltiplas instâncias
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		lazy = false, -- Carrega no startup para funcionar no dashboard
		cmd = { "ToggleTerm", "TermExec" }, -- Permite usar comandos antes de carregar
		keys = {
			{ "<C-\\>", desc = "Alternar Terminal" },
			{ "<leader>tb", desc = "Terminal Horizontal" },
			{ "<leader>tr", desc = "Terminal Vertical" },
			{ "<leader>tf", desc = "Terminal Flutuante" },
			{ "<leader>tg", desc = "LazyGit (terminal)" },
			{ "<leader>th", desc = "Htop (terminal)" },
			{ "<leader>tn", desc = "Node REPL" },
			{ "<leader>tp", desc = "Python REPL" },
		},
		config = function()
			require("toggleterm").setup({
				size = function(term)
					if term.direction == "horizontal" then
						return 18
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.4
					end
				end,
				open_mapping = [[<C-\>]],
				hide_numbers = true,
				shade_terminals = true,
				shading_factor = 2,
				start_in_insert = true,
				insert_mappings = true,
				terminal_mappings = true,
				persist_size = true,
				persist_mode = true,
				direction = "horizontal", -- 'vertical' | 'horizontal' | 'tab' | 'float'
				close_on_exit = true,
				shell = vim.o.shell,
				auto_scroll = true,
				float_opts = {
					border = "curved",
					winblend = 0,
					highlights = {
						border = "Normal",
						background = "Normal",
					},
				},
				winbar = {
					enabled = false,
					name_formatter = function(term)
						return term.name
					end,
				},
			})

			-- Função helper para criar terminais específicos
			local Terminal = require("toggleterm.terminal").Terminal

			-- LazyGit em terminal
			local lazygit = Terminal:new({
				cmd = "lazygit",
				dir = "git_dir",
				direction = "float",
				float_opts = {
					border = "double",
				},
				on_open = function(term)
					vim.cmd("startinsert!")
					vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
				end,
			})

			-- Htop em terminal
			local htop = Terminal:new({
				cmd = "htop",
				direction = "float",
				float_opts = {
					border = "double",
				},
				on_open = function(term)
					vim.cmd("startinsert!")
					vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
				end,
			})

			-- Node REPL
			local node = Terminal:new({
				cmd = "node",
				direction = "float",
				float_opts = {
					border = "double",
				},
			})

			-- Python REPL
			local python = Terminal:new({
				cmd = "python3",
				direction = "float",
				float_opts = {
					border = "double",
				},
			})

			-- Keymaps personalizados
			local opts = { noremap = true, silent = true }

			-- Terminal básico
			vim.keymap.set({ "n", "t" }, "<C-\\>", function()
				vim.cmd("ToggleTerm")
			end, { desc = "Alternar Terminal" })

			vim.keymap.set("n", "<leader>tb", function()
				vim.cmd("ToggleTerm direction=horizontal")
			end, { desc = "Terminal Horizontal" })

			vim.keymap.set("n", "<leader>tr", function()
				vim.cmd("ToggleTerm direction=vertical size=80")
			end, { desc = "Terminal Vertical" })

			vim.keymap.set("n", "<leader>tf", function()
				vim.cmd("ToggleTerm direction=float")
			end, { desc = "Terminal Flutuante" })

			-- Terminais especializados
			vim.keymap.set("n", "<leader>tg", function()
				lazygit:toggle()
			end, { desc = "LazyGit (terminal)" })

			vim.keymap.set("n", "<leader>th", function()
				htop:toggle()
			end, { desc = "Htop (monitor de sistema)" })

			vim.keymap.set("n", "<leader>tn", function()
				node:toggle()
			end, { desc = "Node REPL" })

			vim.keymap.set("n", "<leader>tp", function()
				python:toggle()
			end, { desc = "Python REPL" })

			-- Melhor navegação no modo terminal
			vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
			vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
			vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
			vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
			vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)

			-- Sair do modo terminal com Esc
			vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "<C-[>", [[<C-\><C-n>]], opts)

			-- Comandos úteis no terminal
			vim.api.nvim_create_user_command("TermExec", function(opts)
				vim.cmd("ToggleTerm")
				vim.defer_fn(function()
					vim.api.nvim_feedkeys(opts.args .. "\n", "t", false)
				end, 100)
			end, { nargs = 1 })
		end,
	},
}

