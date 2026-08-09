require("config.lazy")
require("config.options")
require("config.keymaps")

if vim.g.vscode then
	require("config.vscode")
else
	-- Generally read .keymap files as C ones
	vim.cmd([[autocmd BufNewFile,BufRead *.keymap setfiletype c]])
	vim.cmd([[autocmd BufNewFile,BufRead *.overlay setfiletype c]])

	vim.diagnostic.config({
		virtual_text = false,
		signs = true,
		underline = true,
		update_in_insert = false,
		float = { border = "rounded", source = true },
		severity_sort = true,
	})
end
