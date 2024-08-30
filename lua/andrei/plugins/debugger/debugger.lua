return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "jay-babu/mason-nvim-dap.nvim",
        "theHamsta/nvim-dap-virtual-text",
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
    end,
    keys = {{
        "<F5>",
        function()
            -- (Re-)reads launch.json if present
            if vim.fn.filereadable(".vscode/launch.json") then
                require("dap.ext.vscode").load_launchjs()
            end
            require("dap").continue()
        end,
        desc = "DAP Continue",
    }},
}
