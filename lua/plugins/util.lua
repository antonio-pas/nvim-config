return {
  { "numToStr/Comment.nvim",         opts = {} },
  { "kylechui/nvim-surround",        opts = {} },
  { "windwp/nvim-autopairs",         opts = { fast_wrap = {} } },
  { "windwp/nvim-ts-autotag",        opts = {} },
  { "christoomey/vim-tmux-navigator" },
  {
    "folke/which-key.nvim",
    opts = {},
    config = function(_, _)
      local wk = require("which-key")
      wk.add({
        { "<leader>l", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
        { "<leader>q", "<cmd>qa<cr>", desc = "Quit" },
      })
      wk.add({
        { "<esc>", { "<C-\\><C-n>", "Escape" }, mode = "t" }
      })
    end
  },
  {
    "phaazon/hop.nvim",
    opts = {},
    config = function(opts, _)
      require("hop").setup(opts)
      local wk = require("which-key")
      wk.add({
        { "<leader>ha", desc = "<cmd>HopAnywhere<cr>" },
        { "<leader>hw", "<cmd>HopWord<cr>", desc = "Hop Word" },
      })
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {},
    -- opts = {
    --   defaults = {borderchars = {
    --     --{ '─', '│', '─', '│', '┌', '┐', '┘', '└'},
    --     prompt = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
    --     results = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
    --     preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
    --   }}
    -- },
    config = function(_, opts)
      require("telescope").setup(opts)
      local t = require("telescope.builtin")
      local wk = require("which-key")
      wk.add({
        { "<leader>t", group = "telescope" },
        { "<leader>tb", t.buffers, desc = "Buffer" },
        { "<leader>tf", t.find_files, desc = "Find Files" },
        { "<leader>tg", t.live_grep, desc = "Live Grep" },
        { "<leader>th", t.help_tags, desc = "Help Tags" },
        { "<leader>tt", "<cmd>Telescope<cr>", desc = "Open Telescope" },
      })
    end
  }
}
