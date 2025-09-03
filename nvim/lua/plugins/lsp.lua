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
            local lspconfig = require('lspconfig')

            lspconfig['lua_ls'].setup({ capabilities = capabilities })
            lspconfig['ccls'].setup({ capabilities = capabilities })
            lspconfig['gopls'].setup({ capabilities = capabilities })
            lspconfig['pylsp'].setup({ capabilities = capabilities })
            lspconfig['rust_analyzer'].setup({ capabilities = capabilities })

            vim.diagnostic.enable = true
            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
            })

        end
    }
}
