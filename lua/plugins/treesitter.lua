return {
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
      local inc = require("nvim-treesitter.incremental_selection");
      require("which-key").register({
        name = "treesitter",
        s = { inc.init_selection, "Init Treesitter Selection"}
      }, { prefix = "<leader>s" })

			require("nvim-treesitter.configs").setup({
				highlight = { enable = true },
				indent = { enable = true },
				autotag = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            node_incremental = "i",
            node_decremental = "u",
            scope_incremental = "s",
          },
        },
			})
		end,
	},
}
