-- lua/plugins/dashboard.lua
-- Dashboard inicial com Alpha.nvim

return {
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		dependencies = { 
			"nvim-tree/nvim-web-devicons",
			"nvim-telescope/telescope.nvim",
			"akinsho/toggleterm.nvim",
		},
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")
			
			-- Header ASCII Art
			dashboard.section.header.val = {
				"",
				"███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
				"████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
				"██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
				"██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
				"██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
				"╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
				"",
				"    🚀 Configuração Moderna e Otimizada 🚀    ",
				"",
			}
			
			-- Botões funcionais
			dashboard.section.buttons.val = {
				dashboard.button("f", "📄  Encontrar Arquivos", "<cmd>Telescope find_files<CR>"),
				dashboard.button("e", "📁  Explorador", "<cmd>Neotree reveal<CR>"),
				dashboard.button("g", "🔍  Buscar Texto", "<cmd>Telescope live_grep<CR>"),
				dashboard.button("r", "🕒  Recentes", "<cmd>Telescope oldfiles<CR>"),
				dashboard.button("t", "💻  Terminal", "<cmd>ToggleTerm direction=float<CR>"),
				dashboard.button("c", "⚙️  Configuração", "<cmd>e ~/.config/nvim/init.lua<CR>"),
				dashboard.button("l", "💤  Lazy", "<cmd>Lazy<CR>"),
				dashboard.button("m", "📦  Mason", "<cmd>Mason<CR>"),
				dashboard.button("q", "🚪  Sair", "<cmd>qa<CR>"),
			}
			
			-- Footer dinâmico com estatísticas
			local function footer()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				return "⚡ Neovim carregado em " .. ms .. "ms com " .. stats.count .. " plugins"
			end
			
			dashboard.section.footer.val = footer()
			
			-- Layout do dashboard
			dashboard.config.layout = {
				{ type = "padding", val = 2 },
				dashboard.section.header,
				{ type = "padding", val = 2 },
				dashboard.section.buttons,
				{ type = "padding", val = 1 },
				dashboard.section.footer,
			}
			
			-- Aplicar configuração
			alpha.setup(dashboard.config)
			
			-- Desabilitar statusline e tabline no dashboard
			vim.api.nvim_create_autocmd("User", {
				pattern = "AlphaReady",
				callback = function()
					vim.opt.showtabline = 0
					vim.opt.laststatus = 0
				end,
			})
			
			-- Restaurar ao sair do dashboard
			vim.api.nvim_create_autocmd("BufUnload", {
				buffer = 0,
				callback = function()
					vim.opt.showtabline = 2
					vim.opt.laststatus = 3
				end,
			})
		end,
	},
}

