return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'saghen/blink.cmp',
        dependencies = 'rafamadriz/friendly-snippets',
        version = 'v0.8.1',
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
          keymap = { preset = 'default' },

          appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono'
          },
        },
      },
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    opts = {
      servers = {
        html = {},
        cssls = {},
        tailwindcss = {},
        clangd = {},
        ts_ls = {},
        rust_analyzer = {},
        pyright = {},
        lua_ls = {}
      }
    },
    config = function(_, opts)
      local lspconfig = require('lspconfig')
      for server, config in pairs(opts.servers) do
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end
  }
}
