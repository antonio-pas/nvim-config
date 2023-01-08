require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'ryanoasis/vim-devicons'
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
  use {
    'Saecki/crates.nvim',
    config = function () require('crates').setup() end
  }
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
  use  { 'jacoborus/tender.vim' }
  use {
    'akinsho/toggleterm.nvim',
    config = function ()
      require('toggleterm').setup({})
    end
  }
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    'akinsho/bufferline.nvim',
    tag = "v3.*",
    requires = 'nvim-tree/nvim-web-devicons',
    config = function ()
      require('bufferline').setup({})
    end}
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
    tag = 'nightly',
    config = function ()
      require('nvim-tree').setup({})
    end
  }
end)
require('plugins.lsp')
require('plugins.cmp')
require('plugins.telescope')
require('plugins.theme')
