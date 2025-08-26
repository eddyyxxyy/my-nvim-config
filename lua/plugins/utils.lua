return {
    -- Automatically apply project-specific settings from .editorconfig files
    { "gpanders/editorconfig.nvim", event = "BufReadPre" },

    -- Automatically detect indentation style for projects without an .editorconfig
    { "tpope/vim-sleuth",           event = "BufReadPre" },
}
