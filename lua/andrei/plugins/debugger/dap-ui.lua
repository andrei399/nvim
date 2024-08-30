return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
    },
    config = function()
        local dap, dap_ui = require("dap"), require("dapui")

        dap_ui.setup({})

        dap.listeners.before.attach.dapui_config = function()
            dap_ui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dap_ui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dap_ui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dap_ui.close()
        end
    end
}
