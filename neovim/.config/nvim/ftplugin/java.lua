local home = os.getenv("HOME")

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local workspace_dir = home .. "/workspace/" .. project_name

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
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

	-- Language server `initializationOptions`
	-- You need to extend the `bundles` with paths to jar files
	-- if you want to use additional eclipse.jdt.ls plugins.
	--
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
	init_options = {
		bundles = {},
	},

	on_attach = function(_, bufnr)
		local opts = { noremap = true, silent = true }
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gi", "<cmd> vim.lsp.buf.implementation()<CR>", opts)
		--vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
		--vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
		--vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
		--vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
		--vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gf', '<cmd> lua vim.lsp.buf.references()<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gf", "<cmd>Telescope lsp_references<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async: true })<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "]g", "<cmd>lua vim.diagnostic.goto_next({ float: true })<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "[g", "<cmd>lua vim.diagnostic.open_float({ float: true })<CR>", opts)

		local cmp = require("cmp")
		--- setup completion
		cmp.setup.buffer({
			mapping = {
				["<C-Up>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
				["<C-Down>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
				["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
				["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
				["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
				["<C-e>"] = cmp.mapping({
					i = cmp.mapping.abort(),
					c = cmp.mapping.close(),
				}),
				["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "buffer", max_item_count = 10 },
				{ name = "path", max_item_count = 5 },
				{ name = "luasnip" }, -- For luasnip users.
			}),
		})
	end,
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require("jdtls").start_or_attach(config)

-- vim.opt_local.shiftwidth = 2
-- vim.opt_local.tabstop = 2
-- vim.opt_local.cmdheight = 2 -- more space in the neovim command line for displaying messages
--
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
--
-- local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
-- if not status_cmp_ok then
--   return
-- end
-- capabilities.textDocument.completion.completionItem.snippetSupport = false
-- capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
--
-- local status, jdtls = pcall(require, "jdtls")
-- if not status then
--   return
-- end
--
-- -- Determine OS
-- local home = os.getenv "HOME"
-- if vim.fn.has "mac" == 1 then
--   WORKSPACE_PATH = home .. "/workspace/"
--   CONFIG = "mac"
-- elseif vim.fn.has "unix" == 1 then
--   WORKSPACE_PATH = home .. "/workspace/"
--   CONFIG = "linux"
-- else
-- end
--
-- -- Find root of project
-- local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
-- local root_dir = require("jdtls.setup").find_root(root_markers)
-- if root_dir == "" then
--   return
-- end
--
-- local extendedClientCapabilities = jdtls.extendedClientCapabilities
-- extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
--
-- local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
--
-- local workspace_dir = WORKSPACE_PATH .. project_name
--
-- JAVA_DAP_ACTIVE = true
--
-- local bundles = {}
--
-- if JAVA_DAP_ACTIVE then
--   vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.config/nvim/vscode-java-test/server/*.jar"), "\n"))
--   vim.list_extend(
--     bundles,
--     vim.split(
--       vim.fn.glob(
--         home .. "/.config/nvim/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
--       ),
--       "\n"
--     )
--   )
-- end
--
-- -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
-- local config = {
--   -- The command that starts the language server
--   -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
--   cmd = {
--
--     -- 💀
--     "java", -- or '/path/to/java11_or_newer/bin/java'
--     -- depends on if `java` is in your $PATH env variable and if it points to the right version.
--
--     "-Declipse.application=org.eclipse.jdt.ls.core.id1",
--     "-Dosgi.bundles.defaultStartLevel=4",
--     "-Declipse.product=org.eclipse.jdt.ls.core.product",
--     "-Dlog.protocol=true",
--     "-Dlog.level=ALL",
--     "-javaagent:" .. home .. "/.local/share/nvim/lsp_servers/jdtls/lombok.jar",
--     "-Xms1g",
--     "--add-modules=ALL-SYSTEM",
--     "--add-opens",
--     "java.base/java.util=ALL-UNNAMED",
--     "--add-opens",
--     "java.base/java.lang=ALL-UNNAMED",
--
--     -- 💀
--     "-jar",
--     vim.fn.glob(home .. "/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
--     -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
--     -- Must point to the                                                     Change this to
--     -- eclipse.jdt.ls installation                                           the actual version
--
--     -- 💀
--     "-configuration",
--     home .. "/.local/share/nvim/lsp_servers/jdtls/config_" .. CONFIG,
--     -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
--     -- Must point to the                      Change to one of `linux`, `win` or `mac`
--     -- eclipse.jdt.ls installation            Depending on your system.
--
--     -- 💀
--     -- See `data directory configuration` section in the README
--     "-data",
--     workspace_dir,
--   },
--
--   -- on_attach = require("user.lsp.handlers").on_attach,
--   capabilities = capabilities,
--
--   -- 💀
--   -- This is the default if not provided, you can remove it. Or adjust as needed.
--   -- One dedicated LSP server & client will be started per unique root_dir
--   root_dir = root_dir,
--
--   -- Here you can configure eclipse.jdt.ls specific settings
--   -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
--   -- or https://github.com/redhat-developer/vscode-java#supported-vs-code-settings
--   -- for a list of options
--   settings = {
--     java = {
--       -- jdt = {
--       --   ls = {
--       --     vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m"
--       --   }
--       -- },
--       eclipse = {
--         downloadSources = true,
--       },
--       configuration = {
--         updateBuildConfiguration = "interactive",
--       },
--       maven = {
--         downloadSources = true,
--       },
--       implementationsCodeLens = {
--         enabled = true,
--       },
--       referencesCodeLens = {
--         enabled = true,
--       },
--       references = {
--         includeDecompiledSources = true,
--       },
--       format = {
--         enabled = false,
--         -- settings = {
--         --   profile = "asdf"
--         -- }
--       },
--     },
--     signatureHelp = { enabled = true },
--     completion = {
--       favoriteStaticMembers = {
--         "org.hamcrest.MatcherAssert.assertThat",
--         "org.hamcrest.Matchers.*",
--         "org.hamcrest.CoreMatchers.*",
--         "org.junit.jupiter.api.Assertions.*",
--         "java.util.Objects.requireNonNull",
--         "java.util.Objects.requireNonNullElse",
--         "org.mockito.Mockito.*",
--       },
--     },
--     contentProvider = { preferred = "fernflower" },
--     extendedClientCapabilities = extendedClientCapabilities,
--     sources = {
--       organizeImports = {
--         starThreshold = 9999,
--         staticStarThreshold = 9999,
--       },
--     },
--     codeGeneration = {
--       toString = {
--         template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
--       },
--       useBlocks = true,
--     },
--   },
--
--   flags = {
--     allow_incremental_sync = true,
--   },
--
--   -- Language server `initializationOptions`
--   -- You need to extend the `bundles` with paths to jar files
--   -- if you want to use additional eclipse.jdt.ls plugins.
--   --
--   -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
--   --
--   -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
--   init_options = {
--     -- bundles = {},
--     bundles = bundles,
--   },
-- }
--
-- -- NOTE: issue with cmd height
-- -- config.handers["language/status"] = function() end
--
-- -- This starts a new client & server,
-- -- or attaches to an existing client & server depending on the `root_dir`.
-- require("jdtls").start_or_attach(config)
--
-- -- require('jdtls').setup_dap()
--
-- vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
-- vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)"
-- vim.cmd "command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()"
-- -- vim.cmd "command! -buffer JdtJol lua require('jdtls').jol()"
-- vim.cmd "command! -buffer JdtBytecode lua require('jdtls').javap()"
-- -- vim.cmd "command! -buffer JdtJshell lua require('jdtls').jshell()"
