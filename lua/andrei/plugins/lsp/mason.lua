return {
    "williamboman/mason.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
        local mason = require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = {
                "basedpyright",
                "volar",
                "tsserver",
                "rust_analyzer",
                "cssls",
                "tailwindcss",
            },
        })
    end
}
