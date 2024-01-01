local status_ok, jdtls = pcall(require, "jdtls")
if not status_ok then
	return
end

local jdtls_dir = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local config_dir = jdtls_dir .. "/config_linux"
local plugins_dir = jdtls_dir .. "/plugins/"
local path_to_jar = plugins_dir .. "org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar"

-- File types that signify a Java project's root directory. This will be
-- used by eclipse to determine what constitutes a workspace
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", ".idea" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
	print("no root dir found!!")
	return
end

-- eclipse.jdt.ls stores project specific data within a folder. If you are working
-- with multiple different projects, each project must use a dedicated data directory.
-- This variable is used to configure eclipse to use the directory name of the
-- current project found using the root_marker as the folder for project specific data.
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name
-- os.execute("mkdir " .. workspace_dir)

-- Helper function for creating keymaps
function nnoremap(rhs, lhs, bufopts, desc)
	bufopts.desc = desc
	vim.keymap.set("n", rhs, lhs, bufopts)
end

-- The on_attach function is used to set key maps after the language server
-- attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Regular Neovim LSP client keymappings
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	nnoremap("gD", vim.lsp.buf.declaration, bufopts, "Go to declaration")
	nnoremap("gd", vim.lsp.buf.definition, bufopts, "Go to definition")
	nnoremap("gi", vim.lsp.buf.implementation, bufopts, "Go to implementation")
	nnoremap("K", vim.lsp.buf.hover, bufopts, "Hover text")
	-- nnoremap("<C-k>", vim.lsp.buf.signature_help, bufopts, "Show signature")
	-- nnoremap("<space>wa", vim.lsp.buf.add_workspace_folder, bufopts, "Add workspace folder")
	-- nnoremap("<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts, "Remove workspace folder")
	-- nnoremap("<space>wl", function()
	-- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, bufopts, "List workspace folders")
	nnoremap("<space>D", vim.lsp.buf.type_definition, bufopts, "Go to type definition")
	nnoremap("<space>rn", vim.lsp.buf.rename, bufopts, "Rename")
	nnoremap("<space>ca", vim.lsp.buf.code_action, bufopts, "Code actions")
	vim.keymap.set(
		"v",
		"<space>ca",
		"<ESC><CMD>lua vim.lsp.buf.range_code_action()<CR>",
		{ noremap = true, silent = true, buffer = bufnr, desc = "Code actions" }
	)
	nnoremap("<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts, "Format file")

	-- Java extensions provided by jdtls
	-- nnoremap("<C-o>", jdtls.organize_imports, bufopts, "Organize imports")
	nnoremap("<space>ev", jdtls.extract_variable, bufopts, "Extract variable")
	nnoremap("<space>ec", jdtls.extract_constant, bufopts, "Extract constant")
	vim.keymap.set(
		"v",
		"<space>em",
		[[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
		{ noremap = true, silent = true, buffer = bufnr, desc = "Extract method" }
	)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Main config
local config = {
	flags = {
		debounce_text_changes = 80,
	},
	on_attach = on_attach, -- Pass keybindings
	root_dir = root_dir, -- Set root directory
	-- The command that starts the language server
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		-- The jar file is located where jdtls was installed. This will need to be updated
		-- to the location where you installed jdtls
		"-jar",
		path_to_jar,

		-- The configuration for jdtls is also placed where jdtls was installed. This will
		-- need to be updated depending on your environment
		"-configuration",
		config_dir,

		-- Use the workspace_folder
		"-data",
		workspace_dir,
	},

	-- Configure jdtls specific settings
	settings = {
		java = {},
	},

	capabilities = capabilities,

	handlers = {
		["language/status"] = function(_, result)
			-- Print or whatever.
		end,
		["$/progress"] = function(_, result, ctx)
			-- disable progress updates.
		end,
	},
}

-- Finally, start jdtls. This will run the language server using the configuration we specified,
-- setup the keymappings, and attach the LSP client to the current buffer
jdtls.start_or_attach(config)
