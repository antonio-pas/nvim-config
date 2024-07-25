return {
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
      local inc = require("nvim-treesitter.incremental_selection");
      require("which-key").add({
        { "<leader>ss", inc.init_selection, desc = "Init Treesitter Selection" },
      })

			require("nvim-treesitter.configs").setup({
				highlight = { enable = true },
				indent = { enable = true },
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
