-- lua/plugins/themes.lua
-- Coleção de temas modernos e clean
-- Descomente o tema que deseja usar e comente os outros

return {
	-- Tokyo Night: Tema moderno com cores vibrantes e clean
	-- Muito popular, excelente legibilidade, suporta várias variações
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "night", -- Opções: "storm", "moon", "night", "day"
				light_style = "day",
				transparent = false,
				terminal_colors = true,
				styles = {
					comments = { italic = true },
					keywords = { italic = true },
					functions = {},
					variables = {},
					sidebars = "dark",
					floats = "dark",
				},
				sidebars = { "qf", "help", "terminal", "packer" },
				day_brightness = 0.3,
				hide_inactive_statusline = false,
				dim_inactive = false,
				lualine_bold = false,
				on_colors = function(colors) end,
				on_highlights = function(highlights, colors) end,
			})
			vim.cmd.colorscheme("tokyonight")
		end,
	},

	-- Kanagawa: Inspirado em "A Grande Onda de Kanagawa"
	-- Cores suaves, excelente contraste, muito elegante
	-- {
	-- 	"rebelot/kanagawa.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("kanagawa").setup({
	-- 			compile = false,
	-- 			undercurl = true,
	-- 			commentStyle = { italic = true },
	-- 			functionStyle = {},
	-- 			keywordStyle = { italic = true },
	-- 			statementStyle = { bold = true },
	-- 			typeStyle = {},
	-- 			transparent = false,
	-- 			dimInactive = false,
	-- 			terminalColors = true,
	-- 			colors = {
	-- 				palette = {},
	-- 				theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
	-- 			},
	-- 			overrides = function(colors)
	-- 				return {}
	-- 			end,
	-- 			theme = "wave", -- Opções: "wave", "dragon", "lotus"
	-- 			background = {
	-- 				dark = "wave",
	-- 				light = "lotus",
	-- 			},
	-- 		})
	-- 		vim.cmd.colorscheme("kanagawa")
	-- 	end,
	-- },

	-- Rose Pine: Minimalista, cores naturais e suaves
	-- Excelente para longas sessões, muito confortável
	-- {
	-- 	"rose-pine/neovim",
	-- 	name = "rose-pine",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("rose-pine").setup({
	-- 			variant = "auto", -- Opções: "auto", "main", "moon", "dawn"
	-- 			dark_variant = "main",
	-- 			dim_inactive_windows = false,
	-- 			extend_background_behind_borders = true,
	-- 			enable = {
	-- 				terminal = true,
	-- 				legacy_highlights = true,
	-- 				migrations = true,
	-- 			},
	-- 			styles = {
	-- 				bold = true,
	-- 				italic = true,
	-- 				transparency = false,
	-- 			},
	-- 			groups = {
	-- 				border = "muted",
	-- 				link = "iris",
	-- 				panel = "surface",
	-- 				error = "love",
	-- 				hint = "iris",
	-- 				info = "foam",
	-- 				note = "pine",
	-- 				todo = "rose",
	-- 				warn = "gold",
	-- 				git_add = "foam",
	-- 				git_change = "rose",
	-- 				git_delete = "love",
	-- 				git_dirty = "rose",
	-- 				git_ignore = "muted",
	-- 				git_merge = "iris",
	-- 				git_rename = "pine",
	-- 				git_stage = "iris",
	-- 				git_text = "rose",
	-- 				git_untracked = "subtle",
	-- 				h1 = "iris",
	-- 				h2 = "foam",
	-- 				h3 = "rose",
	-- 				h4 = "gold",
	-- 				h5 = "pine",
	-- 				h6 = "foam",
	-- 			},
	-- 			highlight_groups = {},
	-- 			before_highlight = function(group, highlight, palette) end,
	-- 		})
	-- 		vim.cmd.colorscheme("rose-pine")
	-- 	end,
	-- },

	-- Nightfox: Família de temas altamente customizáveis
	-- Várias variações (nordfox, duskfox, nightfox, etc)
	-- {
	-- 	"EdenEast/nightfox.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("nightfox").setup({
	-- 			options = {
	-- 				compile_path = vim.fn.stdpath("cache") .. "/nightfox",
	-- 				compile_file_suffix = "_compiled",
	-- 				transparent = false,
	-- 				terminal_colors = true,
	-- 				dim_inactive = false,
	-- 				module_default = true,
	-- 				colorblind = {
	-- 					enable = false,
	-- 					simulate_only = false,
	-- 					severity = {
	-- 						protan = 0,
	-- 						deutan = 0,
	-- 						tritan = 0,
	-- 					},
	-- 				},
	-- 				styles = {
	-- 					comments = "italic",
	-- 					conditionals = "NONE",
	-- 					constants = "NONE",
	-- 					functions = "NONE",
	-- 					keywords = "bold",
	-- 					numbers = "NONE",
	-- 					operators = "NONE",
	-- 					strings = "NONE",
	-- 					types = "NONE",
	-- 					variables = "NONE",
	-- 				},
	-- 				inverse = {
	-- 					match_paren = false,
	-- 					visual = false,
	-- 					search = false,
	-- 				},
	-- 				modules = {},
	-- 			},
	-- 			palettes = {},
	-- 			specs = {},
	-- 			groups = {},
	-- 		})
	-- 		vim.cmd.colorscheme("nightfox") -- Opções: "nightfox", "dayfox", "dawnfox", "duskfox", "nordfox", "terafox", "carbonfox"
	-- 	end,
	-- },

	-- Oxocarbon: Tema IBM Carbon Design System
	-- Muito clean, profissional, moderno
	-- {
	-- 	"nyoom-engineering/oxocarbon.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.opt.background = "dark"
	-- 		vim.cmd.colorscheme("oxocarbon")
	-- 	end,
	-- },

	-- Everforest: Cores naturais, confortável para os olhos
	-- Alternativa ao Gruvbox, mas mais moderno
	-- {
	-- 	"neanias/everforest-nvim",
	-- 	version = false,
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("everforest").setup({
	-- 			background = "hard", -- Opções: "hard", "medium", "soft"
	-- 			transparent_background_level = 0,
	-- 			italics = true,
	-- 			disable_italic_comments = false,
	-- 			sign_column_background = "none",
	-- 			ui_contrast = "low",
	-- 			dim_inactive_windows = false,
	-- 			diagnostic_text_highlight = false,
	-- 			diagnostic_virtual_text = "coloured",
	-- 			diagnostic_line_highlight = false,
	-- 			spell_foreground = false,
	-- 			show_eob = true,
	-- 			float_style = "bright",
	-- 			on_highlights = function(hl, palette) end,
	-- 		})
	-- 		vim.cmd.colorscheme("everforest")
	-- 	end,
	-- },
}

