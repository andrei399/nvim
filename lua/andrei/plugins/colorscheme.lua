return {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            semantic_tokens = true,
            integrations = {
                cmp = true,
                gitsigns = true,
                treesitter = true,
                mason = true,
                rainbow_delimiters = true,
                harpoon = true,
                lightspeed = true,
            },
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { "italic" },
                    hints = { "italic" },
                    warnings = { "italic" },
                    information = { "italic" },
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                },
                inlay_hints = {
                    background = true,
                },
            },
        })
        vim.cmd("colorscheme catppuccin-mocha")
    end
}
