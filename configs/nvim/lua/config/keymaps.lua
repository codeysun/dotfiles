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

-- dap
local mason_dap = require("mason-nvim-dap")
local dap = require("dap")
local ui = require("dapui")
local dap_virtual_text = require("nvim-dap-virtual-text")

-- Dap Virtual Text
dap_virtual_text.setup()

mason_dap.setup({
    ensure_installed = { "codelldb" },
    automatic_installation = true,
    handlers = {
        function(config)
            require("mason-nvim-dap").default_setup(config)
        end,
    },
})

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = "codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"
    args = {"--port", "${port}"},
  }
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

local project_config = vim.fn.getcwd() .. "/.nvim.lua"
if vim.fn.filereadable(project_config) == 1 then
  dofile(project_config)
end

-- Dap Keybindings
vim.keymap.set('n', '<Leader>db', '<cmd>DapToggleBreakpoint<cr>', { desc = "Toggle breakpoint" })
vim.keymap.set('n', '<Leader>dn', '<cmd>DapNew<cr>', { desc = "Launch new debug session" })
vim.keymap.set('n', '<Leader>dc', '<cmd>DapContinue<cr>', { desc = "Continue debug execution" })
vim.keymap.set('n', '<Leader>dx', '<cmd>DapTerminate<cr>', { desc = "Terminate debug session" })
vim.keymap.set('n', '<Leader>d<Down>', '<cmd>DapStepOver<cr>', { desc = "Step over function" })
vim.keymap.set('n', '<Leader>d<Right>', '<cmd>DapStepInto<cr>', { desc = "Step into function" })
vim.keymap.set('n', '<Leader>d<Left>', '<cmd>DapStepOut<cr>', { desc = "Step out of function" })
vim.keymap.set('n', '<Leader>d<Up>', '<cmd>DapRestartFrame<cr>', { desc = "Restart frame" })

-- Dap UI
ui.setup({
    layouts = { {
        elements = { {
            id = "scopes",
            size = 0.25
        }, {
            id = "breakpoints",
            size = 0.25
        }, {
            id = "stacks",
            size = 0.25
        }, {
            id = "watches",
            size = 0.25
        } },
        position = "left",
        size = 30
    }, {
        elements = { {
            id = "repl",
            size = 0.25
        }, {
            id = "console",
            size = 0.25
        } },
        position = "bottom",
        size = 10
    } }
})

-- vim.fn.sign_define("DapBreakpoint", { text = "🚩" })
-- vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "error", linehl = "", numhl = "" })
-- vim.fn.sign_define("DapBreakpointCondition", { text = "●", texthl = "@character", linehl = "", numhl = "" })
-- vim.fn.sign_define("DapLogPoint", { text = "●", texthl = "@type", linehl = "", numhl = "" })
-- vim.fn.sign_define("DapBreakpointRejected", { text = "●", texthl = "@function", linehl = "", numhl = "" })

dap.listeners.before.attach.dapui_config = function()
    ui.open()
end
dap.listeners.before.launch.dapui_config = function()
    ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    ui.close()
end

-- Dap UI

vim.keymap.set('n', '<Leader>dt', function () ui.toggle({ reset = true }) end, { desc = "Toggle debugger windows" })

local dap_cpp = require("codey.debug.dap-cpp")
        dap.adapters.lldb = dap_cpp.lldb_adapter
local dap_utils = require("codey.debug.utils")
dap_utils.register_debug_kind("cpp", dap_cpp.new_cpp_debug_config)
dap_utils.make_commands() -- add :LaunchDebug and :LaunchDebugLast
