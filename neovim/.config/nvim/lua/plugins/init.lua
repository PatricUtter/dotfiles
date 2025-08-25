return {
  { "nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate" },
  { "neovim/nvim-lspconfig" },
  -- Navigate between nvim and tmux windows
  { "numToStr/Navigator.nvim",         opts = {} },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },

  {
    "mason-org/mason.nvim",
    opts = {

    }
  },
  {
    'saghen/blink.cmp',
    version = '1.*',
  },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
   "tpope/vim-fugitive"
  },
	{
		"ThePrimeagen/harpoon",
		lazy = true,
		branch = "harpoon2",
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},

}
