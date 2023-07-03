return {
	{ "karb94/neoscroll.nvim", opts = {} },
	{ "akinsho/bufferline.nvim", opts = {} },
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				globalstatus = true,
			},
		},
	},
	{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },
}
