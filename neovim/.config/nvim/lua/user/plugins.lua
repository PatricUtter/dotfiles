vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require("packer").startup(function()
	use("wbthomason/packer.nvim")

	use({
		"neovim/nvim-lspconfig",
		"williamboman/nvim-lsp-installer",
	})

	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

	-- Gruvbox!!!
	use({ "ellisonleao/gruvbox.nvim" })
	use({ "sainnhe/gruvbox-material" })

	-- Navigate between nvim and tmux windows
	use({
		"numToStr/Navigator.nvim",
		config = function()
			require("Navigator").setup()
		end,
	})

	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	use("folke/lsp-colors.nvim")

	-- nvim-cmp completion sources
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-cmdline" })
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lua" })

	-- Snippets
	use({ "L3MON4D3/LuaSnip" })

	-- Null ls
	use({ "jose-elias-alvarez/null-ls.nvim" })

	-- Nvim-lsp-ts-utils, seems to be broken -> https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils/issues/112
	-- try again when fixed
	use({ "jose-elias-alvarez/nvim-lsp-ts-utils" })

	-- Comment.nvim
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	-- vim-surround
	use({ "tpope/vim-surround" })

	-- auto brackets
	use({
		"steelsojka/pears.nvim",
		config = function()
			require("pears").setup()
		end,
	})

	-- gitsigns
	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

	-- nvim-tree
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
	})

	-- Hop
	use({
		"phaazon/hop.nvim",
		branch = "v1", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	})

	-- Status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- Tokyo night colorscheme
	use("folke/tokyonight.nvim")

	-- Todo comments
	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
	})

	-- Fugitive
	use("tpope/vim-fugitive")

	-- DAP
	use("mfussenegger/nvim-dap")

	-- Java support
	use("mfussenegger/nvim-jdtls")

	-- Database
	use({ "tpope/vim-dadbod" })
	use({ "kristijanhusak/vim-dadbod-ui" })
	use({ "kristijanhusak/vim-dadbod-completion" })
end)
