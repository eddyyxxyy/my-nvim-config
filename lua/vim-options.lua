--[[
  vim-options.lua
  Configurações essenciais do editor: indentação, UI, busca, diagnósticos.
  Define o comportamento padrão do Neovim antes de carregar plugins.
--]]

-- ============================================================================
-- LEADER KEY
-- ============================================================================
-- Define a tecla leader (espaço) antes de qualquer keymap
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- INDENTAÇÃO
-- ============================================================================
-- Configurações padrão (podem ser sobrescritas por editorconfig/sleuth)
vim.opt.tabstop = 4       -- Número de espaços visuais por <Tab>
vim.opt.shiftwidth = 4    -- Número de espaços para operações de indentação
vim.opt.softtabstop = 4   -- Número de espaços inseridos ao pressionar <Tab>
vim.opt.expandtab = true  -- Usa espaços ao invés de caracteres tab
vim.opt.autoindent = true -- Mantém indentação da linha anterior
vim.opt.smartindent = true -- Indentação inteligente baseada em sintaxe

-- ============================================================================
-- INTERFACE E VISUALIZAÇÃO
-- ============================================================================
vim.opt.number = true          -- Mostra números de linha
vim.opt.relativenumber = true  -- Números relativos (útil para movimentação)
vim.opt.termguicolors = true   -- Habilita cores RGB (true color)
vim.opt.cursorline = true      -- Destaca linha do cursor
vim.opt.wrap = false           -- Desabilita quebra automática de linha

-- ============================================================================
-- BUSCA
-- ============================================================================
vim.opt.ignorecase = true -- Ignora maiúsculas/minúsculas na busca
vim.opt.smartcase = true  -- Respeita case se busca contém maiúsculas

-- ============================================================================
-- HISTÓRICO E PERSISTÊNCIA
-- ============================================================================
vim.opt.undofile = true -- Habilita arquivo de undo persistente (~/.local/state/nvim/undo/)

-- ============================================================================
-- RESPONSIVIDADE
-- ============================================================================
vim.opt.timeout = true
vim.opt.timeoutlen = 300 -- Tempo (ms) para aguardar sequência de teclas (ajustar para popup do which-key)

-- ============================================================================
-- DIAGNÓSTICOS LSP
-- ============================================================================
-- Exibe texto virtual com mensagens de erro/warning ao lado da linha
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- ============================================================================
-- PROVIDERS EXTERNOS
-- ============================================================================
-- Desabilita providers não utilizados para evitar warnings no checkhealth
vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
