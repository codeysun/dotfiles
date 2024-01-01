require("lualine").setup({
	options = {
		theme = "catppuccin",
		-- ... the rest of your lualine config
	},
})
-- local status, lualine = pcall(require, "lualine")
-- if not status then
-- 	return
-- end

-- get lualine nightfly theme
-- local lualine_nightfly = require("lualine.themes.nightfly")
-- local lualine_seoul256 = require("lualine.themes.seoul256")

-- new colors for theme
-- local new_colors = {
-- 	blue = "#65D1FF",
-- 	green = "#3EFFDC",
-- 	violet = "#FF61EF",
-- 	yellow = "#FFDA7B",
-- 	black = "#000000",
-- }

-- -- change nightlfy theme colors
-- lualine_nightfly.normal.a.bg = new_colors.blue
-- lualine_nightfly.insert.a.bg = new_colors.green
-- lualine_nightfly.visual.a.bg = new_colors.violet
-- lualine_nightfly.command = {
-- 	a = {
-- 		gui = "bold",
-- 		bg = new_colors.yellow,
-- 		fg = new_colors.black, -- black
-- 	},
-- }

-- local colors = require("seoul256/colors")
-- lualine_seoul256.command = {
-- 	a = {
-- 		gui = "bold",
-- 		bg = colors.yellow,
-- 		fg = colors.bg, -- black
-- 	},
-- }
--
-- lualine_seoul256.replace = {
-- 	a = {
-- 		gui = "bold",
-- 		bg = colors.purple,
-- 		fg = colors.bg, -- black
-- 	},
-- }
--
-- -- configure lualine with modified theme
-- lualine.setup({
-- 	options = {
-- 		theme = lualine_seoul256,
-- 	},
-- })
