-- lua/plugins/treesitter.lua
-- TreeSitter: Syntax highlighting avançado e análise sintática

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects", -- Text objects baseados em árvore sintática
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			-- Instalação automática de parsers ao abrir arquivos
			auto_install = true,
			
			-- Linguagens garantidas (instaladas automaticamente)
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"query",
				"c", -- Linguagem C
				"cpp", -- C++ (adicional)
				"go",
				"javascript",
				"typescript",
				"tsx",
				"bash",
				"css",
				"csv",
				"regex",
				"astro",
				"editorconfig",
				"gitignore",
				"git_config",
				"git_rebase",
				"gitcommit",
				"gitattributes",
				"html",
				"jsdoc",
				"json",
				"jsonc",
				"markdown",
				"markdown_inline",
				"nginx",
				"php",
				"phpdoc",
				"python",
				"scss",
				"sql",
				"ssh_config",
				"tmux",
				"toml",
				"twig",
				"vue",
				"yaml",
			},
			
			-- Syntax highlighting
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			
			-- Indentação baseada em TreeSitter
			indent = {
				enable = true,
			},
			
			-- Seleção incremental baseada na árvore sintática
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
			
			-- Text objects
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]m"] = "@function.outer",
						["]]"] = "@class.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
					},
				},
			},
		})
	end,
}
