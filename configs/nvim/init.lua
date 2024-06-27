require("config.lazy")
require("config.options")
require("config.keymaps")

-- Generally read .keymap files as C ones
vim.cmd([[autocmd BufNewFile,BufRead *.keymap setfiletype c]])
vim.cmd([[autocmd BufNewFile,BufRead *.overlay setfiletype c]])
