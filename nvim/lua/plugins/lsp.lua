return {
    {
        "https://github.com/neovim/nvim-lspconfig",
        dependencies = {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            local lspList = {
                'lua_ls',
                'ccls',
                'gopls',
                'pylsp',
                'rlangserver'
            }

            for i in pairs(lspList) do
                vim.lsp.config[lspList[i]].capabilities = capabilities
                vim.lsp.enable(lspList[i])
            end

            vim.diagnostic.enable = true
            vim.diagnostic.config({

                virtual_lines = {
                    severity = vim.diagnostic.severity.ERROR,
                },
                virtual_text = {
                    severity = vim.diagnostic.severity.WARN,
                    current_line = true
                },
                underline = {
                    severity = vim.diagnostic.severity.WARN
                },
                signs = true,
                update_in_insert = true
            })

            vim.lsp.enable('jdtls')


        end
    }
}
