local function border(hl_name)
	return {
		{ "╭", hl_name }, -- ┌
		{ "─", hl_name },
		{ "╮", hl_name }, -- ┐
		{ "│", hl_name },
		{ "╯", hl_name }, -- ┘
		{ "─", hl_name },
		{ "╰", hl_name }, -- └
		{ "│", hl_name },
	}
end
return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "onsails/lspkind.nvim" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
		},
		opts = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end
			return {
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 25, ellipsis_char = "…" })(
							entry,
							vim_item
						)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = strings[1] or ""
						kind.menu = strings[2] or ""

						return kind
					end,
				},
				window = {
					completion = {
						border = border("Comment"),
						winhighlight = "Normal:Normal,CursorLine:CursorLine",
						scrollbar = "",
					},
					documentation = {
						border = border("Comment"),
						winhighlight = "Normal:Normal",
						scrollbar = "",
					},
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif cmp.visible() then
							cmp.select_next_item()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}),
			}
		end,
	},
	{ "L3MON4D3/LuaSnip" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "b0o/SchemaStore.nvim" },
}
