return {
	{
		"neovim/nvim-lspconfig",
    dependencies = {
      { "folke/neodev.nvim", opts = {} },
    },
		opts = {
			servers = {
				svelte = {},
        prismals = {},
        pyright = {},
				cssls = {},
				eslint = {},
        tailwindcss = {},
        ccls = {},
        html = {},
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
        severity_sort = true,
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
			require("util").on_attach(function(_, buffer)
        require("which-key").register({
          d = {
            name = "diagnostic",
            a = { "<cmd>Telescope diagnostics<cr>", "Show All Diagnostics" },
            o = { function() vim.diagnostic.open_float(nil, { scope="cursor" }) end, "Open Diagnostic On Current Line" },
            n = { vim.diagnostic.get_next, "Go to Next Diagnostic" },
            p = { vim.diagnostic.get_prev, "Go to Previous Diagnostic" },
          },
          g = {
            name = "go to",
            d = { vim.lsp.buf.definition, "Go to Definition" },
            D = { vim.lsp.buf.definition, "Go to Declaration" }
          },
          a = {
            name = "actions",
            r = { vim.lsp.buf.rename, "Rename Token" },
            f = { vim.lsp.buf.format, "Format Document" },
            c = { vim.lsp.buf.code_action, "Code Action" },
          },
          i = {
            name = "info",
            h = { vim.lsp.buf.hover, "Hover Info" },
            s = { vim.lsp.buf.signature_help, "Signature Help"}
          }
        }, { prefix = "<leader>", buffer = buffer })
			end)
			for name, server_options in pairs(opts.servers) do
				local settings = vim.tbl_extend("force", server_options, { capabilities = capabilities })
				require("lspconfig")[name].setup(settings)
			end
		end,
	},
}
