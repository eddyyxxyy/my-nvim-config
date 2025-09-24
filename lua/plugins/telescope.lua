return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-file-browser.nvim" },
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
