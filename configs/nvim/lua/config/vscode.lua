-- VSCode/Cursor-specific setup when running inside vscode-neovim.
-- vim.g.vscode is set automatically by the extension.
local vscode = require("vscode")
local keymap = vim.keymap.set

-- Delegate to VS Code for features Neovim plugins would normally provide.
keymap("n", "<leader>e", function()
	vscode.action("workbench.view.explorer")
end, { desc = "Focus file explorer" })

keymap("n", "<leader>ff", function()
	vscode.action("workbench.action.quickOpen")
end, { desc = "Quick open file" })

keymap("n", "<leader>fg", function()
	vscode.action("workbench.action.findInFiles")
end, { desc = "Project search" })

keymap("n", "<leader>fb", function()
	vscode.action("workbench.action.showAllEditors")
end, { desc = "Buffer list" })

keymap("n", "<leader>F", function()
	vscode.action("editor.action.formatDocument")
end, { desc = "Format buffer" })

keymap("n", "<leader>gs", function()
	vscode.action("workbench.view.scm")
end, { desc = "Source control" })

keymap("n", "<leader>gc", function()
	vscode.action("git.commit")
end, { desc = "Git commit" })

keymap("n", "<leader>gp", function()
	vscode.action("git.pull")
end, { desc = "Git pull" })

keymap("n", "<leader>gP", function()
	vscode.action("git.push")
end, { desc = "Git push" })

keymap("n", "<leader>bd", function()
	vscode.action("workbench.action.closeActiveEditor")
end, { desc = "Close editor" })

-- Replace Navigator.nvim (tmux/window splits) with VS Code pane focus.
keymap("n", "<C-h>", function()
	vscode.action("workbench.action.focusLeftGroup")
end)
keymap("n", "<C-l>", function()
	vscode.action("workbench.action.focusRightGroup")
end)
keymap("n", "<C-k>", function()
	vscode.action("workbench.action.focusAboveGroup")
end)
keymap("n", "<C-j>", function()
	vscode.action("workbench.action.focusBelowGroup")
end)
