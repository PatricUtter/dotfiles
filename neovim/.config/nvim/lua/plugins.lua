vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function()
   use 'wbthomason/packer.nvim'

   use {
       'neovim/nvim-lspconfig',
       'williamboman/nvim-lsp-installer',
   }

   -- Gruvbox!!!
   use { "ellisonleao/gruvbox.nvim" }

   -- Navigate between nvim and tmux windows
   use {
       'numToStr/Navigator.nvim',
       config = function()
           require('Navigator').setup()
       end
       }

   use {
     'nvim-telescope/telescope.nvim',
     requires = { {'nvim-lua/plenary.nvim'} }
   }

   use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

   use 'folke/lsp-colors.nvim'

   -- nvim-cmp completion sources
   use { 'hrsh7th/cmp-nvim-lsp' }
   use { 'hrsh7th/cmp-buffer' }
   use { 'hrsh7th/cmp-path' }
   use { 'hrsh7th/cmp-cmdline' }
   use { 'hrsh7th/nvim-cmp' }
end)
