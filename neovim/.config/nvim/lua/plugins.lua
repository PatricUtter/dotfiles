vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function()
   use 'wbthomason/packer.nvim' 

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
end)
