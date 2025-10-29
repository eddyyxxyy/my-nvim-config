-- lua/core/keymaps.lua
-- Keymaps essenciais do editor (não relacionados a plugins específicos)
-- Keymaps de plugins específicos devem ficar nos seus respectivos arquivos em lua/plugins/

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ============================================================================
-- KEYMAPS ESSENCIAIS DO VIM/NEOVIM
-- ============================================================================

-- Salvar e Sair
keymap("n", "<leader>w", "<cmd>write<CR>", { desc = "Salvar arquivo (formata automaticamente)" })
keymap("n", "<leader>W", "<cmd>wall<CR>", { desc = "Salvar todos" })
keymap("n", "<leader>Q", "<cmd>quitall<CR>", { desc = "Sair de tudo" })
keymap("n", "<leader>x", "<cmd>x<CR>", { desc = "Salvar e sair da janela" })
keymap("n", "<leader>bw", "<cmd>quit<CR>", { desc = "Fechar janela (não buffer)" })
-- Nota: <leader>q e <leader>bd estão definidos em modern-tools.lua (mini.bufremove)

-- ============================================================================
-- NAVEGAÇÃO E EDIÇÃO
-- ============================================================================

-- Limpar destaque de busca
keymap("n", "<leader>ch", "<cmd>nohlsearch<CR>", { desc = "Limpar destaque de busca" })
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Limpar destaque" })

-- Navegação com setas (ao invés de hjkl)
keymap("n", "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Descer (wrapped lines)" })
keymap("n", "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Subir (wrapped lines)" })
keymap("n", "<Left>", "h", { desc = "Ir para esquerda" })
keymap("n", "<Right>", "l", { desc = "Ir para direita" })

-- Redimensionar painéis (Alt+hjkl - não quebra navegação padrão)
keymap("n", "<M-h>", "<cmd>vertical resize -2<CR>", { desc = "Diminuir largura do painel" })
keymap("n", "<M-j>", "<cmd>resize +2<CR>", { desc = "Aumentar altura do painel" })
keymap("n", "<M-k>", "<cmd>resize -2<CR>", { desc = "Diminuir altura do painel" })
keymap("n", "<M-l>", "<cmd>vertical resize +2<CR>", { desc = "Aumentar largura do painel" })

-- Alternativa adicional com Ctrl+W (padrão Vim)
keymap("n", "<C-w><", "<cmd>vertical resize -2<CR>", { desc = "Diminuir largura" })
keymap("n", "<C-w>>", "<cmd>vertical resize +2<CR>", { desc = "Aumentar largura" })

-- Mover linhas selecionadas (mantém J e K maiúsculos)
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Mover linha para baixo" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Mover linha para cima" })

-- Manter seleção ao indentar
keymap("v", "<", "<gv", { desc = "Indentar esquerda (manter seleção)" })
keymap("v", ">", ">gv", { desc = "Indentar direita (manter seleção)" })

-- Juntar linhas mantendo cursor no lugar
keymap("n", "J", "mzJ`z", { desc = "Juntar linhas" })

-- Melhor scrolling
keymap("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centralizado)" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centralizado)" })

-- Centralizar busca
keymap("n", "n", "nzzzv", { desc = "Próximo resultado (centralizado)" })
keymap("n", "N", "Nzzzv", { desc = "Resultado anterior (centralizado)" })

-- ============================================================================
-- GERENCIAMENTO DE JANELAS E SPLITS
-- ============================================================================

-- Criar splits
keymap("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Split vertical" })
keymap("n", "<leader>sh", "<cmd>split<CR>", { desc = "Split horizontal" })
keymap("n", "<leader>se", "<C-w>=", { desc = "Igualar tamanhos" })
keymap("n", "<leader>sc", "<cmd>close<CR>", { desc = "Fechar split" })
keymap("n", "<leader>so", "<cmd>only<CR>", { desc = "Manter apenas split atual" })

-- Navegar entre janelas com Ctrl+setas (substituindo Ctrl+hjkl do vim-tmux-navigator)
keymap("n", "<C-Up>", "<C-w>k", { desc = "Ir para painel acima" })
keymap("n", "<C-Down>", "<C-w>j", { desc = "Ir para painel abaixo" })
keymap("n", "<C-Left>", "<C-w>h", { desc = "Ir para painel esquerda" })
keymap("n", "<C-Right>", "<C-w>l", { desc = "Ir para painel direita" })

-- ============================================================================
-- GERENCIAMENTO DE TABS
-- ============================================================================

keymap("n", "<leader><tab>n", "<cmd>tabnew<CR>", { desc = "Nova tab" })
keymap("n", "<leader><tab>c", "<cmd>tabclose<CR>", { desc = "Fechar tab" })
keymap("n", "<leader><tab>]", "<cmd>tabnext<CR>", { desc = "Próxima tab" })
keymap("n", "<leader><tab>[", "<cmd>tabprevious<CR>", { desc = "Tab anterior" })
keymap("n", "<leader><tab>o", "<cmd>tabonly<CR>", { desc = "Fechar outras tabs" })

-- ============================================================================
-- CLIPBOARD E CÓPIA/COLA
-- ============================================================================

-- Copiar para clipboard do sistema
keymap({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copiar para clipboard do sistema" })
keymap("n", "<leader>Y", [["+Y]], { desc = "Copiar linha para clipboard" })

-- Colar do clipboard do sistema
keymap({ "n", "v" }, "<leader>p", [["+p]], { desc = "Colar do clipboard" })
keymap({ "n", "v" }, "<leader>P", [["+P]], { desc = "Colar antes do cursor" })

-- Deletar sem copiar para registro
keymap({ "n", "v" }, "<leader>d", [["_d]], { desc = "Deletar (sem copiar)" })

-- ============================================================================
-- QUICKFIX E LOCATION LIST
-- ============================================================================

keymap("n", "<leader>qo", "<cmd>copen<CR>", { desc = "Abrir quickfix" })
keymap("n", "<leader>qc", "<cmd>cclose<CR>", { desc = "Fechar quickfix" })
keymap("n", "]q", "<cmd>cnext<CR>", { desc = "Próximo quickfix" })
keymap("n", "[q", "<cmd>cprev<CR>", { desc = "Quickfix anterior" })
keymap("n", "<leader>lo", "<cmd>lopen<CR>", { desc = "Abrir location list" })
keymap("n", "<leader>lc", "<cmd>lclose<CR>", { desc = "Fechar location list" })
keymap("n", "]l", "<cmd>lnext<CR>", { desc = "Próximo location" })
keymap("n", "[l", "<cmd>lprev<CR>", { desc = "Location anterior" })

-- ============================================================================
-- COMANDOS ÚTEIS
-- ============================================================================

-- Recarregar configuração
keymap("n", "<leader>R", "<cmd>source $MYVIMRC<CR>", { desc = "Recarregar configuração" })

-- Selecionar tudo
keymap("n", "<C-a>", "ggVG", { desc = "Selecionar tudo" })

-- Substituir palavra sob cursor
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Substituir palavra sob cursor" })

-- Tornar arquivo executável
keymap("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Tornar arquivo executável" })

-- Abrir URL sob cursor
keymap("n", "gx", "<cmd>!xdg-open <cfile><CR>", { silent = true, desc = "Abrir URL" })

-- ============================================================================
-- FORMATAÇÃO (Conform)
-- ============================================================================

keymap({ "n", "v" }, "<leader>gf", function()
	require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 500 })
end, { desc = "Formatar buffer/seleção" })

-- ============================================================================
-- TESTES (Neotest)
-- ============================================================================

keymap("n", "<leader>tn", function()
	require("neotest").run.run()
end, { desc = "Rodar teste mais próximo" })

keymap("n", "<leader>tF", function()
	require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Rodar testes do arquivo" })

keymap("n", "<leader>to", function()
	require("neotest").output_panel.toggle()
end, { desc = "Alternar painel de testes" })

keymap("n", "<leader>ts", function()
	require("neotest").summary.toggle()
end, { desc = "Alternar sumário de testes" })

-- ============================================================================
-- DIAGNÓSTICOS LSP
-- ============================================================================

keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Diagnóstico anterior" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Próximo diagnóstico" })
keymap("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Location list com diagnósticos" })
keymap("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Quickfix com diagnósticos" })
keymap("n", "<leader>de", vim.diagnostic.open_float, { desc = "Mostrar diagnóstico flutuante" })

-- LSP Info e Diagnóstico
keymap("n", "<leader>li", "<cmd>LspInfo<CR>", { desc = "LSP Info" })
keymap("n", "<leader>lr", "<cmd>LspRestart<CR>", { desc = "LSP Restart" })
keymap("n", "<leader>ll", "<cmd>LspLog<CR>", { desc = "LSP Log" })

-- Mensagem informativa
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.notify("✔️  Keymaps essenciais carregados", vim.log.levels.INFO, { title = "Neovim" })
	end,
	once = true,
})
