vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require("packer").startup(function()
  use("wbthomason/packer.nvim")

  use({
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
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

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
  })

  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use({ "nvim-telescope/telescope-ui-select.nvim" })

  use("folke/lsp-colors.nvim")

  -- nvim-cmp completion sources
  use({ "hrsh7th/cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-buffer" })
  use({ "hrsh7th/cmp-path" })
  use({ "hrsh7th/cmp-cmdline" })
  use({ "hrsh7th/nvim-cmp" })
  use({ "hrsh7th/cmp-nvim-lua" })
  use({ "rcarriga/cmp-dap" })

  -- Snippets
  use({ "L3MON4D3/LuaSnip" })
  use({ "rafamadriz/friendly-snippets" })

  -- Null ls
  use({ "jose-elias-alvarez/null-ls.nvim" })
  use({ "jose-elias-alvarez/typescript.nvim" })

  -- todo remove
  --use({ "jose-elias-alvarez/nvim-lsp-ts-utils" })

  -- Comment.nvim
  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  })

  -- Session handling
  use({ "tpope/vim-obsession" })

  -- vim-surround
  use({ "tpope/vim-surround" })
  use({ "tpope/vim-repeat" })

  -- -- auto brackets
  -- use({
  -- 	"steelsojka/pears.nvim",
  -- 	config = function()
  -- 		require("pears").setup()
  -- 	end,
  -- })

  -- gitsigns
  use({
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
  })

  use({ "ThePrimeagen/harpoon" })

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
  use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
  -- DAP node
  use({ "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } })
  -- Java support
  use("mfussenegger/nvim-jdtls")

  -- Database
  use({ "tpope/vim-dadbod" })
  use({ "kristijanhusak/vim-dadbod-ui" })
  use({ "kristijanhusak/vim-dadbod-completion" })

  -- Markdown
  use({ "iamcco/markdown-preview.nvim" })

  -- Undotree
  use({ "mbbill/undotree" }) -- check if it makes sense to move to a lua verion
end)
