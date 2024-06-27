return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {

		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-cmdline",
		{ "L3MON4D3/LuaSnip" },
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
		"onsails/lspkind.nvim",
	},
	config = function()
		-- Here is where you configure the autocompletion settings.
		local lsp_zero = require("lsp-zero")
		lsp_zero.extend_cmp()

		-- And you can configure cmp even more, if you want to.
		local cmp = require("cmp")
		local cmp_action = lsp_zero.cmp_action()

		local lspkind = require("lspkind")

		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			}),
			-- configure lspkind for vs-code like icons
			formatting = {
				format = lspkind.cmp_format({
					maxwidth = 50,
					ellipsis_char = "...",
				}),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-f>"] = cmp_action.luasnip_jump_forward(),
				["<C-b>"] = cmp_action.luasnip_jump_backward(),
			}),
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
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
	end,
}
