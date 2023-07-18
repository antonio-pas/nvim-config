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
      wk.register({
        ["<C-p>"] = { "<cmd>bprev<cr>", "Previous buffer" },
        ["<C-n>"] = { "<cmd>bnext<cr>", "Next buffer" },
        ["<leader>q"] = { "<cmd>qa<cr>", "Quit" },
        ["<leader>l"] = { "<cmd>Telescope oldfiles<cr>", "Recent Files" }
      })
      wk.register({
        ["<esc>"] = { "<C-\\><C-n>", "Escape" }
      }, { mode = "t" })
    end
  },
  {
    "phaazon/hop.nvim",
    opts = {},
    config = function(opts, _)
      require("hop").setup(opts)
      local wk = require("which-key")
      wk.register({
        h = {
          name = "hop",
          w = { "<cmd>HopWord<cr>", "Hop Word" },
          a = { "<cmd>HopAnywhere<cr>", { "Hop Anywhere" } }
        }
      }, { prefix = "<leader>" })
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {borderchars = {
        --{ '─', '│', '─', '│', '┌', '┐', '┘', '└'},
        prompt = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
        results = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
        preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
      }}
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      local t = require("telescope.builtin")
      local wk = require("which-key")
      wk.register({
        t = {
          name = "telescope",
          t = { "<cmd>Telescope<cr>", "Open Telescope" },
          f = { t.find_files, "Find File" },
          g = { t.live_grep, "Live Grep" },
          h = { t.help_tags, "Help Tags" },
          b = { t.buffers, "Buffer" },
        },
      }, { prefix = "<leader>" })
    end
  }
}
