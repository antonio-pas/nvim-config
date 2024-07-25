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
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = 'E',
            [vim.diagnostic.severity.WARN] = 'W',
            [vim.diagnostic.severity.HINT] = 'H',
            [vim.diagnostic.severity.INFO] = 'I',
          },
          linehl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
            [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
            [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
            [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
            [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
            [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
            [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
          },
        },
      })
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities()
			)
			require("util").on_attach(function(_, buffer)
        require("which-key").add( {
          { "<leader>a", group = "actions" },
          { "<leader>ac", vim.lsp.buf.code_action, desc = "Code Action" },
          { "<leader>af", vim.lsp.buf.format, desc = "Format Document" },
          { "<leader>ar", vim.lsp.buf.rename, desc = "Rename Token" },
          { "<leader>d", group = "diagnostic" },
          { "<leader>da", "<cmd>Telescope diagnostics<cr>", desc = "Show All Diagnostics" },
          { "<leader>dn", vim.diagnostic.get_next, desc = "Go to Next Diagnostic" },
          { "<leader>do", vim.diagnostic.open_float, desc = "Open Diagnostic On Current Line" },
          { "<leader>dp", vim.diagnostic.get_next, desc = "Go to Previous Diagnostic" },
          { "<leader>g", group = "go to" },
          { "<leader>gD", vim.lsp.buf.declaration, desc = "Go to Declaration" },
          { "<leader>gd", vim.lsp.buf.definition, desc = "Go to Definition" },
          { "<leader>i", group = "info" },
          { "<leader>ih", vim.lsp.buf.hover, desc = "Hover Info" },
          { "<leader>is", vim.lsp.buf.signature_help, desc = "Signature Help" },
        })
			end)
			for name, server_options in pairs(opts.servers) do
				local settings = vim.tbl_extend("force", server_options, { capabilities = capabilities })
				require("lspconfig")[name].setup(settings)
			end
		end,
	},
}
