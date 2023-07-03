return {
	{
		"neovim/nvim-lspconfig",
    dependencies = {
      { "folke/neodev.nvim", opts = {} },
    },
		opts = {
			servers = {
				svelte = {},
				cssls = {},
				eslint = {},
        ccls = {},
				lua_ls = {
					settings = {
            Lua = {
              runtime = {
                version = 'LuaJIT',
              },
              diagnostics = {
                globals = {'vim'},
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
              },
              telemetry = {
                enable = false,
              },
              completion = {
                callSnippet = "Replace"
              }
            }
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
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
      vim.diagnostic.config({
        virtual_text = {
          source = "if_many",
          prefix = "▎",
        },
        update_in_insert = false,
        severity_sort = false,
        float = {
          source = "if_many",
        },
      })
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
