return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "jay-babu/mason-nvim-dap.nvim",
    },
    event = "VeryLazy",
    config = function()
        require("mason-nvim-dap").setup({
            ensure_installed = { "python" },
            handlers = {},
        })

        local dap = require("dap")

        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
        vim.keymap.set("n", "<leader>dc", dap.continue)
    end
}
