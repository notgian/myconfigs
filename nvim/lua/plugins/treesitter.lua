return {
    { 
        "nvim-treesitter/nvim-treesitter", 
        build = ":TSUpdate",
        config = function ()
            vim.filetype.add({ extension = { ejs = "ejs" } })
            vim.treesitter.language.register("html", "ejs")
            vim.treesitter.language.register("javascript", "ejs")
            vim.treesitter.language.register("embedded_template", "ejs") 
        end
    },
}
