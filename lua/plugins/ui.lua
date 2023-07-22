return {
  { "karb94/neoscroll.nvim",   opts = {} },
  {
    "romgrk/barbar.nvim",
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      icons = {
        button = "×",
        separator = { left = "", right = "" },
        separator_at_end = false,
      },
      sidebar_filetypes = { NvimTree = true }
    },
    config = function (_, opts)
      require("barbar").setup(opts)
      require("which-key").register({
        ["<C-p>"] = { "<cmd>BufferPrevious<cr>", "Previous buffer" },
        ["<C-n>"] = { "<cmd>BufferNext<cr>", "Next buffer" },
      }, {})
    end
  },
  { "lewis6991/gitsigns.nvim", opts = {} },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      actions = {
        open_file = {
            quit_on_open = true,
        },
      },
    },
    config = function (_, opts)

      require("nvim-tree").setup(opts)
      require("which-key").register({
        t = { "<cmd>NvimTreeToggle<cr>", "Toggle Tree" },
        f = { "<cmd>NvimTreeFindFile<cr>", "Find Current File in Tree" },
      }, { prefix = "<leader>r" })
    end
  },
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
