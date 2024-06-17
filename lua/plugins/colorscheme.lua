return {
  {
    "navarasu/onedark.nvim",
    opts = {
      highlights = {
        ["@constructor"] = { fmt = "none" },
        ["@text.title"] = { fmt = "none" },
      },
    },
    config = function(_, opts)
      require("onedark").setup(opts)
      -- vim.cmd([[colorscheme onedark]])
    end,
  },
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    config = function(_, _)
      --vim.cmd([[colorscheme gruvbox-material]])
    end
  },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    config = function(_, _)
      require('solarized-osaka').setup({
        transparent = true
      })
      vim.cmd([[colorscheme solarized-osaka]])
    end
  },
  {
    "cpea2506/one_monokai.nvim",
    lazy = false,
    config = function()
      require('one_monokai').setup({
        transparent = true
      })
    end
  }
}
