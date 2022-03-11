-- Telescope
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-k>"] = require("telescope.actions").move_selection_previous,
				["<C-j>"] = require("telescope.actions").move_selection_next,
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})
require("telescope").load_extension("fzf")

-- nvim-cmp
local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = {
		["<C-p>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-n>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
		["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "cmdline" },
		{ name = "luasnip" }, -- For luasnip users.
	}),
})

-- Set configuration for specific filetype.
--cmp.setup.filetype('gitcommit', {
--  sources = cmp.config.sources({
--    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
--  }, {
--    { name = 'buffer' },
--  })
--})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require("lspconfig")["sumneko_lua"].setup({
	capabilities = capabilities,
})

-- Treesitter
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

-- Null ls
require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.code_actions.gitsigns,
	},
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
		end
	end,
})

-- Gitsigns
require("gitsigns").setup({
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Actions
		map("n", "<leader>hb", function()
			gs.blame_line({ full = true })
		end)
		map("n", "<leader>tb", gs.toggle_current_line_blame)
	end,
})
