return {
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function ()
      require("mini.icons").setup()
      require("mini.pairs").setup()
      require("mini.jump2d").setup()
      require("mini.move").setup()
      require("mini.surround").setup()
      require("mini.bracketed").setup()
      require("mini.statusline").setup()
      require("mini.tabline").setup()
    end
  },
}
