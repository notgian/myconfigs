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
            }

            for i in pairs(lspList) do
                vim.lsp.config[lspList[i]].capabilities = capabilities
                vim.lsp.enable(lspList[i])
            end

            vim.diagnostic.enable = true
            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
            })

            vim.lsp.enable('jdtls')


        end
    }
}
