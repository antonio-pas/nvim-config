return {
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = { enable = true },
				indent = { enable = true },
				autotag = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<leader>s", -- set to `false` to disable one of the mappings
            node_incremental = "i",
            node_decremental = "u",
            scope_incremental = "s",
          },
        },
			})
		end,
	},
}
