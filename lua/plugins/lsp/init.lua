return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				svelte = {},
				cssls = {},
				eslint = {},
				lua_ls = {
					settings = {
						Lua = {
							telemetry = {
								enable = false,
							},
              completion = {
                callSnippet = "Replace"
              }
						},
					},
				},
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							signatureInfo = {
								detail = "parameters",
							},
						},
					},
					cmd = { "rustup", "run", "stable", "rust-analyzer" },
				},
				tsserver = {},
				jsonls = {
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},
			},
		},
		config = function(_, opts)
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities()
			)
			require("util").on_attach(function(client, buffer)
				require("plugins.lsp.keymaps").on_attach(client, buffer)
			end)
			for name, server_options in pairs(opts.servers) do
				local settings = vim.tbl_extend("force", server_options, { capabilities = capabilities })
				require("lspconfig")[name].setup(settings)
			end
		end,
	},
}
