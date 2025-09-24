-- Keymaps (placeholder):
-- Behavior is currently defined across plugin configs. Keep this file for
-- future user keymaps. Example template:
--
-- local map = vim.keymap.set
-- local opts = { noremap = true, silent = true }
-- map("n", "<leader>e", ":Neotree toggle<CR>", opts)
--
-- Do NOT remove this file; it documents the structure and allows gradual moves.

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Normal mode (n)

-- Essential
keymap("n", "<leader>w", "<cmd>write<CR>", { desc = "Salvar arquivo" })
keymap("n", "<leader>q", "<cmd>quit<CR>", { desc = "Sair da janela" })

-- Clean highlights
keymap("n", "<leader>ch", "<cmd>noh<CR>", { desc = "Limpar Destaque (Clear Highlight)" })

-- Window management (Splits)
keymap("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Split Vertical" })
keymap("n", "<leader>sh", "<cmd>split<CR>", { desc = "Split Horizontal" })
keymap("n", "<leader>sc", "<cmd>close<CR>", { desc = "Fechar Split" })
keymap("n", "<leader>so", "<cmd>only<CR>", { desc = "Manter Apenas Split Atual" })

-- Neo-tree (File Explorer)
keymap("n", "<leader>e", ":Neotree filesystem reveal left<CR>", { desc = "Explorador de arquivos" })
keymap("n", "<leader>ec", ":Neotree close<CR>", { desc = "Fechar Explorador" })

-- Telescope (Search)
keymap("n", "<C-p>", function()
	require("telescope.builtin").find_files({ hidden = true })
end, { desc = "Procurar arquivos" })
keymap("n", "<leader>fg", function()
	require("telescope.builtin").live_grep({ additional_args = { "--hidden" } })
end, { desc = "Procurar Texto (Grep)" })
keymap("n", "<leader>fo", function()
	require("telescope").extensions.file_browser.file_browser({
		mappings = {
			i = { ["<C-y>"] = require("telescope").extensions.file_browser.actions.change_cwd },
			n = { y = require("telescope").extensions.file_browser.actions.change_cwd },
		},
	})
end, { desc = "Abrir pasta (File Browser)" })
keymap("n", "<leader>fb", function()
	require("telescope.builtin").buffers()
end, { desc = "Procurar nos Buffers" })

-- ToggleTerm (Terminal)
keymap({ "n", "t" }, "<C-`>", function()
	require("toggleterm").toggle(1)
end, { desc = "Alternar Terminal" }) -- Usei C-` (crase) como alternativa a C-\
keymap("n", "<leader>tb", function()
	vim.cmd("ToggleTerm direction=horizontal")
end, { desc = "Terminal (Horizontal)" })
keymap("n", "<leader>tr", function()
	vim.cmd("ToggleTerm direction=vertical size=80")
end, { desc = "Terminal (Vertical)" })
keymap("n", "<leader>tf", function()
	vim.cmd("ToggleTerm direction=float")
end, { desc = "Terminal (Flutuante)" })

-- Formatting (Conform)
keymap({ "n", "v" }, "<leader>gf", function()
	require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 500 })
end, { desc = "Formatar buffer/seleção" })

-- Tests (Neotest)
keymap("n", "<leader>tn", function()
	require("neotest").run.run()
end, { desc = "Rodar teste mais próximo" })
keymap("n", "<leader>tF", function()
	require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Rodar testes do arquivo" }) -- Mudei para tF para não colidir
keymap("n", "<leader>to", function()
	require("neotest").output_panel.toggle()
end, { desc = "Alternar painel de testes" })

print("✔️  Atalhos de core/keymaps.lua carregados.")
