-- Plugins safe to load in both Neovim and VSCode/Cursor (via vscode-neovim).
-- UI/LSP/completion/debug plugins belong in the other plugin files and are
-- skipped in VSCode — see lua/config/lazy.lua.
return {
	{ "nvim-lua/plenary.nvim", lazy = true },

	{
		"kylechui/nvim-surround",
		version = "*",
		keys = {
			{ "ys", mode = "n" },
			{ "cs", mode = "n" },
			{ "ds", mode = "n" },
			{ "S", mode = "x" },
			{ "gS", mode = "x" },
		},
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	"vim-scripts/ReplaceWithRegister",
	"tpope/vim-repeat",

	{
		url = "https://codeberg.org/andyg/leap.nvim",
		config = function()
			require("config.leap").setup_keymaps()
		end,
	},

	{ "lewis6991/gitsigns.nvim", config = true },

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
}
