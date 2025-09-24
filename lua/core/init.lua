-- Core module: centralizes base config without changing current behavior
-- This file only requires existing modules in the right order.

-- 1) Editor options (leader, UI, diagnostic):
require("vim-options")

-- 2) Placeholders for future organization (no-ops now):
--    Keep these requires even if files are empty, to establish a stable layout.
pcall(require, "core.keymaps")
pcall(require, "core.autocmds")
