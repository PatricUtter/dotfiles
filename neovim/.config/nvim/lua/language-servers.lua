local lsp_installer = require("nvim-lsp-installer")

local function on_attach(_, bufnr)
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
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
end

local enhance_server_opts = {
	-- Provide settings that should only apply to the "eslintls" server
	--["eslintls"] = function(opts)
	--opts.settings = {
	--format = {
	--enable = true,
	--},
	--}
	--end,
	["sumneko_lua"] = function(opts)
		opts.settings = {
			Lua = {
				diagnostics = {
					globals = { "vim", "use" },
				},
			},
		}
	end,

	-- TODO: Seems to be broken at the momment, add back and try again when fixed https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils/issues/112
	--
	-- ["tsserver"] = function(opts)
	-- 	opts.init_options = require("nvim-lsp-ts-utils").init_options
	--
	-- 	opts.on_attach = function(client, bufnr)
	-- 		local ts_utils = require("nvim-lsp-ts-utils")
	-- 		print("ts attached")
	--
	-- 		-- defaults
	-- 		ts_utils.setup({
	-- 			debug = true,
	-- 			disable_commands = false,
	-- 			enable_import_on_completion = false,
	--
	-- 			-- import all
	-- 			import_all_timeout = 5000, -- ms
	-- 			-- lower numbers = higher priority
	-- 			import_all_priorities = {
	-- 				same_file = 1, -- add to existing import statement
	-- 				local_files = 2, -- git files or files with relative path markers
	-- 				buffer_content = 3, -- loaded buffer content
	-- 				buffers = 4, -- loaded buffer names
	-- 			},
	-- 			import_all_scan_buffers = 100,
	-- 			import_all_select_source = false,
	-- 			-- if false will avoid organizing imports
	-- 			always_organize_imports = true,
	--
	-- 			-- filter diagnostics
	-- 			filter_out_diagnostics_by_severity = {},
	-- 			filter_out_diagnostics_by_code = {},
	--
	-- 			-- inlay hints
	-- 			auto_inlay_hints = false,
	-- 			inlay_hints_highlight = "Comment",
	-- 			inlay_hints_priority = 200, -- priority of the hint extmarks
	-- 			inlay_hints_throttle = 150, -- throttle the inlay hint request
	-- 			inlay_hints_format = { -- format options for individual hint kind
	-- 				Type = {},
	-- 				Parameter = {},
	-- 				Enum = {},
	-- 				-- Example format customization for `Type` kind:
	-- 				-- Type = {
	-- 				--     highlight = "Comment",
	-- 				--     text = function(text)
	-- 				--         return "->" .. text:sub(2)
	-- 				--     end,
	-- 				-- },
	-- 			},
	--
	-- 			-- update imports on file move
	-- 			update_imports_on_move = true,
	-- 			require_confirmation_on_move = true,
	-- 			watch_dir = nil,
	-- 		})
	--
	-- 		-- required to fix code action ranges and filter diagnostics
	-- 		ts_utils.setup_client(client)
	--
	-- 		-- no default maps, so you may want to define some here
	-- 		-- local keyBindOpts = { silent = true }
	-- 		-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", keyBindOpts)
	-- 		-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", keyBindOpts)
	-- 		-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", keyBindOpts)
	-- 	end
	-- end,
}

lsp_installer.on_server_ready(function(server)
	-- Specify the default options which we'll use to setup all servers
	local opts = {
		on_attach = on_attach,
	}

	if enhance_server_opts[server.name] then
		-- Enhance the default opts with the server-specific ones
		enhance_server_opts[server.name](opts)
	end

	server:setup(opts)
end)
