return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	lazy = false,
	config = function()
		-- import mason
		local mason = require("mason")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- ts/js formatter
				"stylua", -- lua formatter
				"clang-format",
				"isort",
				"black", -- python formatter
				"cpplint",
				"pylint",
				"yamlfmt",
				"yamllint",
				"latexindent",
			},
		})
	end,
}
