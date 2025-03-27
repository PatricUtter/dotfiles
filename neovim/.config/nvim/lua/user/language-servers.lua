require("mason").setup()
require("mason-lspconfig").setup()

local function global_on_attach(_, bufnr)
	local opts = { noremap = true, silent = true }

	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gi", "<cmd> vim.lsp.buf.implementation()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<leader>gf",
		"<cmd>lua require('telescope.builtin').lsp_references({show_line = false})<CR>",
		opts
	)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async: true })<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<C>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "]g", "<cmd>lua vim.diagnostic.goto_next({ float: true })<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[g", "<cmd>lua vim.diagnostic.open_float({ float: true })<CR>", opts)
end

require("java").setup()

require("mason-lspconfig").setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup({
			on_attach = global_on_attach,
		})
	end,
	-- Next, you can provide a dedicated handler for specific servers.
	-- For example, a handler override for the `rust_analyzer`:
	["ts_ls"] = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

		require("typescript").setup({
			disable_commands = false, -- prevent the plugin from creating Vim commands
			debug = false, -- enable debug logging for commands
			go_to_source_definition = {
				fallback = true, -- fall back to standard LSP definition on failure
			},
			server = {
				-- pass options to lspconfig's setup method
				capabilities = capabilities,
				on_attach = global_on_attach,
			},
		})
	end,
	["lua_ls"] = function()
		require("lspconfig").lua_ls.setup({
			on_attach = global_on_attach,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim", "use" },
					},
				},
			},
		})
	end,
	["jdtls"] = function()
		require("lspconfig").jdtls.setup({
			on_attach = global_on_attach,
			settings = {
				java = {
					--"/home/utter/df-commons/**/*.java"
					-- {
					--     "java.project.referencedLibraries": [
					--         "lib/**/*.jar",
					--         "c:\\path\\to\\jarfile\\commons-logging-1.1.1.jar"
					--     ]
					-- }
					-- }
					project = {
						referencedLibraries = {
							"/home/utter/df-commons/build/libs/df-commons.jar",
						},
					},
					configuration = {
						runtimes = {
							{
								name = "JavaSE-21",
								path = "/home/utter/.sdkman/candidates/java/current/bin/java",
								default = true,
							},
						},
					},
				},
			},
		})
	end,
})
