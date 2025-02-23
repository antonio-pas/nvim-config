return {
  -- {
  --   'daschw/leaf.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function ()
  --     require("leaf").setup({
  --       transparent = true,
  --       contrast = 'low'
  --     })
  --
  --     vim.cmd("colorscheme leaf")
  --   end
  -- },
  -- {
  --   "craftzdog/solarized-osaka.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function ()
  --     require('solarized-osaka').setup({
  --       transparent = true,
  --     })
  --     vim.cmd[[colorscheme solarized-osaka]]
  --   end
  -- },
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_transparent_background = 1
      vim.g.gruvbox_material_foreground = 'mix'
      vim.cmd [[colorscheme gruvbox-material]]
      vim.api.nvim_set_hl(0, "TabLineFill", { bg = 'NONE' })
    end
  },
}
