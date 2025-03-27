return {
	-- Mason
	{ "williamboman/mason.nvim", lazy = true },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "neovim/nvim-lspconfig" },
	-- Treesitter
	{ "nvim-treesitter/nvim-treesitter" },
	-- Gruvbox!!!
	{ "ellisonleao/gruvbox.nvim" },
	{ "sainnhe/gruvbox-material" },
	-- Navigate between nvim and tmux windows
	{ "numToStr/Navigator.nvim", opts = {} },
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{ "nvim-telescope/telescope-ui-select.nvim" },
	{ "folke/lsp-colors.nvim" },
	-- nvim-cmp completion sources
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lua" },
	{ "rcarriga/cmp-dap" },
	-- Snippets
	{ "L3MON4D3/LuaSnip", lazy = true },
	{ "rafamadriz/friendly-snippets", lazy = true },
	-- Null ls TODO migrate to something else, not maintained
	{ "jose-elias-alvarez/null-ls.nvim" },
	{ "jose-elias-alvarez/typescript.nvim" },
	-- Comment.nvim
	{ "numToStr/Comment.nvim", opts = {} },
	-- Session handling
	{ "tpope/vim-obsession" },
	-- vim-surround
	{ "tpope/vim-surround" },
	{ "tpope/vim-repeat" },
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"ThePrimeagen/harpoon",
		lazy = true,
		branch = "harpoon2",
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},
	-- nvim-tree
	{
		"kyazdani42/nvim-tree.lua",
		lazy = true,
		dependencies = {
			"kyazdani42/nvim-web-devicons",
		},
	},
	-- Oil.nvim
	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
		--dependencies = { { "echasnovski/mini.icons", opts = {} } },
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	},

	{
		"phaazon/hop.nvim",
		branch = "v1", -- optional but strongly recommended
		opts = { keys = "etovxqpdygfblzhckisuran" },
	},
	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons", opt = true },
	},
	-- Tokyo night colorscheme
	{ "folke/tokyonight.nvim" },
	-- Todo comments
	{
		"folke/todo-comments.nvim",
		lazy = true,
		dependencies = "nvim-lua/plenary.nvim",
	},
	-- Fugitive
	{ "tpope/vim-fugitive" },

	-- DAP
	{ "jay-babu/mason-nvim-dap.nvim", lazy = true },
	{ "mfussenegger/nvim-dap", lazy = true },
	{
		"rcarriga/nvim-dap-ui",
		lazy = true,
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	},
	{ "theHamsta/nvim-dap-virtual-text", lazy = true },
	-- DAP node
	{ "mxsdev/nvim-dap-vscode-js", lazy = true, requires = { "mfussenegger/nvim-dap" } },
	-- Database
	{ "tpope/vim-dadbod" },
	{ "kristijanhusak/vim-dadbod-ui" },
	{ "kristijanhusak/vim-dadbod-completion" },

	-- Markdown
	{ "iamcco/markdown-preview.nvim", lazy = true },

	-- Undotree
	{ "mbbill/undotree" }, -- check if it makes sense to move to a lua verion
	-- Java
	{ "nvim-java/nvim-java" },
}
