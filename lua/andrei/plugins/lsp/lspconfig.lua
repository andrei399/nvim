return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true},
        -- { "folkle/neodev.nvim", opts = {} },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local mason_lspconfig = require("mason-lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local opts = { buffer = ev.buf, silent = true }
                vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
                vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
                vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
                vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>D", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)

                -- local diagnostic_signs = {
                --     [vim.diagnostic.severity.ERROR] = "",
                --     [vim.diagnostic.severity.WARN] = "",
                --     [vim.diagnostic.severity.INFO] = "",
                --     [vim.diagnostic.severity.HINT] = "",
                -- }
                --
                -- vim.diagnostic.config({
                --     virtual_text = {
                --         sign = false,
                --         prefix = function(diagnostic)
                --             return diagnostic_signs[diagnostic.severity] -- fucking lifesaving
                --         end
                --     },
                --     underline = true,
                --     signs = { text = diagnostic_signs },
                -- })
            end,
        })

        local capabilities = cmp_nvim_lsp.default_capabilities()

        local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        mason_lspconfig.setup_handlers({
            function(server_name)
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                })
            end,
            ["tsserver"] = function()
                local vue_typescript_plugin = require("mason-registry")
                    .get_package("vue-language-server"):get_install_path()
                    .. "/node_modules/@vue/language-server"
                    -- .. "/node_modules/@vue/typescript-plugin"
                print(vue_typescript_plugin)

                lspconfig["tsserver"].setup({
                    capabilities=capabilities,
                    init_options = {
                        plugins = {
                            {
                                name = "@vue/typescript-plugin",
                                location = vue_typescript_plugin,
                                languages = {"javascript", "typescript", "vue"}
                            },
                        }
                    },
                    filetypes = {
                        "javascript",
                        "javascriptreact",
                        "javascript.jsx",
                        "typescript",
                        "typescriptreact",
                        "typescript.tsx",
                        "vue",
                    },
                })
            end,
            ["basedpyright"] = function()
                lspconfig["basedpyright"].setup({
                    capabilities = capabilities,
                    settings = {
                        analysis = {
                            typeCheckingMode = "off",
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                        },
                    },
                    filetypes = { "python" }
                })
            end
        })
    end
}
