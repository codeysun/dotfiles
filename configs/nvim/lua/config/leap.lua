-- Leap keymaps that leave operator-pending `s` free for nvim-surround (ys/cs/ds)
-- and visual `S`/`gS` free for surround. See leap.nvim discussion #41.
local M = {}

function M.setup_keymaps()
	vim.keymap.set("n", "s", "<Plug>(leap-forward)")
	vim.keymap.set("n", "S", "<Plug>(leap-backward)")
	vim.keymap.set({ "n", "x" }, "gs", "<Plug>(leap-from-window)")
	vim.keymap.set({ "x", "o" }, "x", "<Plug>(leap-forward-x)")
	vim.keymap.set({ "x", "o" }, "X", "<Plug>(leap-backward)")
end

return M
