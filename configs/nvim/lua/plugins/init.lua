return {

	{ "nvim-lua/plenary.nvim", lazy = true },

	------------ QoL functions -------------

	-- tmux & split window navigation
	{
		"numToStr/Navigator.nvim",
		config = true,
	},
	"szw/vim-maximizer", -- maximizes and restores current window

	-- essential plugins
	"tpope/vim-surround",
	"vim-scripts/ReplaceWithRegister",

	-- undo tree
	"mbbill/undotree",

	-- git integration
	{ "lewis6991/gitsigns.nvim", config = true }, -- show line modifications on left hand side
	"f-person/git-blame.nvim", -- see who added what
	{
		"NeogitOrg/neogit",
		cmd = "Neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed, not both.
			"nvim-telescope/telescope.nvim", -- optional
		},
		config = true,
	},

	------------ LSP -------------

	-- LSP Zero
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ -- Optional
				"williamboman/mason.nvim",
				build = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "hrsh7th/cmp-cmdline" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "rafamadriz/friendly-snippets" },
			{ "L3MON4D3/LuaSnip" }, -- Required
		},
	},

	{
		"glepnir/lspsaga.nvim",
		branch = "main",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},

	-- enhanced lsp uis
	"onsails/lspkind.nvim", -- vs-code like icons for autocompletion

	------------ Keymaps -------------

	-- repeat
	"tpope/vim-repeat",

	-- leap
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").create_default_mappings()
		end,
	},

	------------ Cosmetics -------------

	-- vs-code like icons
	"nvim-tree/nvim-web-devicons",

	-- Tint active window
	{
		"levouh/tint.nvim",
		config = true,
	},

	------------ Language -------------

	-- nvim-jdtls (Java lsp)
	"mfussenegger/nvim-jdtls",

	"mfussenegger/nvim-dap",
}
