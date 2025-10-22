--[[
  core/init.lua
  Módulo principal que centraliza as configurações essenciais do editor.
  Carrega os módulos na ordem correta para garantir funcionamento adequado.
--]]

-- Configurações do editor (leader, UI, diagnósticos)
require("vim-options")

-- Keymaps essenciais (não específicos de plugins)
pcall(require, "core.keymaps")

-- Autocomandos (automações do editor)
pcall(require, "core.autocmds")
