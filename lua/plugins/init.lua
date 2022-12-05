require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function ()
      require('nvim-treesitter.configs').setup({
        highlight = {
          enable = true
        },
        indent = {
          enable = true
        },
        autotag = {
          enable = true
        }
      })
    end
  }
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'onsails/lspkind.nvim'
  use 'windwp/nvim-ts-autotag'
  use {
    'windwp/nvim-autopairs',
    config = function ()
      require('nvim-autopairs').setup({})
    end
  }
  use {
    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  }
  use 'ellisonleao/gruvbox.nvim'
  use {
    'akinsho/toggleterm.nvim',
    config = function ()
      require('toggleterm').setup({})
    end
  }
end)
require('plugins.lsp')
require('plugins.cmp')
