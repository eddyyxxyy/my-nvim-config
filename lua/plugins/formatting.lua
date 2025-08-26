return {
    {
        "nvimtools/none-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    -- Formatters
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.formatting.goimports,

                    -- Linters
                    null_ls.builtins.diagnostics.eslint_d,
                },
            })

            -- Keymap for manual formatting
            vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format buffer" })
        end,
    },
}
