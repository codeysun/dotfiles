-- Plugin for doing leetcode in nvim
return {
	"kawre/leetcode.nvim",
	build = ":TSUpdate html",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim", -- required by telescope
		"MunifTanjim/nui.nvim",

		-- optional
		"nvim-treesitter/nvim-treesitter",
		"rcarriga/nvim-notify",
		"nvim-tree/nvim-web-devicons",
	},
	lazy = "leetcode" ~= vim.fn.argv()[1],
	-- cmd = "Leet",
	opts = {
		-- configuration goes here
		arg = "leetcode",
		lang = "cpp",
	},
}
