--[[
  init.lua
  Ponto de entrada principal da configuração do Neovim
  Inicializa o lazy.nvim e carrega módulos core e plugins
--]]

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Instalar lazy.nvim automaticamente se não existir
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- Última versão estável
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-- Opções do lazy.nvim (rocks desabilitado para melhor performance)
local opts = { rocks = { enabled = false } }

-- Carregar configurações essenciais e plugins
require("core")
require("lazy").setup("plugins", opts)
