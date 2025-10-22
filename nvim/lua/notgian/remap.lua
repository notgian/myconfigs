-- Setting Leader key
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- attempting to make shortcut to yank into system register
vim.keymap.set("n", "<S-Y>", '"+y')

