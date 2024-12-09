vim.g.mapleader = " " -- default mapleader is \
vim.g.maplocalleader = " "

local keymap = vim.keymap -- for conciseness

-- general keymaps

-- remap $ and ^
keymap.set("n", "H", "^")
keymap.set("n", "L", "$")
keymap.set("v", "H", "^")
keymap.set("v", "L", "$")

-- move visual block
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keep cursor in the middle
keymap.set("n", "J", "mzJ`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- paste without yanking
keymap.set("x", "<leader>p", [["_dP]])

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sh", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sv", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize windows" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close split window" }) -- close current split window

-- keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "New tab" }) -- open new tab
-- keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close tab" }) -- close current tab
-- keymap.set("n", "<leader>l", ":tabn<CR>", { desc = "Next tab" }) --  go to next tab
-- keymap.set("n", "<leader>h", ":tabp<CR>", { desc = "Prev tab" }) --  go to previous tab
keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Delete buffer" }) --  go to next buffer
-- keymap.set("n", "<leader>l", ":bn<CR>", { desc = "Next buffer" }) --  go to next buffer
-- keymap.set("n", "<leader>h", ":bp<CR>", { desc = "Prev buffer" }) --  go to previous buffer

-- plugin keymaps

-- navigator
keymap.set({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>")
keymap.set({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>")
keymap.set({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>")
keymap.set({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>")
-- keymap.set({'n', 't'}, '<A-p>', '<CMD>NavigatorPrevious<CR>')

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", { desc = "Toggle window maximization" }) -- toggle split window maximization

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer

-- telescope
local builtin = require("telescope.builtin")
keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find grep string" })
keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })
keymap.set("n", "<leader>fs", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Find grep string under cursor" })

-- undotree
keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undo tree" })

-- notify
local notify = require("notify")
keymap.set("n", "<leader>nn", notify.dismiss, { desc = "Dismiss notification" })

-- git
local neogit = require("neogit")

keymap.set("n", "<leader>gs", neogit.open, { noremap = true, desc = "Git status" })
keymap.set("n", "<leader>gc", ":Neogit commit<CR>", { noremap = true, desc = "Git commit" })
keymap.set("n", "<leader>gp", ":Neogit pull<CR>", { noremap = true, desc = "Git pull" })
keymap.set("n", "<leader>gP", ":Neogit push<CR>", { noremap = true, desc = "Git push" })
keymap.set("n", "<leader>gb", ":GitBlameToggle<CR>", { noremap = true, desc = "Toggle git blame" })
