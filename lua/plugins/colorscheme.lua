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
			vim.cmd([[colorscheme onedark]])
		end,
	},
}
