--[[
  core/autocmds.lua
  Autocomandos personalizados para automações do editor.
  Inclui: highlight yank, trim whitespace, última posição, teclas rápidas, etc.
--]]

-- Grupo de autocomandos do usuário
local augroup = vim.api.nvim_create_augroup("UserAutoCmds", { clear = true })

-- Destacar texto copiado (usa vim.hl para evitar deprecation warning)
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	desc = "Destacar texto ao copiar",
	callback = function()
		vim.hl.on_yank({ timeout = 200 })
	end,
})

-- Remover espaços em branco ao salvar
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup,
	desc = "Remover espaços em branco no final das linhas",
	pattern = "*",
	callback = function()
		-- Ignorar se buffer não for modificável
		if not vim.bo.modifiable then
			return
		end
		-- Salvar posição do cursor
		local save = vim.fn.winsaveview()
		-- Remover espaços em branco
		vim.cmd([[keeppatterns %s/\s\+$//e]])
		-- Restaurar posição
		vim.fn.winrestview(save)
	end,
})

-- Retornar à última posição ao abrir arquivo
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	desc = "Ir para última posição conhecida ao abrir arquivo",
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Fechar certos tipos de janelas com 'q'
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	desc = "Fechar com 'q' em certos tipos de arquivo",
	pattern = {
		"help",
		"lspinfo",
		"man",
		"qf",
		"query",
		"checkhealth",
		"notify",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- Desabilitar algumas features em arquivos grandes
vim.api.nvim_create_autocmd("BufReadPre", {
	group = augroup,
	desc = "Desabilitar features em arquivos grandes",
	callback = function()
		local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
		if ok and stats and stats.size > 1000000 then -- 1MB
			vim.opt_local.spell = false
			vim.opt_local.swapfile = false
			vim.opt_local.undofile = false
			vim.opt_local.breakindent = false
			vim.opt_local.colorcolumn = ""
			vim.opt_local.statuscolumn = ""
			vim.opt_local.signcolumn = "no"
			vim.opt_local.foldcolumn = "0"
			vim.opt_local.winbar = ""
			vim.cmd("syntax off")
		end
	end,
})

-- Template: Exemplos comentados para adicionar seus próprios autocomandos
--
-- Exemplo: Formatar automaticamente ao salvar (alternativa ao Conform)
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   group = augroup,
--   pattern = "*.lua",
--   callback = function()
--     vim.lsp.buf.format()
--   end,
-- })
--
-- Exemplo: Executar comando ao entrar em diretório específico
-- vim.api.nvim_create_autocmd("DirChanged", {
--   group = augroup,
--   callback = function()
--     if vim.fn.getcwd() == "/path/to/project" then
--       -- fazer algo
--     end
--   end,
-- })
--
-- Exemplo: Configurações específicas por tipo de arquivo
-- vim.api.nvim_create_autocmd("FileType", {
--   group = augroup,
--   pattern = "python",
--   callback = function()
--     vim.opt_local.tabstop = 4
--     vim.opt_local.shiftwidth = 4
--   end,
-- })
