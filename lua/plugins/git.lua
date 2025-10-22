-- lua/plugins/git.lua
-- Configuração completa de Git com Gitsigns, Fugitive, Diffview e LazyGit

return {
	-- Gitsigns: Indicadores Git na coluna lateral e hunk navigation
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signcolumn = true,
				numhl = false,
				linehl = false,
				word_diff = false,
				watch_gitdir = {
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame = true,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol",
					delay = 500,
					ignore_whitespace = false,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil,
				max_file_length = 40000,
				preview_config = {
					border = "rounded",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navegação entre hunks
					map("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, desc = "Próximo hunk Git" })

					map("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, desc = "Hunk anterior Git" })

					-- Ações de hunk
					map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
					map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
					map("v", "<leader>hs", function()
						gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Stage hunk (visual)" })
					map("v", "<leader>hr", function()
						gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Reset hunk (visual)" })
					map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer inteiro" })
					map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Desfazer stage hunk" })
					map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer inteiro" })
					map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
					map("n", "<leader>hb", function()
						gs.blame_line({ full = true })
					end, { desc = "Blame linha completo" })
					map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle blame linha" })
					map("n", "<leader>hd", gs.diffthis, { desc = "Diff deste arquivo" })
					map("n", "<leader>hD", function()
						gs.diffthis("~")
					end, { desc = "Diff contra último commit" })
					map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle mostrar deletados" })

					-- Text object para hunks
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Selecionar hunk Git" })
				end,
			})
		end,
	},

	-- Fugitive: Comandos Git completos
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse" },
		keys = {
			{ "<leader>gs", "<cmd>Git<cr>", desc = "Git Status" },
			{ "<leader>gc", "<cmd>Git commit<cr>", desc = "Git Commit" },
			{ "<leader>gp", "<cmd>Git push<cr>", desc = "Git Push" },
			{ "<leader>gP", "<cmd>Git pull<cr>", desc = "Git Pull" },
			{ "<leader>gb", "<cmd>Git blame<cr>", desc = "Git Blame" },
			{ "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git Diff Split" },
			{ "<leader>gl", "<cmd>Git log --oneline<cr>", desc = "Git Log" },
		},
	},

	-- Diffview: Visualização de diffs e histórico Git
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
		keys = {
			{ "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Abrir Diffview" },
			{ "<leader>gV", "<cmd>DiffviewClose<cr>", desc = "Fechar Diffview" },
			{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Histórico do arquivo" },
			{ "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Histórico do projeto" },
		},
		opts = {
			enhanced_diff_hl = true,
			view = {
				default = {
					layout = "diff2_horizontal",
				},
				merge_tool = {
					layout = "diff3_horizontal",
				},
			},
		},
	},

	-- LazyGit: Interface TUI completa para Git
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
			{ "<leader>gG", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit (arquivo atual)" },
		},
	},

	-- Git Conflict: Melhor resolução de conflitos
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		event = "BufReadPost",
		config = function()
			require("git-conflict").setup({
				default_mappings = true,
				default_commands = true,
				disable_diagnostics = false,
				list_opener = "copen",
				highlights = {
					incoming = "DiffAdd",
					current = "DiffText",
				},
			})

			-- Atalhos personalizados
			vim.keymap.set("n", "<leader>co", "<cmd>GitConflictChooseOurs<cr>", { desc = "Conflito: escolher nosso" })
			vim.keymap.set("n", "<leader>ct", "<cmd>GitConflictChooseTheirs<cr>", { desc = "Conflito: escolher deles" })
			vim.keymap.set("n", "<leader>cb", "<cmd>GitConflictChooseBoth<cr>", { desc = "Conflito: escolher ambos" })
			vim.keymap.set("n", "<leader>c0", "<cmd>GitConflictChooseNone<cr>", { desc = "Conflito: escolher nenhum" })
			vim.keymap.set("n", "]x", "<cmd>GitConflictNextConflict<cr>", { desc = "Próximo conflito" })
			vim.keymap.set("n", "[x", "<cmd>GitConflictPrevConflict<cr>", { desc = "Conflito anterior" })
			vim.keymap.set("n", "<leader>cq", "<cmd>GitConflictListQf<cr>", { desc = "Listar conflitos" })
		end,
	},
}

