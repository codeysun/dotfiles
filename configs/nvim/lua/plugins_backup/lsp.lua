local lsp = require("lsp-zero").preset({})

lsp.on_attach(function(client, bufnr)
	-- lsp.default_keymaps({
	-- 	buffer = bufnr,
	-- 	preserve_mappings = false,
	-- })

	local opts = { buffer = bufnr, remap = true }

	-- set keybinds
	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "gi", function()
		vim.lsp.buf.implementation()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>vca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>vrr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>vrn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
end)

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"clangd",
		"ltex",
		-- "jedi_language_server",
		"pyright",
		"yamlls",
		"jdtls",
		-- "matlab-ls",
	},

	automatic_installation = true,
})
require("mason-null-ls").setup({
	-- list of formatters & linters for mason to install
	ensure_installed = {
		"prettier", -- ts/js formatter
		"stylua", -- lua formatter
		"clang-format",
		"black", -- python formatter
		"cpplint",
		"pylint",
		"yamlfmt",
		"yamllint",
		"latexindent",
	},
	-- auto-install configured formatters & linters (with null-ls)
	automatic_installation = true,
})

local on_attach = function(_, _) end

require("lspconfig").lua_ls.setup({})

-- (Optional) Configure lua language server for neovim
require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

require("lspconfig").clangd.setup({
	on_attach = on_attach,
	capabilities = { offsetEncoding = { "utf-16" } },
	cmd = {
		"clangd",
		"--offset-encoding=utf-16",
	},
})

lsp.skip_server_setup({ "jdtls" }) -- Skip jdtls bc we use nvim-jdtls instead

lsp.setup()

-- You need to setup `cmp` after lsp-zero
local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()

local lspkind = require("lspkind")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "buffer", keyword_length = 3 },
		{ name = "luasnip", keyword_length = 2 },
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
		["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
		["<C-e>"] = cmp.mapping.abort(), -- close completion window
		["<CR>"] = cmp.mapping.confirm({ select = false }),
	}),

	-- configure lspkind for vs-code like icons
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 50,
			ellipsis_char = "...",
		}),
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline({
		["<C-j>"] = {
			c = function()
				local cmp = require("cmp")
				if cmp.visible() then
					cmp.select_next_item()
				else
					cmp.complete()
				end
			end,
		},
		["<C-k>"] = {
			c = function()
				local cmp = require("cmp")
				if cmp.visible() then
					cmp.select_prev_item()
				else
					cmp.complete()
				end
			end,
		},
		["<Tab>"] = {
			c = function(fallback)
				local cmp = require("cmp")
				if cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end,
		},
		["<S-Tab>"] = {
			c = function(fallback)
				local cmp = require("cmp")
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end,
		},
		["<C-e>"] = {
			c = cmp.mapping.abort(),
		},
		["<CR>"] = {
			c = cmp.mapping.confirm({ select = false }),
		},
	}),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
