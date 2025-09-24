-- lua/plugins/theme.lua
return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- Can be "latte", "frappe", "macchiato", "mocha"
			background = {
				light = "latte",
				dark = "macchiato",
			},
			transparent_background = false,
			show_end_of_buffer = false,
			term_colors = true,
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = false,
				neotree = true,
				telescope = true,
				notify = true,
				treesitter = true,
				which_key = true,
				lualine = true,
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
