-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " " -- default mapleader is \
vim.g.maplocalleader = " "

local function in_vscode()
	return vim.g.vscode == 1 or vim.g.vscode == true
end

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- Shared plugins (motions, surround, which-key, …)
		{ import = "plugins.always" },
		-- Full Neovim-only stack (UI, LSP, completion, DAP, …)
		{ import = "plugins", cond = function()
			return not in_vscode()
		end },
		{ import = "plugins.lsp", cond = function()
			return not in_vscode()
		end },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "rose-pine" } },
	-- automatically check for plugin updates
	checker = { enabled = true, notify = false },
})
