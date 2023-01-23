-- nvim-cmp
local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = {
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
	-- Globally used sources
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer", max_item_count = 10 },
		{ name = "path", max_item_count = 5 },
	}),
	experimental = {
		native_menu = false,
		ghost_text = true,
	},
})

cmp.setup.filetype({ "lua" }, {
	sources = cmp.config.sources({
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "buffer", max_item_count = 10 },
		{ name = "path", max_item_count = 5 },
	}),
})

cmp.setup.filetype({ "ts" }, {
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer", max_item_count = 10 },
		{ name = "path", max_item_count = 5 },
	}),
})


cmp.setup.cmdline("/", {
	sources = {
		{ name = "path", max_item_count = 5 },
		{ name = "buffer" },
	},
})

--Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

cmp.setup({
	enabled = function()
		return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
	end,
})

cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
	sources = {
		{ name = "dap" },
	},
})

-- Setup lspconfig.
-- Not sure what I get out of this TBH
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
require("lspconfig")["sumneko_lua"].setup({
	capabilities = capabilities,
})
require("lspconfig")["dockerls"].setup({
	capabilities = capabilities,
})
require("lspconfig")["jsonls"].setup({
	capabilities = capabilities,
})
require("lspconfig")["yamlls"].setup({
	capabilities = capabilities,
})
require("lspconfig")["html"].setup({
	capabilities = capabilities,
})
require("lspconfig")["tailwindcss"].setup({
	capabilities = capabilities,
})
require("lspconfig")["marksman"].setup({
	capabilities = capabilities,
})
