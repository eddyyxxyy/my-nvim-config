-- lua/plugins/telescope.lua
-- Telescope: Fuzzy finder e navegação de arquivos

return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { 
			"nvim-lua/plenary.nvim", 
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		cmd = "Telescope",
		keys = {
			{ "<C-p>", desc = "Procurar arquivos" },
			{ "<leader>ff", desc = "Procurar arquivos" },
			{ "<leader>fg", desc = "Procurar texto (Grep)" },
			{ "<leader>fo", desc = "Abrir pasta (File Browser)" },
			{ "<leader>fb", desc = "Procurar nos Buffers" },
			{ "<leader>fh", desc = "Histórico de arquivos" },
			{ "<leader>fc", desc = "Procurar comandos" },
			{ "<leader>fk", desc = "Procurar keymaps" },
			{ "<leader>fm", desc = "Procurar marks" },
			{ "<leader>fr", desc = "Arquivos recentes" },
		},
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			local telescope = require("telescope")
			local fb_actions = require("telescope").extensions.file_browser.actions
			local actions = require("telescope.actions")
			
			telescope.setup({
				defaults = {
					prompt_prefix = " ",
					selection_caret = " ",
					path_display = { "truncate" },
					sorting_strategy = "ascending",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
							results_width = 0.8,
						},
						vertical = {
							mirror = false,
						},
						width = 0.87,
						height = 0.80,
						preview_cutoff = 120,
					},
					mappings = {
						i = {
							["<C-n>"] = actions.cycle_history_next,
							["<C-p>"] = actions.cycle_history_prev,
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-c>"] = actions.close,
							["<Down>"] = actions.move_selection_next,
							["<Up>"] = actions.move_selection_previous,
							["<CR>"] = actions.select_default,
							["<C-x>"] = actions.select_horizontal,
							["<C-v>"] = actions.select_vertical,
							["<C-t>"] = actions.select_tab,
							["<C-u>"] = actions.preview_scrolling_up,
							["<C-d>"] = actions.preview_scrolling_down,
						},
						n = {
							["<esc>"] = actions.close,
							["<CR>"] = actions.select_default,
							["<C-x>"] = actions.select_horizontal,
							["<C-v>"] = actions.select_vertical,
							["<C-t>"] = actions.select_tab,
							["j"] = actions.move_selection_next,
							["k"] = actions.move_selection_previous,
							["H"] = actions.move_to_top,
							["M"] = actions.move_to_middle,
							["L"] = actions.move_to_bottom,
							["<Down>"] = actions.move_selection_next,
							["<Up>"] = actions.move_selection_previous,
							["gg"] = actions.move_to_top,
							["G"] = actions.move_to_bottom,
							["<C-u>"] = actions.preview_scrolling_up,
							["<C-d>"] = actions.preview_scrolling_down,
							["?"] = actions.which_key,
						},
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
					file_browser = {
						theme = "ivy",
						hijack_netrw = true,
						mappings = {
							i = {
								["<C-y>"] = fb_actions.change_cwd,
							},
							n = {
								["y"] = fb_actions.change_cwd,
								["N"] = fb_actions.create,
								["h"] = fb_actions.goto_parent_dir,
								["/"] = function()
									vim.cmd("startinsert")
								end,
							},
						},
					},
				},
			})

			telescope.load_extension("ui-select")
			telescope.load_extension("file_browser")

			-- Keymaps
			local builtin = require("telescope.builtin")
			
			vim.keymap.set("n", "<C-p>", function()
				builtin.find_files({ hidden = true })
			end, { desc = "Procurar arquivos" })
			
			vim.keymap.set("n", "<leader>ff", function()
				builtin.find_files({ hidden = true })
			end, { desc = "Procurar arquivos" })
			
			vim.keymap.set("n", "<leader>fg", function()
				builtin.live_grep({ additional_args = { "--hidden" } })
			end, { desc = "Procurar texto (Grep)" })
			
			vim.keymap.set("n", "<leader>fo", function()
				telescope.extensions.file_browser.file_browser({
					path = "%:p:h",
					cwd = vim.fn.getcwd(),
					respect_gitignore = false,
					hidden = true,
					grouped = true,
					previewer = false,
					initial_mode = "normal",
				})
			end, { desc = "Abrir pasta (File Browser)" })
			
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Procurar nos Buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Procurar ajuda" })
			vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Procurar comandos" })
			vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Procurar keymaps" })
			vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "Procurar marks" })
			vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Arquivos recentes" })
			vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Procurar palavra sob cursor" })
		end,
	},
}
