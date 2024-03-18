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
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- window management
keymap.set("n", "<leader>sh", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sv", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>l", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>h", ":tabp<CR>") --  go to previous tab

-- plugin keymaps

-- navigator
keymap.set({ "n", "t" }, "<C-Left>", "<CMD>NavigatorLeft<CR>")
keymap.set({ "n", "t" }, "<C-Right>", "<CMD>NavigatorRight<CR>")
keymap.set({ "n", "t" }, "<C-Up>", "<CMD>NavigatorUp<CR>")
keymap.set({ "n", "t" }, "<C-Down>", "<CMD>NavigatorDown<CR>")
-- keymap.set({'n', 't'}, '<A-p>', '<CMD>NavigatorPrevious<CR>')

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer

-- telescope
local builtin = require("telescope.builtin")
keymap.set("n", "<leader>ff", builtin.find_files, {})
keymap.set("n", "<leader>fg", builtin.live_grep, {})
keymap.set("n", "<leader>fb", builtin.buffers, {})
keymap.set("n", "<leader>fh", builtin.help_tags, {})
keymap.set("n", "<leader>fs", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
keymap.set("n", "<leader>fh", builtin.help_tags, {})

-- undotree
keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- notify
local notify = require("notify")
keymap.set("n", "<leader>nn", notify.dismiss, {})

-- git
local neogit = require("neogit")

keymap.set("n", "<leader>gs", neogit.open, { noremap = true })
keymap.set("n", "<leader>gc", ":Neogit commit<CR>", { noremap = true })
keymap.set("n", "<leader>gp", ":Neogit pull<CR>", { noremap = true })
keymap.set("n", "<leader>gP", ":Neogit push<CR>", { noremap = true })
keymap.set("n", "<leader>gb", ":GitBlameToggle<CR>", { noremap = true })
