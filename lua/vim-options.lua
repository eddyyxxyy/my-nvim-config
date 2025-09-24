-- Set the leader key before any keymaps are defined
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Default indentation settings (will be overridden by editorconfig/sleuth)
vim.opt.tabstop = 4      -- Number of visual spaces per <Tab>
vim.opt.shiftwidth = 4   -- Number of spaces for indentation operations
vim.opt.softtabstop = 4  -- Number of spaces inserted for a <Tab> in insert mode
vim.opt.expandtab = true -- Use spaces instead of tab characters

-- General quality-of-life settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enable persistent undo file
vim.opt.undofile = true

-- which-key responsiveness
vim.opt.timeout = true
vim.opt.timeoutlen = 300 -- ms: ajuste se quiser o popup mais lento/rápido

-- Display virtual text for diagnostics
vim.diagnostic.config({
  virtual_text = true,
})

-- Disable unused external providers to silence health warnings (can re-enable later)
vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
