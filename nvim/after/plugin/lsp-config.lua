local lspconfig = require("lspconfig")

--configure python server
lspconfig["pylsp"].setup({
    settings = {
        pylsp = {
            plugins = {
                pylint = { enabled = false },
                pyflakes = { enabled = false },
                pycodestyle = { 
                    enabled = false },
            }
        }
    }
})

