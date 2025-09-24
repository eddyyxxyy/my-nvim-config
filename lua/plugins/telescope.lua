return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-file-browser.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local fb_actions = require("telescope").extensions.file_browser.actions

			vim.keymap.set("n", "<C-p>", function()
				builtin.find_files({ hidden = true })
			end, { desc = "Find files (hidden)" })

			vim.keymap.set("n", "<leader>fg", function()
				builtin.live_grep({ additional_args = { "--hidden" } })
			end, { desc = "Live grep (hidden)" })

			-- Open folder browser (cwd) with mappings to cd into selection
			vim.keymap.set("n", "<leader>fo", function()
				telescope.extensions.file_browser.file_browser({
					initial_mode = "normal",
					mappings = {
						i = {
							["<C-y>"] = fb_actions.change_cwd, -- cd para a pasta selecionada
						},
						n = {
							y = fb_actions.change_cwd,
						},
					},
				})
			end, { desc = "Open folder (file browser)" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			local telescope = require("telescope")
			local fb_actions = require("telescope").extensions.file_browser.actions
			telescope.setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
					file_browser = {
						mappings = {
							i = {
								["<C-y>"] = fb_actions.change_cwd,
							},
							n = {
								["y"] = fb_actions.change_cwd,
							},
						},
					},
				},
			})

			telescope.load_extension("ui-select")
			telescope.load_extension("file_browser")
		end,
	},
}
