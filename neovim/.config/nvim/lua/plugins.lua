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

	use({ "nvim-treesitter/nvim-treesitter" })

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

	-- Snippets
	use({ "L3MON4D3/LuaSnip" })

	-- Null ls
	use({ "jose-elias-alvarez/null-ls.nvim" })

	-- Comment.nvim
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	-- vim-surround
	use({ "tpope/vim-surround" })

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
end)
