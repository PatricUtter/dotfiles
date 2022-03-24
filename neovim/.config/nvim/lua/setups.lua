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

-- luasnip

local ls = require("luasnip")

ls.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
})

vim.keymap.set({ "i", "s" }, "<c-k>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { noremap = true, silent = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { noremap = true, silent = true })

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
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "buffer", max_item_count = 10 },
		{ name = "path", max_item_count = 5 },
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
require("lspconfig")["tsserver"].setup({
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

-- nvim-tree
require("nvim-tree").setup({
	disable_netrw = false,
	hijack_netrw = true,
	open_on_setup = false,
	ignore_buffer_on_setup = false,
	ignore_ft_on_setup = {},
	auto_close = false,
	auto_reload_on_write = true,
	open_on_tab = false,
	hijack_cursor = false,
	update_cwd = false,
	hijack_unnamed_buffer_when_opening = false,
	hijack_directories = {
		enable = true,
		auto_open = true,
	},
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	update_focused_file = {
		enable = false,
		update_cwd = false,
		ignore_list = {},
	},
	system_open = {
		cmd = nil,
		args = {},
	},
	filters = {
		dotfiles = false,
		custom = {},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	view = {
		width = 30,
		height = 30,
		hide_root_folder = false,
		side = "left",
		preserve_window_proportions = false,
		mappings = {
			custom_only = false,
			list = {},
		},
		number = false,
		relativenumber = false,
		signcolumn = "yes",
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
	actions = {
		change_dir = {
			enable = true,
			global = false,
		},
		open_file = {
			quit_on_open = false,
			resize_window = false,
			window_picker = {
				enable = true,
				chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
				exclude = {
					filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
					buftype = { "nofile", "terminal", "help" },
				},
			},
		},
	},
	log = {
		enable = false,
		types = {
			all = false,
			config = false,
			git = false,
		},
	},
})

-- Lualine
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})

-- Todo comments

require("todo-comments").setup({
	{
		signs = true, -- show icons in the signs column
		sign_priority = 8, -- sign priority
		-- keywords recognized as todo comments
		keywords = {
			FIX = {
				icon = " ", -- icon used for the sign, and in search results
				color = "error", -- can be a hex color, or a named color (see below)
				alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
				-- signs = false, -- configure signs for some keywords individually
			},
			TODO = { icon = " ", color = "info" },
			HACK = { icon = " ", color = "warning" },
			WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
			PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
			NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
		},
		merge_keywords = true, -- when true, custom keywords will be merged with the defaults
		-- highlighting of the line containing the todo comment
		-- * before: highlights before the keyword (typically comment characters)
		-- * keyword: highlights of the keyword
		-- * after: highlights after the keyword (todo text)
		highlight = {
			before = "", -- "fg" or "bg" or empty
			keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
			after = "fg", -- "fg" or "bg" or empty
			pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
			comments_only = true, -- uses treesitter to match keywords in comments only
			max_line_len = 400, -- ignore lines longer than this
			exclude = {}, -- list of file types to exclude highlighting
		},
		-- list of named colors where we try to extract the guifg from the
		-- list of hilight groups or use the hex color if hl not found as a fallback
		colors = {
			error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
			warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
			info = { "DiagnosticInfo", "#2563EB" },
			hint = { "DiagnosticHint", "#10B981" },
			default = { "Identifier", "#7C3AED" },
		},
		search = {
			command = "rg",
			args = {
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
			},
			-- regex that will be used to match keywords.
			-- don't replace the (KEYWORDS) placeholder
			pattern = [[\b(KEYWORDS):]], -- ripgrep regex
			-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
		},
	},
})
