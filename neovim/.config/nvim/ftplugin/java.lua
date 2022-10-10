-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local home = os.getenv("HOME")
local workspace_dir = home .. "/workspace/" .. project_name

-- This bundles definition is the same as in the previous section (java-debug installation)
-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
--
local config = {
	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {

		-- 💀
		"java", -- or '/path/to/java17_or_newer/bin/java'
		-- depends on if `java` is in your $PATH env variable and if it points to the right version.

		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		-- 💀
		"-jar",
		vim.fn.glob(home .. "/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
		-- Must point to the                                                     Change this to
		-- eclipse.jdt.ls installation                                           the actual version

		-- 💀
		"-configuration",
		vim.fn.glob(home .. "/.local/share/nvim/lsp_servers/jdtls/config_linux"),
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
		-- Must point to the                      Change to one of `linux`, `win` or `mac`
		-- eclipse.jdt.ls installation            Depending on your system.

		-- 💀
		-- See `data directory configuration` section in the README
		"-data",
		workspace_dir,
	},

	-- 💀
	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- One dedicated LSP server & client will be started per unique root_dir
	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {},
	},

	on_attach = function(_, bufnr)
		local opts = { noremap = true, silent = true }
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gi", "<cmd> vim.lsp.buf.implementation()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			"<leader>wr",
			"<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
			opts
		)
		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			"<leader>wl",
			"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
			opts
		)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gf", "<cmd>Telescope lsp_references<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "]g", "<cmd>lua vim.diagnostic.goto_next({ float = true })<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "[g", "<cmd>lua vim.diagnostic.open_float({ float = true })<CR>", opts)

		-- add some additional commands
		require("jdtls.setup").add_commands()
		require("jdtls").setup_dap({ hotcodereplace = "auto" })
		require("jdtls.dap").setup_dap_main_class_configs()
	end,
}

local bundles = {
	vim.fn.glob(
		home .. "/java/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
	),
}

vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/java/vscode-java-test/server/*.jar"), "\n"))

-- Language server `initializationOptions`
-- You need to extend the `bundles` with paths to jar files
-- if you want to use additional eclipse.jdt.ls plugins.
--
-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
config["init_options"] = {
	bundles = bundles,
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require("jdtls").start_or_attach(config)
