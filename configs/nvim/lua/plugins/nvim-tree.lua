return {}
-- -- file explorer
-- return {
-- 	"nvim-tree/nvim-tree.lua",
-- 	dependencies = "nvim-tree/nvim-web-devicons",
-- 	config = function()
-- 		-- recommended settings from nvim-tree documentation
-- 		vim.g.loaded = 1
-- 		vim.g.loaded_netrwPlugin = 1
--
-- 		require("nvim-tree").setup({
-- 			view = {
-- 				width = 35,
-- 				relativenumber = true,
-- 			},
-- 			-- disable window_picker for
-- 			-- explorer to work well with
-- 			-- window splits
-- 			actions = {
-- 				open_file = {
-- 					window_picker = {
-- 						enable = false,
-- 					},
-- 				},
-- 			},
-- 			filters = {
-- 				custom = { ".DS_Store" },
-- 			},
-- 			git = {
-- 				ignore = false,
-- 			},
-- 		})
-- 	end,
-- }
