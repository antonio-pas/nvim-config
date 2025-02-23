return {
  'nvim-treesitter/nvim-treesitter', config = function()
    require('nvim-treesitter.configs').setup({
      indent = { enable = true },
      highlight = { enable = true }
    })
  end
}
