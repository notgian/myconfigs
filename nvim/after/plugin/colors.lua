function Colors(color)
	color = color or "tokyonight-moon"
	vim.cmd.colorscheme(color)

	vim.cmd [[
		highlight Normal guibg=none
		highlight NonText guibg=none
		highlight Normal ctermbg=none
		highlight NonText ctermbg=none
	]]
end

Colors()
