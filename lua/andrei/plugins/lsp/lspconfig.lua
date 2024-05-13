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

        local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
          opts = opts or {}
          opts.border = opts.border or border
          return orig_util_open_floating_preview(contents, syntax, opts, ...)
        end

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local opts = { buffer = ev.buf, silent = true }

                -- Definitions & References
                vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
                vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

                -- Actions
                vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>D", vim.lsp.buf.code_action, opts)

                -- Diagnostics
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

        local _border = "rounded"
        local border_apis = {{  "textDocument/hover", "hover" }, { "textDocument/signatureHelp", "signature_help" } }

        for i=1, #border_apis do
            local api = border_apis[i]
            vim.lsp.handlers[api[1]] = vim.lsp.with(
              vim.lsp.handlers[api[2]], {
                border = _border
              }
            )
        end

        vim.diagnostic.config{
          float={border=_border}
        }

        local capabilities = cmp_nvim_lsp.default_capabilities()

        local signs = { Error = "", Warn = "", Hint = "", Info = "" }
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
            lua_ls = function()
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                }
            end,
            tsserver = function()
                local vue_typescript_plugin = require('mason-registry')
                    .get_package('vue-language-server')
                    :get_install_path()
                    .. '/node_modules/@vue/language-server'
                    .. '/node_modules/@vue/typescript-plugin'

                lspconfig.tsserver.setup({
                    capabilities = capabilities,
                    init_options = {
                        plugins = {
                            {
                            name = "@vue/typescript-plugin",
                            location = vue_typescript_plugin,
                            languages = {'javascript', 'typescript', 'vue'}
                            },
                        }
                    },
                    filetypes = {
                        'javascript',
                        'javascriptreact',
                        'javascript.jsx',
                        'typescript',
                        'typescriptreact',
                        'typescript.tsx',
                        'vue',
                    },
                })
            end,
            basedpyright = function()
                lspconfig["basedpyright"].setup({
                    capabilities = capabilities,
                    settings = {
                        basedpyright = {
                            typeCheckingMode = "off",
                        },
                    },
                })
            end,
        })
    end
}
