-- lua/plugins/utils.lua
-- Utilitários para melhorar a experiência de edição

return {
	-- EditorConfig: Aplica configurações específicas do projeto via .editorconfig
	{ 
		"gpanders/editorconfig.nvim", 
		event = "BufReadPre",
	},

	-- Sleuth: Detecta automaticamente estilo de indentação do projeto
	{ 
		"tpope/vim-sleuth",
		event = "BufReadPre",
	},
}
