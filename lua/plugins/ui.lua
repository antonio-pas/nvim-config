return {
  { "karb94/neoscroll.nvim", opts = {} },
  { "lukas-reineke/indent-blankline.nvim", config = function()
    require("ibl").setup({
      indent = { char = "▏"},
      scope = {
        enabled = false,
      }
    })
  end},
  {
    "romgrk/barbar.nvim",
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      icons = {
        button = "×",
        separator = { left = "", right = "" },
        separator_at_end = false,
      },
    },
    config = function (_, opts)
      require("barbar").setup(opts)
      require("which-key").add( {
        { "<C-n>", "<cmd>BufferNext<cr>", desc = "Next buffer" },
        { "<C-p>", "<cmd>BufferPrevious<cr>", desc = "Previous buffer" },
      })
    end
  },
  { "lewis6991/gitsigns.nvim", opts = {} },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { 'help', 'NvimTree' },
        globalstatus = false,
      },
    },
  },
  { "j-hui/fidget.nvim", tag = "legacy", opts = {} },
}
